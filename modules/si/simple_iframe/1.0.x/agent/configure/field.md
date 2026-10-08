# Field type, widget, formatter

No admin config page. Everything is field configuration on an entity bundle.

## Field type — `simple_iframe_field_type`
`src/Plugin/Field/FieldType/SimpleIframeFieldType.php`. Columns:
- `url` — text, length 2048.
- `width` — text, length 255.
- `height` — varchar, length 255.

`isEmpty()` is true when `url` is empty. Default widget `simple_iframe_widget_type`, default
formatter `simple_iframe_formatter_type`.

### Field settings (per field storage/instance)
`defaultFieldSettings()`: `width` = `'100%'`, `height` = `''`. Both are exposed on the field
settings form (`fieldSettingsForm`) as required text fields — "Set a number or %". These act as
default width/height for new items.

## Widget — `simple_iframe_widget_type`
`src/Plugin/Field/FieldWidget/SimpleIframeWidgetType.php`. Renders three text inputs:
- **Iframe URL** — placeholder `//`, maxlength 2000, size from the widget's `size` setting
  (default 100).
- **Width** — pre-filled from the item, else field default width.
- **Height** — pre-filled from the item, else field default height.

Widget setting: `size` (number, default 100) — the size of the URL textfield. Set on the *Manage
form display* widget settings.

## Formatter — `simple_iframe_formatter_type`
`src/Plugin/Field/FieldFormatter/SimpleIframeFormatterType.php`. For each item returns a render
array `#theme => 'simple_iframe'` with `#url`, `#width`, `#height`. No formatter settings. To
change the output, override the template (see [../theming/template.md](../theming/template.md)).

## Setup (drush/config)
Add a field of type `simple_iframe_field_type` to a bundle, then the default widget/formatter are
selected automatically. Example (via config or Field UI): create field
`field_myembed` of type `simple_iframe_field_type` on `node.page`.
