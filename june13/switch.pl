use strict;
use warnings;
use Switch;
my $var =<STDIN>;
my @array = (10, 20, 30);
my %hash = ('key1' => 10, 'key2' => 20);

switch($var) {
   case 10           { print "number 100\n"; next; }
   case "a"          { print "string a" }
   case [1..10,42]   { print "number in list" }
   case (\@array)    { print "number in list" }
   case (\%hash)     { print "entry in hash" }
   else              { print "previous case not true" }
}
