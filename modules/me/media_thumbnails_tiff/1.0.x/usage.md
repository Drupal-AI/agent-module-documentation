<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Media Thumbnails Tiff plugs into the Media Thumbnails framework to generate JPG preview thumbnails for TIFF media entities using the Imagick (ImageMagick) PHP extension.
---
The module contributes a single `MediaThumbnail` plugin (`media_thumbnail_tiff`, mime `image/tiff`) extending `MediaThumbnailBase`. Its `createThumbnail($sourceUri)` resolves the source URI to a real local path via the file system (Imagick can't use stream wrappers), reads the first page of the TIFF (`$im->readimage($path . '[0]')`) inside a try/catch, flattens transparency onto a white background, scales the image down to the framework-configured width (default 500px) if larger, converts it to JPG, and writes the result as a managed file (`<uri>.jpg`) through the `file.repository` service. Every Imagick step is wrapped in exception handling that logs a warning and returns NULL on failure, and a guard returns early if the `imagick` extension isn't loaded.

`hook_requirements()` reports an install/runtime error if the ImageMagick PHP extension is missing; the module also needs the ImageMagick and Ghostscript binaries on the host. Security-wise there is no `shell_exec`/`exec` or other shell invocation — all image handling goes through the Imagick object API, not command-line ImageMagick, which avoids shell-argument injection. The source path comes from an already-stored media file's URI (resolved with `realpath`), not from request input, and the output filename is derived from that URI. Standard ImageMagick/TIFF hardening still applies at the environment level (a suitable ImageMagick `policy.xml` and a patched Ghostscript are recommended, since parsing untrusted TIFFs is inherently risky), but the module itself introduces no unsafe file or command handling and has no routes, permissions, or services.
---
- Generate preview thumbnails for uploaded TIFF files.
- Add a "thumbnail" field to TIFF media display modes.
- Show TIFF previews in Views listings.
- Apply an image style to the generated TIFF thumbnail.
- Render the first page of a multi-page TIFF as a JPG.
- Flatten transparent TIFFs onto a white background.
- Automatically scale thumbnails to the configured width (default 500px).
- Provide media-library previews for TIFF assets.
- Rely on the Media Thumbnails framework for the thumbnail workflow.
- Verify the Imagick PHP extension via `hook_requirements()`.
- Install ImageMagick + Ghostscript binaries for TIFF/PDF support.
- Convert TIFF previews to web-friendly JPG output.
- Store thumbnails as managed files alongside the source.
- Log and skip gracefully when a TIFF can't be read.
- Avoid shell execution (uses the Imagick API, not `exec`).
- Harden ImageMagick `policy.xml` when processing untrusted TIFFs.
- Give editors visual confirmation of TIFF uploads.
- Use TIFF thumbnails in cards, teasers, and grids.
- Regenerate thumbnails after changing the configured width.