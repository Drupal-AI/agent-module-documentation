<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Image Aspect Ratio Tagging (aspect_ratio) — agent index

Adds a decimal field `field_aspect_ratio` to the core **image** media bundle and auto-populates it with
`width / height` (via `getimagesize()`) on every media save. Version **1.0.3**, core `^9 || ^10 || ^11`.

- **Requires:** core `media` module and a `media.type.image` bundle (the shipped field config depends on both).
- **Field (config/install):** `field.storage.media.field_aspect_ratio` (decimal, precision 10, scale 2, cardinality 1)
  and `field.field.media.image.field_aspect_ratio` (label "Aspect Ratio", min 0.0).
- **Hook:** `aspect_ratio_entity_presave()` in `aspect_ratio.module` recomputes the value on any media presave.
- **Procedural helpers:** `aspect_ratio_calculate(MediaInterface)`, `aspect_ratio_calculate_and_save(MediaInterface)`,
  `aspect_ratio_calculate_and_save_by_id($id)`.
- **Route:** `aspect_ratio.recalculate` → `/admin/config/media/aspect_ratio/recalculate`
  (`_form: BatchCalculateAspectRatio`, permission `administer media`); admin menu link under Configuration ▸ Media.
- **No** permissions.yml, services, plugins, drush commands, config/schema, or libraries of its own.

Solution docs:
- [The aspect-ratio field & how the value is computed](fields/aspect_ratio.md)
- [Recalculate batch form & route](config/recalculate.md)
