<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Flex Field (flexfield) — agent index

Defines one field type, **`flex`**, that stores several `varchar` columns in one field. You declare
the columns (name + max_length) as storage settings, then assign each column a **FlexFieldType**
sub-field plugin (text / number / select / checkbox / uuid…) plus its widget & formatter settings as
per-instance field settings. No configure route, no permissions, no Drush, no config schema. Requires
`field` + `field_ui`; core `^8 || ^9 || ^10 || ^11`. State is normal field config in
`field.storage.*` / `field.field.*` + form/view display config.

- **Add the field, define its columns, assign sub-field types, choose widget & formatter, script it** →
  [configure/field.md](configure/field.md)
- **Sub-field types, widgets, formatters, and how to add a custom FlexFieldType** →
  [plugins/inventory.md](plugins/inventory.md)

Key facts:
- Field type id `flex`; `default_widget = flex_default`, `default_formatter = flex_formatter`.
- Storage setting `columns`: map of `name => {name, max_length}`, every column a `varchar(max_length)`.
  Locked once the field has data. Optional clone-from-existing-flexfield on the storage form.
- Instance setting `field_settings`: per column `{type, widget_settings, formatter_settings, check_empty, weight}`.
  `type` is a FlexFieldType plugin id (default `text`).
- Ships 8 FlexFieldType plugins: `text`, `integer`, `decimal`, `float`, `select`, `radios`,
  `checkbox`, `uuid`. Only `checkbox` sets `never_check_empty`; `uuid` auto-fills a UUID on first save.
- Widgets: `flex_default` (inline; `customize`/`proportions`/`breakpoint` settings) and
  `flex_stacked` (one sub-field per row). Both add a `label` (show field label) setting.
- Formatters: `flex_formatter` (default, themeable + per-column `label_display`), `flex_inline`
  (`show_labels`/`label_separator`/`item_separator`), `flex_table`, `flex_list` (`list_type` ul/ol),
  `flex_template` (`template` with `[name]` / `[name:label]` tokens).
- Item `isEmpty()` is TRUE when every column with `check_empty` on is empty. No `mainPropertyName`;
  read columns by name (`$item->value`).
- Defines its own plugin type `FlexFieldType` (manager `plugin.manager.flexfield_type`,
  annotation `@FlexFieldType`, base `FlexFieldTypeBase`, alter hook `flexfield_info`).
- Theme hook `flexfield` (template `flexfield.html.twig`) with suggestion `flexfield__<field_name>`.
- Plugins still use annotations (`@FieldType`, `@FieldWidget`, `@FieldFormatter`, `@FlexFieldType`).
