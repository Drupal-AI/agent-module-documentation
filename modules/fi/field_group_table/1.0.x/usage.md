<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Field Group Table adds a **"Table"** group format to the Field Group module that renders the fields inside a group as a 2-column table — field labels in the left column, rendered field values in the right.

---

The module ships a single Field Group formatter plugin, `field_group_table` (label "Table"),
usable in both the **form** and **view** display contexts. You create a field group as usual on
a *Manage display* or *Manage form display* page and pick **Table** as the format; every field
in the group becomes a table row (`<th>` label cell + value cell). It differs from *Field group
multiple* by rendering each field's value normally in one cell rather than splitting multivalue
fields across rows. The formatter exposes many settings: field-group **label visibility**
(hidden / above table / `<caption>` / below), **description** text and its visibility,
custom **first/second column headers**, **empty label behavior** (keep the empty label cell vs.
merge the two cells with `colspan=2`), **table row striping** (zebra), **"always show field
label"** (force the label into column one for every row), **"always show field value"** with an
**empty field placeholder** (force a row even when the field is empty), and **"hide table if
empty"** (emit no markup when there are no value rows). Settings are stored by Field Group in the
entity display config (`third_party_settings.field_group.<group_name>.format_type` =
`field_group_table`, plus `format_settings`). The module invites one alter hook,
`hook_field_group_table_rows_alter()`, to add or remove rows programmatically. It has no config
of its own, no permissions, no routes and no Drush.

---

- Render an entity's fields as a clean label/value spec table on its display.
- Present product attributes (SKU, dimensions, weight) as a two-column table.
- Show a "details" table of profile fields on a user or node view.
- Group form fields into a compact table layout on an entity edit form.
- Add column headers (e.g. "Property" / "Value") above a field-group table.
- Use the group label as a semantically correct `<caption>` on the table.
- Zebra-stripe a long attribute table for readability.
- Merge label+value cells for rows whose label is empty (full-width row).
- Keep an empty label cell to preserve column alignment across rows.
- Force every row to show its field label in the first column regardless of field settings.
- Always render a row for a field even when it has no value, showing a placeholder like "—".
- Hide the entire table (no wrapper markup) when the group has no populated fields.
- Add descriptive help text above or below a field-group table.
- Build a comparison/specification block from a set of fields without custom templates.
- Lay out address or contact fields as a tidy label/value table.
- Provide a consistent tabular presentation of fields across multiple content types.
- Remove empty multivalue-field rows via `hook_field_group_table_rows_alter()`.
- Inject extra computed rows into the table via the rows-alter hook.
- Nest a table group inside other field groups (tabs, accordions) from Field Group.
- Apply custom CSS classes to the generated table via the formatter's classes setting.
- Present taxonomy or reference fields as labelled rows in a table.
- Give editors a tabular form section that mirrors the eventual view display.
- Standardise "at a glance" data tables across a design system.
- Turn a group of fields into a print-friendly table layout.
