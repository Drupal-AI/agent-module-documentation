<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Data Field — agent index

One composite field type `data_field` (default widget `data_field_table_widget`, default formatter
`data_field_table_formatter`) whose sub-columns you define yourself, each with its own storage type,
widget and formatter. No global config page (`configure` null), no permissions, no Drush. Provides a
config schema and three internal plugin systems. Not a per-subvalue entity field — core field
widgets/formatters do not apply to sub-columns.

- **Define the field: storage columns, per-column widgets & formatters, the wrapping formatters
  (Table/Chart/List/Details/JSON), config schema keys** → [configure/field.md](configure/field.md)
- **The three sub-plugin systems (`Plugin/DataField/FieldType|FieldWidget|FieldFormatter`), managers,
  attributes, and how to add a custom sub-type/widget/formatter** → [plugins/subplugins.md](plugins/subplugins.md)

Key facts:
- Storage: `field.storage.<entity>.<field>` settings `columns` = list of sub-columns
  (`name`, `type`, `max_length`, `size`, `precision`, `scale`, `unsigned`, `datetime_type`);
  schema `field.storage_settings.data_field`.
- Per-instance field settings (`field_settings` per column: label, allowed_values, min/max, required,
  entity_reference_type, target_bundles) → schema `field.field_settings.data_field`.
- Widgets/formatters are configured per sub-column inside the form/view display component
  (`data_field_widget` / `data_field_table_widget`; formatters `data_field_table_formatter`,
  `data_field_chart`, `data_field_details`, `data_field_html_list`, `data_field_unformatted_list`,
  `data_field_json_export`).
- Editing routes `/datafield/{entity_type}/{entity}/{field}/…` (add/edit/clone/delete) use the
  `_datafield_access` check (entity `update` + field `edit` access; honours `field_permissions`).
- AJAX helper routes: `/json/datafield/*`, `/datafield/field_reference/*`,
  `/ajax/datafield/hierarchical/*`.
