package Common;
use strict;
use warnings FATAL => "all";

use Exporter 'import';

our @EXPORT_OK = qw( println contains );

use Array::Utils qw(array_minus);

sub println # (args)
{
    my $str = shift();
    print "$str\n";
}

sub contains (\@\@) # see if A contains B
{
    my $arrA = shift ();
    my $arrB = shift ();
    println ("Arr A contents: " . '[' . join (',', @{$arrA}) . ']');
    println ("Arr B contents: " . '[' . join (',', @{$arrB}) . ']');
    return scalar (array_minus (@{$arrB}, @{$arrA})) == 0;
    # my %c = map { $_ => undef } @{$_[1]};
    # foreach my $key (keys %c)
    # {
    #     println $key;
    # };
    # foreach my $value (values %c)
    # {
    #     println $value;
    # };

    # return 1;
}

return 1;
