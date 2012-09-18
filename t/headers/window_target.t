use strict;
use CGI;
use Test::More tests => 1;

my $CRLF = $CGI::CRLF;

subtest '-target' => sub {
    my $cgi = CGI->new;

    my $got = $cgi->header( -target => 'ResultsWindow' );
    my $expected
        = "Window-Target: ResultsWindow$CRLF"
        . "Content-Type: text/html; charset=ISO-8859-1$CRLF"
        . $CRLF;
    is $got, $expected, 'a plain string';

    $got = $cgi->header( -target => q{} );
    $expected = 'Content-Type: text/html; charset=ISO-8859-1' . $CRLF x 2;
    is $got, $expected, 'an empty string';

    $got = $cgi->header( -target => undef );
    $expected = 'Content-Type: text/html; charset=ISO-8859-1' . $CRLF x 2;
    is $got, $expected, 'undef';
};
