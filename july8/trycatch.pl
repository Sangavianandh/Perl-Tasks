use strict;
use warnings;
my $file;
my $file1=eval
{
open( $file, "<play.pl");
};
unless($file1)
{
print "\ncould not open the file $@";
}
print $file1;

