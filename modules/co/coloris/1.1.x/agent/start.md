# Coloris Widget — agent index

Provides a `coloris_color` field type + `text_coloris` widget + `coloris_color` formatter +
reusable `coloriswidget` form element that render the [Coloris](https://coloris.js.org/) JS
color picker. Depends on core `options`. No config page (`configure` null), no permissions, no
Drush. Config schema for field settings only.

- **Field type, widget, all per-field settings keys, validation, formatter** →
  [configure/field.md](configure/field.md)
- **The reusable `coloriswidget` render element (`#…` properties, data-attributes) for custom forms** →
  [api/element.md](api/element.md)

Key facts:
- Field type `coloris_color` (`src/Plugin/Field/FieldType/ColorisItem.php`): `varchar(255)` `value`,
  Length constraint max 36. Default widget `text_coloris`, default formatter `coloris_color`.
- Settings live in the field's `defaultFieldSettings()` / field config (schema
  `field.field_settings.coloris`): `wrap`, `data_theme`, `theme_mode`, `margin`, `format`,
  `format_toggle`, `alpha`, `force_alpha`, `swatches_only`, `focus_input`, `select_input`,
  `clear_button`, `clear_label`, `swatches[]`, `inline`, `default_color`.
- Input validated by regex in `ColorisWidget::validateFormElement` — only `#hex`, `rgb()/rgba()`,
  `hsl()/hsla()` accepted.
- Coloris library `coloris/element.coloris` → `element.coloris.lib` loads from jsDelivr CDN pinned
  to `@latest` (`coloris.libraries.yml`) — not a fixed version.
