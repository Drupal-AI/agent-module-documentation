# svg_image_field — agent start

Adds a "Vector image" field type + widget + formatters so SVG files can be uploaded,
sanitized and displayed (core Image field rejects SVG). Depends on core `image`; requires
the `enshrined/svg-sanitize` PHP library. No admin settings form (config is per-field via
Field UI). Submodule: `svg_image_field_media_bundle` (imports a ready-made SVG media type).

- Add the field & configure widget/formatter settings → [configure/field.md](configure/field.md)
- Field type, widget, formatters, media source, validator (plugin ids) → [plugins/plugins.md](plugins/plugins.md)
- Formatter template & theme hook → [theming/formatter.md](theming/formatter.md)
