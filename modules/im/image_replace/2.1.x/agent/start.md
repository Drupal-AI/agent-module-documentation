# Image Replace Effect — agent index

An image style **effect** (`image_replace`) that replaces the whole source image with another
one for a given style — for art-directed responsive images. Depends on core `image`. No
settings page (`configure` null), no permissions, no Drush. Provides config schema. Ships an
ImageEffect plus GD and ImageMagick toolkit operations, but defines no plugin *type* of its own.

- **End-to-end setup: add the Replace effect to a style, map styles → source fields on an
  image field, how presave builds the replacement table, derivative flushing, cache caveats** →
  [configure/setup.md](configure/setup.md)
- **Programmatic API: the `image_replace.storage` service (`get`/`add`/`remove`), the
  `{image_replace}` schema, and the effect/toolkit-operation classes** →
  [api/storage.md](api/storage.md)

Key facts:
- Effect `image_replace` (`src/Plugin/ImageEffect/ImageReplaceEffect.php`), config key
  `image.effect.image_replace` stores the style name (set by `image_replace_image_style_presave`).
- Per-field mapping is a field-config third-party setting
  `image_replace.image_style_map.{style}.source_field` (schema
  `field.field.*.*.*.third_party.image_replace`), added on `field_config_edit_form` for image
  fields by `image_replace_form_field_config_edit_form_alter`.
- `image_replace_entity_presave` syncs `{image_replace}` rows and calls `image_path_flush`.
- All configuration is trusted-admin (manage-fields / manage image styles); no untrusted input.
