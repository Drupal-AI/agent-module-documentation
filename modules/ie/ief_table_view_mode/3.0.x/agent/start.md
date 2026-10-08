<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# IEF Table View Mode — agent index

Adds an Inline Entity Form widget whose referenced-entities table columns are defined by a
dedicated `ief_table` view mode. Requires `inline_entity_form`. No settings form, no `configure`
route, no permissions, no Drush. Config schema: `field.widget.settings.inline_entity_form_complex_table_view_mode`.

- **The widget plugin (`inline_entity_form_complex_table_view_mode`) and how column rendering
  works** → [plugins/widget.md](plugins/widget.md)
- **Set it up: choose the widget, the auto-created `ief_table` view mode, configuring columns** →
  [configure/table-columns.md](configure/table-columns.md)

Key facts: the widget id is `inline_entity_form_complex_table_view_mode` (label "Inline entity
form - Complex - Table View Mode"); it applies to `entity_reference` /
`entity_reference_revisions` fields. Saving a form display that uses it auto-creates the view mode
`<entity_type>.ief_table` (label "Inline Entity Form Table"); that view mode's Manage display of the
referenced bundle defines which fields become table columns.
