use v6;
use NativeCall;

module Compress::Brotli:ver<0.1.0> {

  #======================================
  # Native functions
  #======================================

  sub compress_buffer(Config,Int,CArray[uint8], CArray[int], CArray[uint8] --> Int) 
    is native('libsimplebrotli') { * }
  sub decompress_buffer(Int,CArray[uint8], CArray[int]--> CArray[uint8]) 
    is native('libsimplebrotli') { * }
  sub clear_internal_buffer() is native('libsimplebrotli') { * }

  #======================================
  # Exceptions
  #======================================

  class X::Compress::Brotli is Avro::AvroException {
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
	  return compress($str.encode("UTF-8"));
  }

  multi sub compress(Blob $data) { 
    # default config
    my $conf = Config.new(0,11,22,0);
    my $in_size = $data.bytes();
    my $input = CArray[uint8].new();
	  $input[$_] = $data[$_] for ^$data.bytes;
    my $max_out_size = 1.2 * $in_size  + 10240;
    my $out_size = to_pointer($max_out_size);
    X::Compress::Brotli.new(:message("Failed to compress!")).throw()
      unless compress_buffer($conf,$in_size,$input,$out_size,$array);
	  return Buf.new: map {$array[$_]}, ^$out_size[0];
  }

  sub decompress(Blob $data --> Buf) is export 
  { 
    my $input= CArray[uint8].new();
	  $input[$_] = $data[$_] for ^$data.bytes;
    my $array = decompress_buffer($in_size,$input,$out_size);
    X::Compress::Brotli.new(:message("Failed to decompress")).throw() 
      unless (^$out_size[0] >= 0);
	  my $res = Buf.new: map {$array[$_]}, ^$out_size[0];
    clear_internal_buffer(); #once copied we can clear the buffer
    return $res;
  }

}

