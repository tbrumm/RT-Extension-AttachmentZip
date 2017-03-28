use strict;
use warnings;

use lib 'xt/lib';
use RT::Extension::AttachmentZip:Test nodb => 1, tests => undef;

require_ok("RT::Extension::AttachmentZip");
require_ok("RT::Extension::AttachmentZip::Test");

done_testing;
