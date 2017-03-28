NAME
    RT::Extension::AttachmentZip - Download Attachments from RT Ticket

DESCRIPTION
    This is an extension for Best Practical's Request Tracker
    http://www.bestpractical.com/rt

    This extension permits you to download the attachments associated with a ticket as a zip file.

    There are two options:

    1) current
    2) all

    Current mode downloads just the most recent revision of the attached file
    All mode downloads _all_ the revisions, and prepends the revision id number to the filename.

INSTALLATION
    perl Makefile.PL
    make
    make install
        May need root permissions

    Until the new Callback "AfterAttachmentTitleBox" isn't in place, you have to change manuelly
    the file: share/html/Ticket/Elements/ShowAttachments and the the line:
    % $m->callback( %ARGS, CallbackName => 'AfterAttachmentTitleBox', TicketObj => $Ticket );
    
    Git Pull Request: https://github.com/bestpractical/rt/pull/214/files

    Edit your /opt/rt4/etc/RT_SiteConfig.pm
        If you are using RT 4.2 or greater, add this line:

            Plugin('RT::Extension::AttachmentZip');

        For RT 4.0, add this line:

            Set(@Plugins, qw(RT::Extension::AttachmentZip));

        or add RT::Extension::SideBySideView to your existing @Plugins line.

    Clear your mason cache
            rm -rf /opt/rt4/var/mason_data/obj

    Restart your webserver

AUTHORS
    Torsten Brumm  <technik@picturepunxx.de>
    Richard Harman <richard+rtx-attachmentzip@richardharman.com>


LICENCE
    This library is free software; you can redistribute it and/or modify it
    under the same terms as Perl itself.

THANKS
    Torsten Brumm
    Gregor Wolter
    Richard Harman

