#!/usr/bin/perl
use JSON;
use strict;
use warnings;
my %hash = ('sangavi' => 1, 'anu' => 2, 'boopathi' => 3, 'gowri' => 4, 'niranjana' => 5);
my $json = encode_json \%hash;
#my $json1= decode_json \$json;
print "$json\n";
#print "$json1\n";
