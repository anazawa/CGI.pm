use strict;
use CGI;
use Test::More tests => 1;

my $CRLF = $CGI::CRLF;

subtest '-p3p' => sub {
    my $cgi = CGI->new;

    my $got = $cgi->header( -p3p => "CAO DSP LAW CURa" );
    my $expected
        = qq{P3P: policyref="/w3c/p3p.xml", CP="CAO DSP LAW CURa"$CRLF}
        . qq{Content-Type: text/html; charset=ISO-8859-1$CRLF}
        . $CRLF;
    is $got, $expected, 'a plain string';

    $got = $cgi->header( -p3p => [qw/CAO DSP LAW CURa/] );
    $expected
        = qq{P3P: policyref="/w3c/p3p.xml", CP="CAO DSP LAW CURa"$CRLF}
        . qq{Content-Type: text/html; charset=ISO-8859-1$CRLF}
        . $CGI::CRLF;
    is $got, $expected, 'plain strings';

    # NOTE: It seems the P3P header shouldn't appear
    $got = $cgi->header( -p3p => [] );
    $expected
        = qq{P3P: policyref="/w3c/p3p.xml", CP=""$CRLF}
        . qq{Content-Type: text/html; charset=ISO-8859-1$CRLF}
        . $CGI::CRLF;
    is $got, $expected, 'null array';

    $got = $cgi->header( -p3p => q{} );
    $expected = 'Content-Type: text/html; charset=ISO-8859-1' . $CRLF x 2;
    is $got, $expected, 'empty string';

    $got = $cgi->header( -p3p => undef );
    $expected = 'Content-Type: text/html; charset=ISO-8859-1' . $CRLF x 2;
    is $got, $expected, 'undef';
};
