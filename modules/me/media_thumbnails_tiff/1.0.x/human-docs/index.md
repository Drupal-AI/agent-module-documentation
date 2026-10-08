# Media Thumbnails Tiff — manual setup guide

**Media Thumbnails Tiff** (`media_thumbnails_tiff`) generates JPG preview thumbnails
for **TIFF** media. Like JP2, TIFF images are not renderable by browsers, so this
module produces a web-friendly `.jpg` preview so TIFF assets show properly in the
media library, Views, teasers, cards, and grids.

It plugs into the
[Media Thumbnails](https://www.drupal.org/project/media_thumbnails) framework. When a
TIFF media entity is created, it reads the **first page** of the TIFF, flattens any
transparency onto a white background, scales the image down to the framework's
configured width (default 500px) if it is larger, converts it to JPG, and stores the
result as a managed file next to the source. All image handling goes through the
**Imagick** PHP extension's object API (not shell commands), and every step is
wrapped in error handling that logs a warning and skips gracefully if a TIFF cannot
be read.

Processing untrusted TIFF files is inherently a document-processing risk, so
environment-level hardening still applies: use a suitable ImageMagick `policy.xml`
and keep a patched Ghostscript in place. The module itself introduces no routes,
permissions, or shell execution.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, satisfy the
   ImageMagick requirement, and enable the module.

There is **no configuration page** for this module — it has no routes, permissions,
or settings of its own. Once enabled it works automatically through the Media
Thumbnails framework; see "How to use it" below.

## How to use it

Once enabled, thumbnails are generated automatically whenever a TIFF file is added
as a media entity. To display them, add the media **thumbnail** field to your Views
or media display modes and optionally apply an image style, as with any other Media
Thumbnails plugin. If you later change the framework's configured thumbnail width,
regenerate thumbnails to pick up the new size.
