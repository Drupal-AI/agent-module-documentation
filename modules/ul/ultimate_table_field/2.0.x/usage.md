<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Ultimate Table Field adds an "Ultimate table" field type that stores a whole table of typed cells as structured field data, edited with an in-place grid and displayed as a themeable HTML table.

---

Install the module (it needs core's Field module) and add a field of type **Ultimate table** to any entity bundle. On the field's settings you can restrict which cell content types are offered (**Cell allowed field types** — leave empty to allow all) and turn on an optional **Legend** caption. On the entity form the field shows an editable grid: **Add row** / **Add column** buttons (with a "number to add" box) build the shape, drag handles reorder rows, and each cell has an **Add** link that opens a modal where you pick a cell type and enter its value. The four built-in cell types are **Text** (`textfield`), **Text (Long)** (`textarea`), **Link** (node autocomplete or internal/external URI plus link text) and **File** (a `managed_file` upload limited to `pdf doc docx`, saved to `public://ultimate-table/documents`); a cell can hold several items. Configure display under **Manage display**: the **Ultimate table** formatter renders a real `<table>` with header cells and offers a colour **theme** (15 named colours), row/style options (**striped odd/even**, **filled header**, **row hover**, **side filled**), and where the legend sits (**before**/**after**). The stored value is a single serialized blob per item, so it is portable but not queryable column-by-column. Developers can add new cell types by implementing the **`UltimateTableCellField`** plugin (see `agent/plugins/cell-field.md`), or alter the bundled ones via `hook_ultimate_table_cell_field_info()`.

---

- Add an "Ultimate table" field to a content type or other entity.
- Store a structured table as field data instead of markup pasted into a WYSIWYG.
- Build the table shape with Add row / Add column buttons.
- Add several rows or columns at once with the number box.
- Reorder rows by dragging the weight handles.
- Remove a specific row, column or cell item.
- Put a Text cell value into a table cell.
- Put a long Text (textarea) value into a cell.
- Add a Link cell that points at a node via autocomplete.
- Add a Link cell to an internal path or external URL with custom link text.
- Attach a downloadable document (pdf/doc/docx) as a File cell.
- Place more than one item inside a single cell.
- Restrict a field to only certain cell types with "Cell allowed field types".
- Turn on the optional legend/caption for a table.
- Choose whether the legend appears before or after the table.
- Apply one of 15 colour themes to the displayed table.
- Enable striped rows (odd or even), a filled header, row hover, or side-filled styling.
- Render the table with real header cells via the Ultimate table formatter.
- Add a custom cell content type by writing an UltimateTableCellField plugin.
- Alter or remove the bundled cell types with hook_ultimate_table_cell_field_info().
- Document the field type and its cell plugin system for the team.
- Review the module during a site audit or before an upgrade.
