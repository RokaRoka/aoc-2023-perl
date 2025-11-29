package Common;
use strict;
use warnings FATAL => "all";

use Exporter 'import';

our @EXPORT_OK = qw( println );

sub println # (args)
{
    my $str = shift();
    print "$str\n";
}

return 1;
