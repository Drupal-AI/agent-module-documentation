# Media Thumbnails Jp2 — manual setup guide

**Media Thumbnails Jp2** (`media_thumbnails_jp2`) generates JPEG preview thumbnails
for **JP2 (JPEG 2000)** media. Browsers cannot render JP2 files directly, so a media
entity backed by a `.jp2` file normally has no usable preview — this module fills
that gap by producing a standard `.jpg` thumbnail from the source.

It plugs into the
[Media Thumbnails](https://www.drupal.org/project/media_thumbnails) framework: when a
JP2 media entity is created, it resizes the source to a configurable width (default
500px) and writes a managed `.jpg` alongside it, falling back to the generic media
icon if generation fails. Conversion is done with **ImageMagick**, which must be
built with **JP2 delegate support** and paired with the Imagick PHP extension (see
[Installation](installation/index.md)).

This module processes uploaded JP2 files server-side. Keep ImageMagick patched and apply a suitable ImageMagick `policy.xml`
when handling untrusted image files.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, satisfy the
   ImageMagick/JP2 requirement, and enable the module.

There is **no configuration page** for this module — it has no routes, permissions,
or settings of its own. Once enabled it works automatically through the Media
Thumbnails framework; see "How to use it" below.

## How to use it

Once enabled, thumbnails are generated automatically whenever a `.jp2` file is added
as a media entity. To display them, add the media **thumbnail** field to your Views
or media display modes and optionally apply an image style, as with any other Media
Thumbnails plugin.
