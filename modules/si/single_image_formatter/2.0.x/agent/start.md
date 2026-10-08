# Single Image Formatter — agent index

Field formatter(s) that render only the first value of a multi-valued image/media field. No settings
page (`configure` null), no permissions, no Drush. Depends on core `image`.

- **The three formatter plugin ids, what they extend, field types, and how to select one** →
  [configure/formatters.md](configure/formatters.md)

Submodules (own docs):
- `single_image_formatter_responsive` →
  [../../modules/single_image_formatter_responsive/2.0.x/agent/start.md](../../modules/single_image_formatter_responsive/2.0.x/agent/start.md)
- `single_image_formatter_media` →
  [../../modules/single_image_formatter_media/2.0.x/agent/start.md](../../modules/single_image_formatter_media/2.0.x/agent/start.md)

Key facts:
- Main formatter `single_image_formatter` (field type `image`) extends core `ImageFormatter`, overrides
  `getEntitiesToView()` to return only the first file. Inherits all image-formatter settings; schema
  reuses `field.formatter.settings.image`.
