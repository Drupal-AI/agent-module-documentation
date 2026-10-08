<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Custom Field - Viewfield — agent index

Adds a **`viewfield`** subfield to the parent [custom_field](../../../../5.0.x/agent/start.md)
module: a Custom Field *column* that references a View + display. No configure route, no
permissions, no Drush, no new plugin types — it registers plugins into custom_field's plugin
managers. Depends on `custom_field` + core `views`.

Plugin ids it registers (all consumed inside a `custom` field):
- `CustomFieldType` **`viewfield`** — the column data type (`target_type: view`)
- `CustomFieldWidget` **`viewfield_select`** — select widget to pick view/display
- `CustomFieldFormatter` **`viewfield_default`** — renders the referenced view
- `CustomFieldFeedsType` **`viewfield`** — Feeds import target

- **Add a viewfield column, pick its widget/formatter, where it is stored** →
  [configure/viewfield-column.md](configure/viewfield-column.md)

Key facts: a viewfield column is defined in the field storage `columns` setting as
`{type: viewfield, target_type: view}`; the widget/formatter are chosen per column in the
Custom Field widget/formatter `settings.fields.<column>.type` on the entity form/view displays.
