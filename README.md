# Perl6 Brotli Compression

Provides acces to [Brotli compression](https://github.com/google/brotli) by means NativeCall.  

## TODO

This is a work in progress.
- [ ] : Test Linux Support

## An Example

A simple round trip can be written as follows. 

```Perl6
use Compress::Brotli; 

my $blob = compress("a simple string");
my $buffer = decompress($blob);
say $buffer.decode('UTF-8');
```

## License

[Artistic License 2.0](http://www.perlfoundation.org/artistic_license_2_0)
