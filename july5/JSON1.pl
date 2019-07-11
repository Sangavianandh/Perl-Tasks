use JSON;
use Data::Dumper;
use strict;
use warnings;
my $hash='{"sangavi":1,"anu":2,"gowri":3,"boopathi":4}';
my $dec=decode_json($hash);
print  Dumper($dec);
