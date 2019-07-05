use LWP::UserAgent;
my $ua = LWP::UserAgent->new;
$ua->_agent("MyApp/0.1 ");
# Create a request
my $req = HTTP::Request->new(GET => 'http://search.cpan.org/search');
# Pass request to the user agent
my $res = $ua->request($req);
# Check the response
if ($res->is_success) 
{
    print $res->content_decoded;
}
else
{
    print $res->status_line, "\n";
}

