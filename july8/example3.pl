use strict;
use warnings;
my $x=<STDIN>;
chomp($x);
my $y=<STDIN>;
chomp($y);
print "Even\n" if ($x & 1) == 0;
 print "false\n" if ($x | $y) == 10;
