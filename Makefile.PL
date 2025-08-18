use lib '.';
use inc::Module::Install;

license('GPL Version 2');
author('Richard G Harman Jr <rtx-attachmentszip+richard@richardharman.com>');
RTx 'RT-Extension-AttachmentZip';

requires('Archive::Zip');
requires_rt '4.0.0';
rt_too_new '4.6.0';

version_from('lib/RT/Extension/AttachmentZip.pm');

my ($lib_path) = $INC{'RT.pm'} =~ /^(.*)[\\\/]/;
my $local_lib_path = "$RT::LocalPath/lib";
unshift @INC, $local_lib_path, $lib_path;


substitute(
    { RT_LIB_PATH => "$RT::LocalPath/lib " . File::Basename::dirname( $INC{'RT.pm'} ) },
    { sufix => '.in' },
    'xt/lib/RT/Extension/AttachmentZip/Test.pm',
);

sign;
WriteAll;
