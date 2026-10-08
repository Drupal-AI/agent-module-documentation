# Bootstrap Horizontal Tabs — agent index

A Field API triad (field type + widget + formatter) that turns a multi-value "tab header + rich body"
field into Bootstrap tab/pill markup. Requires core `field` + `text`. The host **theme must provide
Bootstrap** (no CSS/JS shipped). No permissions; no Drush.

- **Field type/widget/formatter, per-display settings, and the site-wide Bootstrap version setting** →
  [configure/field.md](configure/field.md)
- **Template, theme hook, and the attributes/variables the formatter exposes** →
  [theming/template.md](theming/template.md)

Key facts:
- IDs (all `bootstrap_horizontal_tabs`): field type, widget, formatter. One field **delta = one tab**.
- Field type columns: `header` (varchar 512), `body_value` (text), `body_format` (varchar 512).
- Widget: `#type` `textfield` **Tab Label** + `#type` `text_format` **Tab Body**; `massageFormValues()`
  splits the text_format value and enforces **unique headers**.
- Formatter settings: `tab_display` = `tabs`|`pills` (schema
  `field.formatter.settings.bootstrap_horizontal_tabs`), `tab_orientation` = `horizontal`|`vertical`.
- Global config `bootstrap_horizontal_tabs.settings:version` (default `5`) at
  `/admin/config/content/bootstrap-horizontal-tabs` (route requires `administer site configuration`)
  → chooses `data-toggle` (v3/4) vs `data-bs-toggle` (v5) and active/show classes.
- Body is rendered via `processed_text` (format-filtered). The **header** is emitted as `#markup`
  (admin-filtered), so restrict tab-header edit access to trusted roles — see theming doc.
- Theme hook `field__bootstrap_horizontal_tabs`; `tabs` display attaches `bootstrap_horizontal_tabs/deep-linking`.
