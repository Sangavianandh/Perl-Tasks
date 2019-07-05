package My::Client;
use strict;
use warnings;
use LWP::UserAgent;
my $ua = LWP::UserAgent->new();
$ua->env_proxy;
my $resp = $ua->get( 'http://www.example.com' );
say $resp->decoded_content;
