<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Image Scale and Crop (Without Upscale) (image_scale_and_crop_without_upscale) — agent index

Provides a single image-style **effect**, "Scale and crop (without upscale)", that behaves like
core's Scale and Crop (crop to the target aspect ratio) but never enlarges a source image that is
smaller than the target — it shrinks the target box instead. Aspect ratio is preserved; the output
may simply be smaller than the configured dimensions.

- Dependency: core `image` (`drupal:image`). Core requirement `^9 || ^10 || ^11`.
- No settings page / `configure` route, no permissions, no services, no drush, no blocks/fields.
- The effect is configured per image style (Admin > Config > Media > Image styles), reusing core's
  Scale-and-Crop config form (width / height / anchor).
- Defines config schema; ships one `post_update` hook.

Solutions:
- **Add / configure the effect on an image style (width, height, anchor); how the no-upscale math works** → [plugins/image_effect.md](plugins/image_effect.md)

Key facts:
- Plugin id: `image_scale_and_crop_without_upscale` (annotation `@ImageEffect`), label "Scale and crop (without upscale)".
- Class: `Drupal\image_scale_and_crop_without_upscale\Plugin\ImageEffect\ScaleAndCropWithoutUpscaleImageEffect` — extends core `Drupal\image\Plugin\ImageEffect\ScaleAndCropImageEffect`.
- Config schema key: `image.effect.image_scale_and_crop_without_upscale` (`type: image_size` → integer `width`/`height`, plus `anchor` string).
- Config data keys on the effect: `width` (int), `height` (int), `anchor` (string, e.g. `center-center`).
- Post-update: `image_scale_and_crop_without_upscale_post_update_fix_data_types` — casts stored `width`/`height` from string to int in existing `image.style.*` config without flushing derivatives.
- No new plugin *type* is defined; this is a plugin instance of core's image-effect type. It plugs into the core image-style pipeline (derivatives regenerate on image-style flush).
