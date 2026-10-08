<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# field_aspect_ratio — the field and its auto-computed value

## What ships (config/install)
Enabling the module installs two config entities:

- `field.storage.media.field_aspect_ratio` — `type: decimal`, `settings: {precision: 10, scale: 2}`,
  `cardinality: 1`, `translatable: true`, `entity_type: media`. Depends on the `media` module.
- `field.field.media.image.field_aspect_ratio` — attaches the storage to bundle `image` of `media`.
  `label: 'Aspect Ratio'`, `required: false`, `settings.min: 0.0` (no max). Depends on the storage config
  and on `media.type.image`, so the core **media** module and its **image** media type must exist first
  or install fails.

The field description explains the convention: "16/9 is 1.78 and 9/16 is 0.56. Landscape images are higher
than 1, while portrait are lower than 1. 1 is a perfect square."

Because the value is a plain `decimal`, it renders and is queried with core's standard decimal
field formatter/widget and Views handlers — the module ships **no** formatter, widget, CSS, or JS.

## How the value is computed (`aspect_ratio.module`)
`aspect_ratio_calculate(MediaInterface $media)`:
1. Returns early unless `$media->hasField('field_aspect_ratio')`.
2. Gets the source file id: `$media->getSource()->getSourceFieldValue($media)`, then `File::load($file_id)`.
3. Only proceeds if the file's MIME type starts with `image/`.
4. `getimagesize($file->getFileUri())` → `[$width, $height]`; if both are truthy, sets the field to
   `$width / $height`. (Height is guarded, so no divide-by-zero.)

`aspect_ratio_entity_presave(EntityInterface $entity)` (implements `hook_entity_presave`) calls
`aspect_ratio_calculate()` for **every** media entity presave — so the ratio is refreshed automatically on
each save of any media type that has the field (only `image` by default).

Helper functions for custom code / batch:
- `aspect_ratio_calculate_and_save(MediaInterface $media)` — compute then `$media->save()`.
- `aspect_ratio_calculate_and_save_by_id($media_id)` — `Media::load($id)` then the above; used as the
  batch operation callback.

## Notes / limits
- Only `media.image` gets the field out of the box. To tag another bundle, add a `field_aspect_ratio`
  instance to that bundle; the presave hook already covers all media types generically.
- Non-image media (source MIME not `image/*`) leaves the field empty.
- `getimagesize()` reads the local file URI of the media source; there is no remote fetch.
- Values persist as stored; changing an image and re-saving the media recomputes them.
