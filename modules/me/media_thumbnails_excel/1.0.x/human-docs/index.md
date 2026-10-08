# Media Thumbnails Excel — manual setup guide

**Media Thumbnails Excel** (`media_thumbnails_excel`) generates real preview images
for **Excel spreadsheet** media, so `.xls` and `.xlsx` files show a meaningful
thumbnail in the media library and in listings instead of a generic file icon.

It plugs into the
[Media Thumbnails](https://www.drupal.org/project/media_thumbnails) framework. When
an Excel file is added as media, the module uses **PhpSpreadsheet** and **mPDF** to
convert the spreadsheet into a PDF, then renders an image from the first page — the
same approach Media Thumbnails PDF uses. This all happens **server-side**, so the
module needs the ImageMagick PHP extension and the supporting PHP libraries present
(see [Installation](installation/index.md)).

Because it processes uploaded spreadsheet files with document/image libraries, treat
uploaded files as untrusted input: keep ImageMagick, PhpSpreadsheet, and mPDF
patched, and apply the usual document-processing hardening for your environment.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, satisfy the
   ImageMagick requirement, and enable the module.

There is **no configuration page** for this module. Once enabled it works
automatically through the Media Thumbnails framework; see "How to use it" below.

## How to use it

Once enabled, thumbnails are generated automatically whenever an `.xls` or `.xlsx`
file is added as a media entity. To display them, add the media **thumbnail** field
to your Views or media display modes (and optionally apply an image style), just as
you would for any other Media Thumbnails plugin.
