<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field Group Table — agent index

Adds one Field Group formatter, **`field_group_table`** ("Table"), that renders a group's fields
as a 2-column label/value table (form + view contexts). Requires the `field_group` module. No
config entity of its own, no permissions, no routes, no Drush, no new plugin types.

- **Add a Table group + every format setting (keys/values, where it's stored)** →
  [configure/table-format.md](configure/table-format.md)
- **Alter the generated rows programmatically** →
  [hooks/rows-alter.md](hooks/rows-alter.md)

Key facts:
- The group is a Field Group group, stored by field_group in the entity display config:
  `core.entity_view_display.*` / `core.entity_form_display.*` →
  `third_party_settings.field_group.<group_name>` with `format_type: field_group_table` and a
  `format_settings` map.
- Plugin id `field_group_table`, `supported_contexts = {form, view}`.
- Settings include `label_visibility`, `desc`, `desc_visibility`, `first_column`,
  `second_column`, `empty_label_behavior`, `table_row_striping`, `always_show_field_label`,
  `always_show_field_value`, `empty_field_placeholder`, `hide_table_if_empty`.
