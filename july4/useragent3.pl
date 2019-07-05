
use strict;
use warnings;
use LWP::UserAgent;
my $ua = LWP::UserAgent->new;
$ua->env_proxy;
my $response = $ua->get('http://www.example.com');
print $response->decoded_content; 
my $req = HTTP::Request->new( GET => 'https://api.flickr.com/services/
+rest');
 $response = $ua->request($req);
print "\nhiiii";
print $req;
print "\n$response";
print "\nconnected";
