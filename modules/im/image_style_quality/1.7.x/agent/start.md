# Image Style Quality — agent index

Adds a configurable **`image_style_quality`** image effect that sets output quality (0–100,
default 75) **per image style**. At apply time it overrides the active toolkit's quality config
(`setModuleOverride`) rather than editing pixels. Depends on core `image`. No routes, permissions,
or Drush.

- **Add the effect to an image style; the `quality` setting and how it works** →
  [configure/image-effect.md](configure/image-effect.md)
- **The `mutable_quality_toolkits` plugin type (map a toolkit → its quality config) + alter hook** →
  [plugins/mutable-quality-toolkits.md](plugins/mutable-quality-toolkits.md)

Key facts:
- Effect plugin id `image_style_quality`; config schema `image.effect.image_style_quality` with
  one key `quality` (integer, default 75).
- Defines plugin type `mutable_quality_toolkits` (service
  `image_style_quality.mutable_quality_toolkit_manager`), shipped for `gd`
  (`system.image.gd:jpeg_quality`), `imagemagick` (`imagemagick.settings:quality`), `imagick`
  (`imagick.config:jpeg_quality`).
