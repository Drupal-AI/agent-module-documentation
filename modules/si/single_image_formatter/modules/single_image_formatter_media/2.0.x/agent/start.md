# Single Media Thumbnail Formatter — agent index

Submodule of `single_image_formatter`. Provides one field formatter that renders only the first
value of a multi-valued media reference field, as a media thumbnail. No settings page (`configure`
null), no permissions, no Drush, no plugin types, no services. Depends on core `media`.

- **The formatter id, field type, inherited settings, config schema, and how to select/set it** →
  [fields/formatter.md](fields/formatter.md)

Parent module (shared single-image logic; all three family formatters compared side by side):
- [../../../../2.0.x/agent/start.md](../../../../2.0.x/agent/start.md)
- [../../../../2.0.x/agent/configure/formatters.md](../../../../2.0.x/agent/configure/formatters.md)

Key facts:
- Formatter `single_media_formatter` (label "Single media thumbnail"), field type `entity_reference`.
- Class `Drupal\single_image_formatter_media\Plugin\Field\FieldFormatter\SingleMediaFormatter` extends
  core `MediaThumbnailFormatter`; only override is `getEntitiesToView()` → keep the first referenced item.
- Config schema `field.formatter.settings.single_media_formatter` reuses `field.formatter.settings.media_thumbnail`.
