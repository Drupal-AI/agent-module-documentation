# Signature Field — agent index

A Field API field type that captures a handwritten signature on an HTML5 canvas
([signature_pad](https://github.com/szimek/signature_pad) JS, CDN v4.0.0) and stores it as a
base64 PNG data URL. No config page (`configure` null), no permissions, no Drush. Depends on core
`field` + `field_ui`. Provides a config schema for widget settings.

- **The field type, widget settings keys, formatter, template, and JS data flow** →
  [configure/field.md](configure/field.md)

Key facts:
- Field type `field_signature`; widget `field_signature_field_widget`; formatter
  `field_signature_field_formatter`. All in `src/Plugin/Field/*`.
- Stored value = a `data:image/png;base64,…` string in a `big` text column.
- Formatter renders `#type html_tag`, `#tag img`, `#attributes[src] = $item->value` (attribute-escaped
  by core; not raw markup).
- Widget settings schema: `field.widget.settings.field_signature_field_widget`
  (`show_data_box`, `show_thumb`, `canvas_width`, `canvas_height`, `min_line_width`, `max_line_width`,
  `pen_color`, `background_color`).
- A minimal `signature` FormElement (`src/Plugin/Field/Element/Signature.php`) exists but its
  `valueCallback` is a no-op — use the field widget in practice.
