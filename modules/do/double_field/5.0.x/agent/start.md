<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Double field — agent index

One field type, `double_field`, whose item stores **two independently-typed values**, `first`
and `second`. **No settings form, no configure route** (`configure: null`), **no permissions,
no services, no Drush, no plugin types of its own, no module dependencies.** All state lives in
ordinary field / form-display / view-display config.

- **Storage types, instance settings, widget settings, formatter settings; how to create a
  field programmatically** → [configure/field-and-display.md](configure/field-and-display.md)
- **Plugin inventory: the field type, widget, four formatters, sub-widget matrix, constraints,
  hooks, Feeds target** → [plugins/inventory.md](plugins/inventory.md)
- **Templates, theme hooks and per-field theme suggestions** →
  [theming/templates.md](theming/templates.md)

Key facts:

- Properties are `first` and `second`; `mainPropertyName()` is **NULL** — there is no `->value`.
- Each subfield's storage type is one of `boolean`, `string`, `text`, `integer`, `float`,
  `numeric`, `email`, `telephone`, `datetime_iso8601`, `uri`, set under
  `settings.storage.first.type` / `.second.type` and **locked once the field has data**.
- Formatter ids: `double_field_unformatted_list` (default), `double_field_html_list`,
  `double_field_details`, `double_field_table`. Widget id: `double_field`.
- Class constants carry the ids: `DoubleField::ID`, `Table::ID`, `HtmlList::ID`, etc.
