
use strict;
use warnings;
 
use LWP::UserAgent ();
 
my $ua = LWP::UserAgent->new(timeout => 1000000);
$ua->env_proxy;
 
my $response = $ua->get('http://www.example.com');
 
if ($response->is_success) {
    print $response->decoded_content;
}
else {
    die $response->status_line;
}
