use v6;
use NativeCall;

module Compress::Brotli:ver<0.1.0>{

  # from Compress::Snappy
	# Simulate an int pointer with a CArray
  sub _int_pointer(Int $value = 0) {
	  my $intpointer = CArray[int].new();
	  $intpointer[0] = $value;
	  return $intpointer;
  }

  sub compress_buffer(Int,CArray[uint8], CArray[int], CArray[uint8] --> Int) is native('libsimplebrotli') { * }
  sub decompress_buffer(Int,CArray[uint8], CArray[int], CArray[uint8] --> Int) is native('libsimplebrotli') { * }

  our proto compress(Mu --> Buf) is export { * } 

  multi sub compress(Str $data) {
	  return compress($str.encode("UTF-8"));
  }

  multi sub compress(Blob $data) { 

    my $in_size = $data.bytes();
    my $max_out_size = 1.2 * $in_size  + 10240;

  
    compress_buffer($in_size,
  }

  sub decompress(Blob --> Buf) is export { * }


}

