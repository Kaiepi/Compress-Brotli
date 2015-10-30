use v6;
use NativeCall;

module Compress::Brotli:ver<0.1.0>{

  sub compress_buffer(Int,CArray[uint8], CArray[int], CArray[uint8] --> Int) is native('libsimplebrotli') { * }
  sub decompress_buffer(Int,CArray[uint8], CArray[int], CArray[uint8] --> Int) is native('libsimplebrotli') { * }

  our proto compress(Mu --> Buf) is export { * } 

  multi sub compress(Str $data) {
	  return compress($str.encode("UTF-8"));
  }

  multi sub compress(Blob $data) { * }

  sub decompress(Blob --> Buf) is export { * }


}

