# Perl6 Brotli Compression
[![Build Status](https://travis-ci.org/sylvarant/Compress-Brotli.svg?branch=master)](https://travis-ci.org/sylvarant/Compress-Brotli)

Provides acces to [Brotli compression](https://github.com/google/brotli) by means of the perl6 NativeCall API.  

## An Example

A simple compression/decompression round trip can be written as follows. 

```Perl6
use Compress::Brotli; 

my $blob = compress("a simple string");
my $buffer = decompress($blob);
say $buffer.decode('UTF-8');
```

## License

[Artistic License 2.0](http://www.perlfoundation.org/artistic_license_2_0)
