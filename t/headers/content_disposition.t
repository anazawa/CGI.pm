use strict;
use CGI;
use Test::More tests => 1;

my $CRLF = $CGI::CRLF;

subtest 'attachment' => sub{
    my $cgi = CGI->new;

    my $got = $cgi->header( -attachment => 'genome.jpg' );
    my $expected
        = qq{Content-Disposition: attachment; filename="genome.jpg"$CRLF}
        . qq{Content-Type: text/html; charset=ISO-8859-1$CRLF}
        . $CRLF;
    is $got, $expected;

    $got = $cgi->header( -attachment => q{} );
    $expected = 'Content-Type: text/html; charset=ISO-8859-1' . $CRLF x 2;
    is $got, $expected, 'empty string';

    $got = $cgi->header( -attachment => undef );
    $expected = 'Content-Type: text/html; charset=ISO-8859-1' . $CRLF x 2;
    is $got, $expected, 'undef';
};
