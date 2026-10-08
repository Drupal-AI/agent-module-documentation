# Element Class Formatter Responsive Image — agent index

Submodule of `element_class_formatter`. Adds one field formatter, **`responsive_image_class`**
("Responsive image (with class)"), that behaves like core's Responsive Image formatter but applies
space-separated CSS class(es) directly to the rendered image element (via `#item_attributes`).
Depends on `element_class_formatter` and core `responsive_image`. No settings page (`configure`
null), no permissions, no Drush, no services. Ships a config schema.

- **Select and configure the formatter on a field (settings, runtime, drush/PHP, schema)** →
  [configure/formatter.md](configure/formatter.md)

Key facts:
- Formatter id **`responsive_image_class`**, `field_types: {image}`. Class
  `Drupal\element_class_formatter_responsive_image\...\ResponsiveImageClassFormatter` extends core
  `ResponsiveImageFormatter` and uses the parent module's `ElementEntityClassTrait`.
- Settings: core `responsive_image_style` + `image_link`, plus the added **`class`** string
  (textfield, maxlength 200, default `''`). Applied to `#item_attributes['class'][]` in
  `viewElements()` → `setEntityClass()`; summary shows `Element class: <class>`.
- Stored in `core.entity_view_display.<entity>.<bundle>.<mode>` under
  `content.<field>.type: responsive_image_class`, `settings.class: '<classes>'`.
- Config schema `field.formatter.settings.responsive_image_class` extends
  `field.formatter.settings.responsive_image` with a `class` string
  (`config/schema/element_class_formatter_responsive_image.schema.yml`).
- Auto-installed by the parent module's `element_class_formatter_update_8001()` when
  `responsive_image` is enabled.
- Shared class-adding pattern lives in the parent: see
  `../../../../2.1.x/agent/configure/formatters.md` and `../../../../2.1.x/agent/extend/traits.md`.
