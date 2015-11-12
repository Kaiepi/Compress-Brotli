use v6;
use Test;
use lib 'lib';
use Compress::Brotli;

plan 5;

my $simple = "test data ";
my $blob = compress($simple);
ok 1, "compress executed";
my $buffer = decompress($blob);
my $res = decode_str($buffer);
ok 1, "decompress executed";
is $res,$simple,"Succesfully roundtripped small test data";

my $large = (map { (roll 10, "0".."z") } ,^1000).join(" ");
$blob = compress($large);
ok ($blob.bytes() < $large.chars()), "compressed string is smaller";
$buffer = decompress($blob);
$res = decode_str($buffer);
is $res,$large,"Succesfully roundtripped large test data";

