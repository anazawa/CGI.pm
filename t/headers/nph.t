use strict;
use CGI;
use CGI::Util 'expires';
use Test::More tests => 1;

my $CRLF = $CGI::CRLF;

subtest 'nph' => sub {
    my $cgi = CGI->new;

    my $got = $cgi->header( -nph => 0 );
    my $expected = 'Content-Type: text/html; charset=ISO-8859-1' . $CRLF x 2;
    is $got, $expected, 'false';

    $got = $cgi->header( -nph => 1 );
    $expected
        = "HTTP/1.0 200 OK$CRLF"
        . "Server: cmdline$CRLF"
        . "Date: " . expires(0, 'http') . $CRLF
        . "Content-Type: text/html; charset=ISO-8859-1$CRLF"
        . $CRLF;
    is $got, $expected, 'true';
};
