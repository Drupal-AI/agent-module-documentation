<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Imagick — agent index

Registers an alternative **image toolkit** (id `imagick`) driven by the PHP Imagick
(ImageMagick) extension, plus ~35 extra `ImageEffect` plugins for image styles. Requires the
`imagick` PHP extension on the server.

- **Select the toolkit, `imagick.config` settings (JPEG quality, strip metadata, optimize, resize filter)** →
  [configure/toolkit.md](configure/toolkit.md)
- **The extra image-style effects (ids), how to add one to a style, and the `imagick_*` operations** →
  [configure/effects.md](configure/effects.md)

Key facts:
- Toolkit plugin id: `imagick`. Select it at `system.image_toolkit_settings`
  (`/admin/config/media/image-toolkit`); the active toolkit is stored in config
  `system.image` key `toolkit`.
- Toolkit settings config object: `imagick.config` → `jpeg_quality` (75), `resize_filter`
  (22), `optimize` (true), `strip_metadata` (true).
- Effect plugin ids are `image_*` (e.g. `image_blur`, `image_composite`, `image_polaroid`);
  each maps to a toolkit operation `imagick_*`. Effects work in an image style once added.
