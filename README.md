# RT-Extension-AttachmentZip

Download all attachments of an RT ticket as a single ZIP archive.

## Features

- Adds **Current** and **All** download buttons to the ticket attachment section
- **Current** — one file per filename (newest version only)
- **All** — all revisions, each prefixed with its attachment ID
- Correct handling of **non-ASCII filenames** (Cyrillic, Chinese, Arabic, Hebrew, Thai, etc.) — filenames are stored as UTF-8 in the ZIP with the standard Unicode flag (bit 11) set
- Handles filenames stored in older RT databases as Latin-1 / Windows-1252 bytes
- Compatible with RT 5 and RT 6 (Bootstrap 5, HTMX, jQuery)

## Requirements

- RT 5.0.0 or newer (tested with RT 6)
- Perl module: `Archive::Zip` (1.68+)

## Installation

```bash
perl Makefile.PL
make
sudo make install
```

Add the plugin to your RT configuration (`RT_SiteConfig.pm` or a file in `RT_SiteConfig.d/`):

```perl
Plugin('RT::Extension::AttachmentZip');
```

Clear the Mason cache and restart the web server:

```bash
sudo systemctl stop apache2
sudo rm -rf /opt/rt6/var/mason_data/obj/*
sudo systemctl start apache2
```

## Usage

Open any ticket that has attachments. Above the attachment list you will see:

```
Download attachments as ZIP:  [Current]  [All]
```

| Button  | Behaviour |
|---------|-----------|
| Current | Downloads one file per unique filename (newest version wins) |
| All     | Downloads every revision; filenames are prefixed with the attachment ID |

The ZIP is named `Ticket_<id>_attachments.zip` and the files are placed in a `ticket_<id>/` folder inside the archive.

## Technical notes

### Filename encoding

RT stores attachment filenames in its database. Depending on the RT version and the uploading client, filenames may arrive as:

- **Perl unicode strings** (modern RT with a UTF-8 database connection) — used as-is
- **Raw bytes in UTF-8** — detected and decoded
- **Raw bytes in Latin-1 / Windows-1252** — decoded via CP1252 fallback

The ZIP entry's filename is always stored as a proper Perl unicode string. Archive::Zip 1.68+ encodes it to UTF-8 bytes and sets **bit 11 (0x0800)** of the general-purpose bit flag, which signals to any standard ZIP tool that the filename is UTF-8 encoded (per PKWARE APPNOTE §4.4.4).

### HTMX / jQuery compatibility

- Download links carry `data-hx-boost="false"` so HTMX does not intercept the navigation and try to inject the binary response into the DOM.
- The download bar is suppressed during jQuery's `ShowAll` AJAX reload (detected via `X-Requested-With: XMLHttpRequest`) to prevent it from appearing twice when the full attachment list is expanded.

## RT version history

| Version | Notes |
|---------|-------|
| 3.0 | RT 5/6 port: Bootstrap 5 UI, HTMX fix, UTF-8 filename fix, binary streaming |
| 2.0 | RT 4 release by Richard G Harman Jr |

## Authors

- Torsten Brumm (RT 5/6 port, UTF-8 filename fix)
- Richard G Harman Jr (original RT 4 version)
- Gregor Wolter (contributor)

## License

GPL Version 2
