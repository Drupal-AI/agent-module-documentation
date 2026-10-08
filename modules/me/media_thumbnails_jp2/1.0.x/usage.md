<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Media Thumbnails Jp2 is a plugin for the Media Thumbnails framework that generates JPEG preview thumbnails for JP2 (JPEG 2000, `image/jp2`) media entities.

---

JP2 is not renderable by browsers, so media entities backed by JP2 files have no usable preview. This module registers a `@MediaThumbnail` plugin (`MediaThumbnailJp2`) scoped to the `image/jp2` MIME type; the framework invokes its `createThumbnail()` when such media is created, which resizes the JP2 to a configurable width and writes a managed `.jpg` thumbnail alongside the source (falling back to the generic media icon if generation fails). It requires the ImageMagick/Imagick support to be present on the server (with JP2 delegate support compiled into ImageMagick) and is a small, route-less, permission-less add-on to the Media Thumbnails project.

Setup: ensure ImageMagick with JP2 support and the Imagick PHP extension are installed, then enable the module; thumbnails are produced automatically on JP2 media creation.

---

- Generate a JPEG preview thumbnail for a JP2 (JPEG 2000) media entity
- Add usable previews for browser-unrenderable JP2 files
- Produce thumbnails automatically when JP2 media is created
- Resize the source to a configurable thumbnail width (default 500px)
- Show JP2 previews in Views via the media thumbnail field
- Show JP2 previews in media entity display modes
- Apply a Drupal image style on top of the generated thumbnail
- Fall back to the generic media icon when generation fails
- Extend the Media Thumbnails framework for the `image/jp2` MIME type
- Require ImageMagick with JP2 delegate support plus the Imagick PHP extension
- Install as a thin add-on to the media_thumbnails project
- Review generated thumbnails written alongside the source as `<uri>.jpg`
- Understand the module has no routes, permissions, or config forms of its own
