<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Custom Field — agent index

One field type, `custom`, whose **storage is a list of columns (subfields)** in a single
table. Each column has a subfield **type**, **widget**, and **formatter** plugin. The parent
field uses base widget `custom_flex` or `custom_stacked` and base formatters
`custom_formatter` / `custom_inline` / `custom_list` / `custom_table` / `flipped_table` /
`custom_template`. **No settings page, no configure route, no permissions.** All config is
per-field via the Field UI (storage `columns` setting + display forms).

- **Create/configure a Custom Field (the `columns` storage setting, widgets, formatters) —
  UI and scriptable** → [configure/create-field.md](configure/create-field.md)
- **The plugin types it defines and how to implement a subfield type / widget / formatter** →
  [plugins/plugin-types.md](plugins/plugin-types.md)
- **Services: add/remove a column on a populated field, sample data, tags, link attributes** →
  [api/services.md](api/services.md)
- **Drush `custom_field:add-column` / `custom_field:remove-column`** →
  [drush/updater.md](drush/updater.md)

Key facts:
- Field type id `custom` (class `CustomItem`). Storage setting `columns` is keyed by column
  name → `['name' => …, 'type' => <subfield-type id>, …]`. DB columns become
  `<field>_<column>` in the field's own table.
- Subfield **type** ids (22): `boolean color daterange datetime decimal duration email
  entity_reference file float image integer link map map_string string string_long
  telephone time time_range uri uuid` (+ `viewfield` from custom_field_viewfield).
- Nine submodules add integrations (GraphQL, JSON:API, Linkit, Media, Search API, SDC,
  Entity Browser, AI, Viewfield); each is documented under `modules/custom_field/modules/*`.
