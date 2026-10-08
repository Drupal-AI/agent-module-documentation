<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Key/Value Field — agent index

Two field types that store **key + value + optional description** in one item. No settings
form, no permission, no Drush. Depends on core `text`. All configuration is per-field on the
bundle's Manage fields / form display / display pages, or via field config entities.

- **Field types, widgets, formatter & their settings keys** →
  [configure/field.md](configure/field.md)
- **Create the field & read/write values in code** → [api/programmatic.md](api/programmatic.md)

Key facts:
- Field types: `key_value` (plain, extends `StringItem`, default widget `key_value_textfield`)
  and `key_value_long` (formatted, extends `TextLongItem`, default widget `key_value_textarea`).
  Both default to the `key_value` formatter. Field category: "Key / Value".
- Item properties/columns: `key`, `value`, `description` (+ `format` for the long type).
  Storage setting `key_max_length` (default 255) sizes the indexed `key` column; `key_is_ascii`
  picks `varchar_ascii`.
- Formatter setting `value_only` (bool) hides the key and shows only the value.
- `key` is required only once a value is entered (`validateKeyElement`).
