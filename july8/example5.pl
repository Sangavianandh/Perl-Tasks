use strict;
use warnings;       
#this program checks the starting and ending point of the word and prints the output as per
#our requirements
my @lines = ("   - Foo",
                  "0asd asf safd 1",
                  "0  - Baz 1",
                  "0   - Quux");
my @fo = @fo[0 .. $#fo]; 
        foreach (@lines) {
            if (/^0/ and /1$/) {
                print "$_\n";
            }
        }
