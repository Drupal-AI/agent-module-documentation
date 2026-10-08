<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Normalized Image Styles generates large, consistent sets of aspect-ratio-based image styles (with normalized pixel dimensions) that plug directly into core's Responsive Image module.

---

Rather than hand-creating dozens of image styles, this module ships a `migrate_plus` migration group and ~40 sub-modules — one per aspect ratio (16:9, 21:9, 4:3, golden, square 1:1, portrait variants, scaled-max) plus a matching WebP variant of each. Each sub-module is a config-only migration that uses the `image_style_generate` source plugin to emit a full ladder of image styles at incremented base sizes, applying a `focal_point_scale_and_crop` effect and per-size `image_style_quality` (JPEG quality tapers from 85 down as dimensions grow). You enable only the aspect ratios you need on the Extend page, then run the migrations to materialise the styles as real configuration entities.

The workflow is: enable the parent module + desired ratio sub-modules, import the migrations (`drush mim --tag normalized` or the Migrations UI at `/admin/structure/migrate/manage/normalized_image_styles/migrations`), then optionally uninstall the modules — the generated image style config persists and is managed like any other config. Keep `focal_point` and `image_style_quality` installed afterwards, since the generated styles depend on their effects. Operationally the module is admin-only (it adds no routes, permissions, or endpoints of its own — it relies on core migrate access and the Extend/Uninstall pages); the only cost is that importing every ratio creates a very large number of image styles.
---
- Enable the parent module then only the aspect-ratio sub-modules you actually need
- Add a widescreen 16:9 responsive image set for hero banners
- Add ultrawide 21:9 / 32:9 styles for cinematic banners
- Generate 4:3 or 3:2 styles for classic photo layouts
- Generate portrait styles (2:3, 3:4, 9:16, golden) for vertical imagery
- Add square 1:1 styles for avatars, thumbnails, and grid tiles
- Add anamorphic or DCI cinema aspect ratios for film content
- Generate golden-ratio styles for editorial design
- Use the `scaled_max` set to cap maximum dimensions without cropping
- Enable the WebP variant of any ratio to serve modern next-gen images
- Import all enabled styles at once with `drush mim --tag normalized`
- Roll back a set with `drush migrate:rollback` to remove its styles
- List generated migrations and status with `drush migrate:status`
- Wire the generated styles into a core Responsive Image style set
- Rely on Focal Point cropping so the important region survives every crop
- Tune JPEG quality per size via the built-in image_style_quality effect
- Import styles through the Migrations UI instead of Drush
- Uninstall the modules after import while keeping the generated style config
- Export the generated image styles into your site's config/sync
- Provide a normalized dimension ladder for `srcset`/`sizes` responsive markup
- Standardise image dimensions across an entire multi-editor site
- Keep both focal_point and image_style_quality installed after uninstalling
