# EXIF Orientation — manual setup guide

**EXIF Orientation** (`exif_orientation`) fixes sideways and upside‑down photos
automatically. Many phones and cameras (iPhone 4 and up, for example) save every
picture in the sensor's native landscape orientation and record how it *should*
be displayed in the image's EXIF `Orientation` tag, rather than physically
rotating the pixels. Browsers and image toolkits often ignore that tag, so the
photo shows up rotated. This module reads the tag when an image is uploaded and
physically rotates the stored file so it is already the right way up everywhere
it appears.

The whole thing happens at upload time. When an image file is saved, the module
reads its EXIF data with PHP's `exif_read_data()` and rotates the master file
using Drupal's image toolkit. Because it corrects the *stored* image, every image
style and derivative generated afterwards (thumbnails, responsive crops) inherits
the corrected orientation too. It only touches JPEG and PNG files, and only the
three rotation‑only orientation values — 3 (180°), 6 (90°) and 8 (270°). Images
with no Orientation tag are left completely untouched, so nothing is needlessly
re‑encoded.

There is nothing to configure. The module has no settings form, no permissions,
and no image‑style effect to add — enabling it *is* the entire setup. It does need
PHP's EXIF extension to be available; if that extension is missing, the module
quietly does nothing.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

There are no steps beyond installing and enabling the module. Once it is on, every
image uploaded to any image field — profile pictures, media library images,
webform file submissions, and so on — is checked and rotated automatically:

| EXIF `Orientation` | Rotation applied |
|---|---|
| 3 | 180° |
| 6 | 90° |
| 8 | 270° |
| 1 / missing / other | none |

A couple of things worth knowing:

- Only **JPEG and PNG** files are processed; other formats are ignored.
- Only the **rotation‑only** values above are corrected. Mirrored/flipped
  (odd‑numbered) orientations are not handled.
- The module slots its own rotation step *ahead* of core's image‑resolution
  resizing, so the photo is rotated before any resize can strip its EXIF data.

To confirm PHP's EXIF extension is present, run `php -m | grep exif` (or
`ddev exec 'php -m | grep exif'` with DDEV).
