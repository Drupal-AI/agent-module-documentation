# Media Image EXIF Importer — agent index

Optional submodule of Media Library Importer. Replaces core's `image` media source class with
`ImageWithExif` (via `hook_media_source_info_alter`) so Image media types can extract EXIF metadata. Requires
only `media`; works standalone. No config UI/permissions/routes/Drush of its own.

- **The `ImageWithExif` source: `gather_exif` setting, added metadata attributes, mapping to fields** →
  [plugins/image-source.md](plugins/image-source.md)

Key facts:
- `.module` sets `$definitions['image']['class'] = 'Drupal\media_image_exif_importer\Plugin\media\Source\ImageWithExif'`
  — a **global** override affecting every Image media type.
- Added metadata attributes when `gather_exif` is on: `model`, `created`, `iso`, `exposure`, `aperture`,
  `focal_length` (+ `width`/`height`).
- EXIF read via `exif_read_data(realpath($uri), 'EXIF')`; requires the PHP `exif` extension (the setting is
  disabled without it).
