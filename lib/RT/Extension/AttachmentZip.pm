package RT::Extension::AttachmentZip;

our $VERSION = '3.0';

=head1 NAME

RT::Extension::AttachmentZip - Download all ticket attachments as a zip archive

=head1 DESCRIPTION

Adds download links to the ticket attachment list allowing users to download
all attachments (or only the latest version of each) as a single zip file.

Non-UTF-8 filenames (e.g. Latin-1 / Windows-1252) are decoded and stored as
UTF-8 inside the zip with the appropriate Unicode flag set.

=head1 RT VERSION

Works with RT 5 and RT 6.

=head1 INSTALLATION

    perl Makefile.PL
    make
    sudo make install

Add to F</opt/rt6/etc/RT_SiteConfig.pm>:

    Plugin('RT::Extension::AttachmentZip');

Clear Mason cache and restart Apache after installation.

=head1 AUTHOR

Torsten Brumm, based on work by Richard G Harman Jr and Gregor Wolter.

=head1 LICENSE

GPL Version 2.

=cut

1;
