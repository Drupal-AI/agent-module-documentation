# Auto Rotate Lite — manual setup guide

**Auto Rotate Lite** (`auto_rotate_lite`) adds a single image-style effect that
straightens photos using their EXIF orientation flag. Phone cameras often store
a picture "sideways" and record an orientation tag that says how to turn it;
browsers do not always honour that tag, so uploaded photos can appear rotated.
This effect reads the tag and rotates the derivative to match.

It works only on JPEG and TIFF images. For those, it rotates the derivative
180°, 90°, or 270° (for EXIF orientation values 3, 6, and 8) and adjusts the
computed width and height so the image style still reports the correct
dimensions. The rotation is applied when the image *style* is rendered, so your
original uploaded file is never changed.

It is a lightweight, self-contained alternative to the full Image Effects suite
or the EXIF Orientation module (which rotates on upload). It depends only on
Drupal core, the GD image toolkit, and PHP's `exif` extension. If EXIF data is
missing or the format is not JPEG/TIFF, it leaves the image untouched.

There is no settings page — the module is just the effect, which you add to an
image style. Because of that, this guide has two parts: an overview (this page)
and installation.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Auto Rotate Lite has no settings page. You use it from the image-style editor at
**Configuration → Media → Image styles**
(`/admin/config/media/image-styles`).

## How to use it

1. Go to **Configuration → Media → Image styles** and edit (or add) an image
   style.
2. In **Effect**, choose **Auto Rotate Lite** and add it.
3. Save the image style. You can combine it with scale/crop effects in the same
   style.
4. Use that image style anywhere images are displayed (image fields, media
   fields, responsive image style mappings). JPEG and TIFF images are now
   auto-straightened on display, while the original uploads stay untouched.

**Note:** the site's PHP needs the `exif` extension available for the effect to
read orientation data. When EXIF is absent or the image is not JPEG/TIFF, the
image is passed through unchanged.
