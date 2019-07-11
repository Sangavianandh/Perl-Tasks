use strict;
use warnings;
use 5.12.0;
use IO::Handle;
use LWP::UserAgent;
my $bound=IO::Handle->new();
my $bound1=LWP::UserAgent->new();
unless($bound1 ~~ /\bUserAgent\b/)
{
say "It matches with IOboundry";
}
else if($bound ~~ /\bIO\b/)
{
say "nothing has matched";
}
