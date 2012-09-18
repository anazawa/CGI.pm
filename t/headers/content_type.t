use strict;
use CGI;
use Test::More tests => 3;

my $CRLF = $CGI::CRLF;

subtest '-type' => sub {
    my $cgi = CGI->new;

    my $got = $cgi->header( -type => 'text/plain' );
    my $expected = 'Content-Type: text/plain; charset=ISO-8859-1' . $CRLF x 2;
    is $got, $expected, 'a plain string';

    $got = $cgi->header( -type => 'text/plain; charset=utf-8' );
    $expected = 'Content-Type: text/plain; charset=utf-8' . $CRLF x 2;
    is $got, $expected, '-type contains -charset';

    $got = $cgi->header( -type => q{} );
    $expected = $CRLF x 2;
    is $got, $expected, 'an empty string';

    $got = $cgi->header( -type => undef );
    $expected = 'Content-Type: text/html; charset=ISO-8859-1' . $CRLF x 2;
    is $got, $expected, 'undef';
};

subtest '-charset' => sub {
    my $cgi = CGI->new;

    my $got = $cgi->header( -charset => 'utf-8' );
    my $expected = 'Content-Type: text/html; charset=utf-8' . $CRLF x 2;
    is $got, $expected, 'a plain string';

    $got = $cgi->header( -charset => q{} );
    $expected = 'Content-Type: text/html' . $CRLF x 2;
    is $got, $expected, 'an empty string';

    $got = $cgi->header( -charset => undef );
    $expected = 'Content-Type: text/html' . $CRLF x 2;
    is $got, $expected, 'undef';
};

subtest '-type and -charset' => sub {
    my $cgi = CGI->new;

    my $got = $cgi->header(
        '-type'    => 'text/plain',
        '-charset' => 'utf-8',
    );
    my $expected = 'Content-Type: text/plain; charset=utf-8' . $CRLF x 2;
    is $got, $expected, 'both of -type and -charset are defined';

    $got = $cgi->header(
        '-type'    => q{},
        '-charset' => 'utf-8',
    );
    $expected = $CGI::CRLF x 2;
    is $got, $expected, '-type is an empty string, -charset is defined';

    $got = $cgi->header(
        '-type'    => 'text/plain; charset=utf-8',
        '-charset' => q{},
    );
    $expected = 'Content-Type: text/plain; charset=utf-8' . $CRLF x 2;
    is $got, $expected, '-type contains -charset, -charset is an empty string';

    $got = $cgi->header(
        '-type'    => 'text/plain; charset=utf-8',
        '-charset' => 'euc-jp',
    );
    $expected = 'Content-Type: text/plain; charset=utf-8' . $CRLF x 2;
    is $got, $expected, '-type contains -charset, -charset is defined';
};
