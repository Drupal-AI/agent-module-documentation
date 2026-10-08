<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Single Image Formatter (single_image_formatter) — agent index

Field formatter(s) that render only the first value of a multi-valued image/media/entity-reference
field. No settings page (`configure` null), no permissions, no Drush, no services. Base module depends
on core `image`. Requires Drupal core 10.2+ (also 11/12) and PHP 8.1+.

- **All family formatter ids, what they extend, field types, and how to select/configure one** →
  [configure/formatters.md](configure/formatters.md)

Submodules (own docs):
- `single_image_formatter_responsive` →
  [../../modules/single_image_formatter_responsive/2.1.x/agent/start.md](../../modules/single_image_formatter_responsive/2.1.x/agent/start.md)
- `single_image_formatter_media` (ships two formatters, plus a responsive-image thumbnail option) →
  [../../modules/single_image_formatter_media/2.1.x/agent/start.md](../../modules/single_image_formatter_media/2.1.x/agent/start.md)

Key facts:
- Base formatter `single_image_formatter` (field type `image`) — class
  `Drupal\single_image_formatter\Plugin\Field\FieldFormatter\SingleImageFormatter` extends core
  `ImageFormatter`, overrides `getEntitiesToView()` to return only the first file
  (`$file = reset($files); return $file ? [$file] : [];`). Inherits all image-formatter settings;
  schema reuses `field.formatter.settings.image`.
- Field cardinality and stored values are untouched; only the number of items rendered changes (one).
