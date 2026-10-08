# Image field to media — agent index

Adds a "Clone to media" operation to Image fields that clones them into a Media reference field and backfills
all entities in a batch. Non-destructive (original Image field kept). Requires `media`. No config schema, no
Drush. One restricted permission.

- **The conversion flow: operation, validator controller, the form (create vs reuse), batch, dedup** →
  [configure/convert.md](configure/convert.md)
- **The batch API functions and state dedup (for programmatic / update-hook use)** → [api/batch.md](api/batch.md)
- **The permission** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Prereq: an `image` Media type with a `field_media_image` field must exist (validator redirects with an error
  otherwise).
- Routes: `image_field_to_media.image_media_type_validator` (`/image-field-to-media-validator/{field_config}`) →
  `image_field_to_media.field_settings_form` (`/image-field-to-media/{field_config}`). Both require
  `create media fields based on existing image fields`.
- Dedup key: `sha1_file($uri)` stored in state `image_field_to_media.hashes_of_image_files`
  (`{media_id => hash}`); cleared on media delete and on uninstall.
- New Media entities are created with `uid = 1`, bundle `image`, file set on `field_media_image`.
