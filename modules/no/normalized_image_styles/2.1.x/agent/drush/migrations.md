<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Enabling and importing normalized image styles

## Enable
1. Enable the parent module and the specific aspect-ratio sub-modules you need
   (each sub-module = one ratio, e.g. `normalized_image_styles_landscape_16x9`,
   or its WebP twin `normalized_image_styles_webp_landscape_16x9`):
   `drush en normalized_image_styles normalized_image_styles_landscape_16x9 -y`

## Import (materialise the image styles)
- All enabled sets at once (they share migration tag `normalized`):
  `drush migrate:import --tag normalized`  (alias `drush mim --tag normalized`)
- Check status / machine names: `drush migrate:status`
- UI equivalent: `/admin/structure/migrate/manage/normalized_image_styles/migrations`

## Roll back / remove a set
- `drush migrate:rollback --tag normalized` (or a single migration id) removes the
  generated styles for that set.

## After import
- The generated image styles are normal config entities (`/admin/config/media/image-styles`).
- You may uninstall all `normalized_image_styles*` modules; the styles persist.
- **Keep `focal_point` and `image_style_quality` installed** — the generated styles
  use their effects (`focal_point_scale_and_crop`, `image_style_quality`).

## How a set is defined
Each migration uses the `image_style_generate` source: a `size_multiplier` for the
ratio, a ladder of `base_sizes`, a `focal_point_scale_and_crop` effect, and
`image_style_quality` that tapers JPEG quality (85 → 30 or lower) as dimensions grow.
