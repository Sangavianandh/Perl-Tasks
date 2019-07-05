    use strict;
    use warnings;
    use 5.010;
    use LWP::UserAgent;
    my $ua = LWP::UserAgent->new;
$ua->env_proxy;
    my $resp = $ua->get( 'http://www.example.com' );
    if ($resp->is_success) {
        say $resp->decoded_content;
    } else {
        say $resp->status_line;
        say $resp->decoded_content;
    }
