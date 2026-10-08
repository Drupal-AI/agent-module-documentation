# Media Thumbnails Word — manual setup guide

**Media Thumbnails Word** (`media_thumbnails_word`) generates image preview
thumbnails for **Word document** media, so `.doc` and `.docx` files show a
meaningful thumbnail in the media library, in reference-field widgets, and in
listings — instead of a generic file icon.

It plugs into the
[Media Thumbnails](https://www.drupal.org/project/media_thumbnails) framework. When a
Word file is added as media, the module loads the document with **PhpWord**, converts
it to a PDF with the **mPDF** renderer, rasterises the **first page** with
**Imagick**, flattens transparency onto white, scales it to the framework's
configured width, and writes a managed `.jpg` next to the source file — the same
approach Media Thumbnails PDF uses.

All processing runs **server-side** on files uploaded by editors, so the practical
risks are the usual document-processing ones: keep PhpWord, mPDF, and Imagick
patched. Unlike some thumbnail plugins, this one does have a small settings form —
where you tell it the mPDF library path — described in
[Configuration](configuration/index.md).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, satisfy the
   ImageMagick and library requirements, and enable the module.
2. [Configuration](configuration/index.md) — set the mPDF library path on the
   settings form.

## Where it lives in the admin menu

The module's settings form sits at **Configuration → Media → Media Thumbnails Word
settings** (`/admin/config/media/media-thumbnails-word-settings`).

## How to use it

Once enabled and configured, thumbnails are generated automatically whenever a
`.doc` or `.docx` file is added as a media entity. To display them, add the media
**thumbnail** field to your Views or media display modes and optionally apply an
image style, as with any other Media Thumbnails plugin. Supported file types are
**`.doc`** and **`.docx`**.
