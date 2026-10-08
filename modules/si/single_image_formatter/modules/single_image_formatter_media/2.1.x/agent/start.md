<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Single Media Thumbnail Formatter (single_image_formatter_media) — agent index

Submodule of `single_image_formatter`. Provides two field formatters that render only the first value
of a multi-valued `entity_reference` field. No settings page (`configure` null), no permissions, no
Drush, no plugin types, no services. Depends on core `media`; the responsive-thumbnail option also
uses core `responsive_image` when present. Requires Drupal core 10.2+ and PHP 8.1+.

- **Both formatter ids, field type, settings (incl. the new responsive-image option), config schema,
  and how to select/set them** → [fields/formatter.md](fields/formatter.md)

Parent module (shared single-value logic; all family formatters compared side by side):
- [../../../../2.1.x/agent/start.md](../../../../2.1.x/agent/start.md)
- [../../../../2.1.x/agent/configure/formatters.md](../../../../2.1.x/agent/configure/formatters.md)

Key facts:
- `single_media_formatter` (label "Single media thumbnail"), field type `entity_reference`. Class
  `Drupal\single_image_formatter_media\Plugin\Field\FieldFormatter\SingleMediaFormatter` extends core
  `MediaThumbnailFormatter`; overrides `getEntitiesToView()` to keep the first referenced item, and
  adds an optional `responsive_image_style` setting (renders the media source image responsively
  instead of the thumbnail). Config schema `field.formatter.settings.single_media_formatter` extends
  `field.formatter.settings.media_thumbnail` with a `responsive_image_style` string.
- `single_entity_formatter` (label "Single rendered entity"), field type `entity_reference`. Class
  `SingleEntityFormatter` extends core `EntityReferenceEntityFormatter`; only override is
  `getEntitiesToView()` → keep the first entity. Config schema
  `field.formatter.settings.single_entity_formatter` reuses
  `field.formatter.settings.entity_reference_entity_view`.
