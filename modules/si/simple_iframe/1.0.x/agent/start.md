# Simple IFrame — agent index

A `simple_iframe` field type (url/width/height) + widget + Twig formatter that renders an
`<iframe>`. No global config, no permissions, no config schema — all per-field configuration.

- **Field type, widget, formatter, field settings** → [configure/field.md](configure/field.md)
- **Overriding the iframe markup (theme hook + template)** → [theming/template.md](theming/template.md)

Key facts:
- Field type `simple_iframe_field_type`: string columns `url` (2048), `width`, `height`; default
  widget `simple_iframe_widget_type`, default formatter `simple_iframe_formatter_type`.
- Field default settings: `width` = `100%`, `height` = `''` (set on field settings form).
- Theme hook `simple_iframe` (vars `url`, `width`, `height`), template
  `templates/simple-iframe.html.twig`.
- Depends on core `field`. Works on any fieldable entity.
- The stored URL is placed directly into the iframe `src`.
