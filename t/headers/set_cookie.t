use strict;
use CGI;
use CGI::Util 'expires';
use CGI::Cookie;
use Test::More tests => 1;

my $CRLF = $CGI::CRLF;

subtest '-cookie' => sub {
    my $cgi = CGI->new;

    my $got = $cgi->header( -cookie => 'foo' );
    my $expected
        = "Set-Cookie: foo$CRLF"
        . "Date: " . expires(0, 'http') . $CRLF
        . "Content-Type: text/html; charset=ISO-8859-1$CRLF"
        . $CRLF;
    is $got, $expected, 'a plain string';

    $got = $cgi->header( -cookie => ['foo', 'bar']  );
    $expected
        = "Set-Cookie: foo$CRLF"
        . "Set-Cookie: bar$CRLF"
        . "Date: " . expires(0, 'http') . $CRLF
        . "Content-Type: text/html; charset=ISO-8859-1$CRLF"
        . $CRLF;
    is $got, $expected, 'plain strings';

    # NOTE: It seems the Date header shouldn't appear
    $got = $cgi->header( -cookie => []  );
    $expected
        = "Date: " . expires(0, 'http') . $CRLF
        . "Content-Type: text/html; charset=ISO-8859-1$CRLF"
        . $CRLF;
    is $got, $expected, 'null array';

    $got = $cgi->header( -cookie => q{} );
    $expected = 'Content-Type: text/html; charset=ISO-8859-1' . $CRLF x 2;
    is $got, $expected, 'empty string';

    $got = $cgi->header( -cookie => undef );
    $expected = 'Content-Type: text/html; charset=ISO-8859-1' . $CRLF x 2;
    is $got, $expected, 'undef';

    my $cookie1 = CGI::Cookie->new(
        -name  => 'foo',
        -value => 'bar',
    );

    my $cookie2 = CGI::Cookie->new(
        -name  => 'bar',
        -value => 'baz',
    );

    my $cookie3 = CGI::Cookie->new( -name => 'baz' );

    $got = $cgi->header( -cookie => $cookie1 );
    $expected
        = "Set-Cookie: foo=bar; path=/$CRLF"
        . "Date: " . expires(0, 'http') . $CRLF
        . "Content-Type: text/html; charset=ISO-8859-1$CRLF"
        . $CRLF;
    is $got, $expected, 'a CGI::Cookie object';

    $got = $cgi->header( -cookie => [$cookie1, $cookie2] );
    $expected
        = "Set-Cookie: foo=bar; path=/$CRLF"
        . "Set-Cookie: bar=baz; path=/$CRLF"
        . "Date: " . expires(0, 'http') . $CRLF
        . "Content-Type: text/html; charset=ISO-8859-1$CRLF"
        . $CRLF;
    is $got, $expected, 'CGI::Cookie objects';

    $got = $cgi->header( -cookie => $cookie3 );
    $expected = 'Content-Type: text/html; charset=ISO-8859-1' . $CRLF x 2;
    is $got, $expected, 'a CGI::Cookie object without value';
};
