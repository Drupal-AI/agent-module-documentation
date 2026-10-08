<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
IEF Table View Mode adds an Inline Entity Form widget variant ("Inline entity form - Complex - Table View Mode") whose referenced-entities table columns are driven by a dedicated `ief_table` view mode, so you control which fields and properties show as columns.

---

The module extends the Inline Entity Form (IEF) "Complex" widget with a new field widget plugin, `inline_entity_form_complex_table_view_mode`, that is applicable to entity_reference / entity_reference_revisions fields. It registers an `inline_form_table_view_mode` entity handler on every content entity type and, when you configure a field to use the widget and save the form display, auto-creates a view mode named `<entity_type>.ief_table` (label "Inline Entity Form Table"). You then edit that view mode's Manage display for the referenced bundle to choose exactly which fields become the columns of the IEF table (instead of IEF's default label-only column). The module alters the view-display edit form for the `ief_table` mode to hide field labels and inject IEF's built-in table columns as extra fields, and blocks deletion of the `ief_table` view mode. It ships a config schema for the widget settings (`field.widget.settings.inline_entity_form_complex_table_view_mode`, inheriting IEF complex settings) and requires the Inline Entity Form module. There is no admin settings page; all configuration is done through the referenced entity's form-display widget selection and the `ief_table` view mode display.

---

- Show multiple fields (title, date, status, price…) as columns in an IEF referenced-entities table instead of just the label.
- Give editors a scannable table of referenced paragraphs/nodes with meaningful columns.
- Configure which columns appear per referenced bundle via the "Inline Entity Form Table" view mode.
- Replace IEF Complex's single-column table with a multi-column one without custom code.
- Display a computed/extra field (e.g. an operations or rendered field) as an IEF table column.
- Build a product-and-variations edit screen where each variation row shows SKU, price, and stock.
- Present referenced media in an IEF table with thumbnail and dimensions columns.
- Order the IEF table columns by adjusting field weights in the `ief_table` view mode.
- Reuse Drupal's Manage display UI (familiar to site builders) to define IEF columns.
- Keep IEF's native table columns while adding your own configured field columns alongside them.
- Show a reference-revisions field (Paragraphs) as a column-rich inline table.
- Standardize the inline table layout across content types by configuring each `ief_table` view mode.
- Surface a taxonomy or entity-reference value from the referenced entity as its own column.
- Let content authors compare referenced items at a glance in an editing form.
- Apply field formatters (date format, number format) to the values shown in the IEF table columns.
- Migrate an existing IEF Complex field to the table-view-mode widget to enrich its table.
- Configure a "form display" for the referenced entity independently from its "table" columns.
- Avoid writing a custom `getTableFields()` override by using the view-mode-driven columns.
- Provide per-bundle column sets when a reference field targets multiple bundles.
- Give an event's inline "sessions" table columns for time, room, and speaker.
- Display only the columns editors need, hiding noisy fields from the inline table.
