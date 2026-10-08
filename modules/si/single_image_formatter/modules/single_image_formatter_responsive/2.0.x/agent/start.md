# Single Responsive Image Formatter — agent index

Submodule of `single_image_formatter`. Provides one field formatter that renders only the first
value of a multi-valued `image` field, using core responsive image styles (breakpoints /
art-direction). No settings page (`configure` null), no permissions, no Drush, no plugin types, no
services. Depends on core `responsive_image`.

- **The formatter id, field type, inherited settings, config schema, and how to select/set it** →
  [fields/formatter.md](fields/formatter.md)

Parent module (shared single-image logic; all three family formatters compared side by side):
- [../../../../2.0.x/agent/start.md](../../../../2.0.x/agent/start.md)
- [../../../../2.0.x/agent/configure/formatters.md](../../../../2.0.x/agent/configure/formatters.md)

Key facts:
- Formatter `single_responsive_image_formatter` (label "Single responsive image"), field type `image`.
- Class `Drupal\single_image_formatter_responsive\Plugin\Field\FieldFormatter\SingleResponsiveImageFormatter`
  extends core `ResponsiveImageFormatter`; only override is `getEntitiesToView()` → keep the first file.
- Config schema `field.formatter.settings.single_responsive_image_formatter` reuses
  `field.formatter.settings.responsive_image`.
