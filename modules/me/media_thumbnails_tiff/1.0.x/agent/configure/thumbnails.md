<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Generating TIFF thumbnails

## Requirements
- `drupal/media_thumbnails` (framework)
- PHP `imagick` extension (checked by `hook_requirements()`)
- ImageMagick + Ghostscript binaries on the host

## How it works
The `media_thumbnail_tiff` plugin handles the `image/tiff` mime type. `createThumbnail($sourceUri)`:
1. Guards on `extension_loaded('imagick')` (logs a warning, returns NULL if absent).
2. Resolves the URI to a real path with the file system (Imagick has no stream-wrapper support).
3. `readimage($path . '[0]')` — reads the first TIFF page (try/catch).
4. Flattens transparency onto a white background.
5. Scales down to the framework width setting (`$this->configuration['width']`, default 500) if wider.
6. Converts to JPG and writes `<sourceUri>.jpg` as a managed file via `file.repository`.

## Usage
Add the media **thumbnail** field to your TIFF media type display modes or Views, optionally with an image style. Thumbnails are produced through the Media Thumbnails framework workflow.

## Hardening
Parsing untrusted TIFFs is inherently risky at the ImageMagick level. Configure a restrictive ImageMagick `policy.xml` and keep Ghostscript patched. The module itself uses the Imagick API (no shell) and only processes already-stored file URIs.
