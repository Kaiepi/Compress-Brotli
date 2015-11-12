use v6;
use NativeCall;

module Compress::Brotli:ver<0.1.0> {


  #======================================
  # Native functions
  #======================================
  constant LIBNAME = 'libperl6brotli';

  sub compress_buffer(Int,CArray[uint8], CArray[int], CArray[uint8], CArray[int] --> Int) 
    is native(LIBNAME) { * }
  sub decompress_buffer(Int,CArray[uint8], CArray[int]--> CArray[uint8]) 
    is native(LIBNAME) { * }
  sub clear_internal_buffer() is native(LIBNAME) { * }

  #======================================
  # Exceptions
  #======================================

  class X::Compress::Brotli is Exception {
    has $.message;
    method message { "Brotli failed: $!message" }
  }

  #======================================
  # Config for brotli compression
  #======================================
  
  class Config is repr('CStruct') {
    has int $.mode;
    has int $.quality;
    has int $.lgwin;
    has int $.lgblock;
  }

  # from Compress::Snappy
	# Simulate an int pointer with a CArray
  sub to_pointer(Int $value = 0) {
	  my $intpointer = CArray[int].new();
	  $intpointer[0] = $value;
	  return $intpointer;
  }

  #======================================
  # The brotli interface
  #======================================

  our proto compress(Mu --> Buf) is export { * } 

  multi sub compress(Str $data) {
	  return compress($data.encode("UTF-8"));
  }

  multi sub compress(Blob $data) { 
    # default config
    #my $conf = Config.new(:mode(0),:quality(11),:lgwin(22),:lgblock(0));
    my $conf = CArray[int].new();
    $conf[0] = 0;
    $conf[1] = 11;
    $conf[2] = 22;
    $conf[3] = 0;
    my Int $in_size = $data.bytes();
    my $input = CArray[uint8].new();
	  $input[$_] = $data[$_] for ^$data.bytes;
    say $input[2];
    my $max_out_size = 1.2 * $in_size  + 10240;
    my $out_size = to_pointer($max_out_size.Int);
    my $array = CArray[uint8].new();
    $array[$_] = 0 for ^$max_out_size;
    say compress_buffer($in_size,$input,$out_size,$array,$conf);
    X::Compress::Brotli.new(:message("Failed to compress!")).throw()
      unless compress_buffer($in_size,$input,$out_size,$array,$conf);
	  return Buf.new: map {$array[$_]}, ^$out_size[0];
  }

  sub decompress(Blob $data --> Buf) is export 
  { 
    my $input= CArray[uint8].new();
	  $input[$_] = $data[$_] for ^$data.bytes;
    my $out_size = to_pointer(0);
    my $array = decompress_buffer($data.bytes(),$input,$out_size);
    X::Compress::Brotli.new(:message("Failed to decompress")).throw() 
      unless (^$out_size[0] >= 0);
	  my $res = Buf.new: map {$array[$_]}, ^$out_size[0];
    clear_internal_buffer(); #once copied we can clear the buffer
    return $res;
  }

  sub decode_str(Buf $data --> Str) is export
  {
    return $data.decode("UTF-8");
  }

}

