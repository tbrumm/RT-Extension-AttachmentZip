use strict;
use warnings;

### after: use lib qw(@RT_LIB_PATH@);
use lib qw(/opt/rt4/local/lib /opt/rt4/lib);

package RT::Extension::AttachmentZip::Test;
use base 'RT::Test';

sub import {
    my $class = shift;
    my %args  = @_;

    $args{'requires'} ||= [];
    if ( $args{'testing'} ) {
        unshift @{ $args{'requires'} }, 'RT::Extension::AttachmentZip';
    } else {
        $args{'testing'} = 'RT::Extension::AttachmentZip';
    }

    $class->SUPER::import( %args );
    $class->export_to_level(1);

    require RT::Extension::AttachmentZip;
}

1;
