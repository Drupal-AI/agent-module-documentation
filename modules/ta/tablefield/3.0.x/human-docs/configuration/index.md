# Configuration

TableField is configured in three places: a small global settings form, the
settings on each individual Table field, and the widget and formatter options
that control data entry and display.

## Global module settings

Go to **Configuration → Content authoring → Tablefield**
(`/admin/config/content/tablefield`). These values act as site‑wide defaults and
are stored as exportable configuration:

- **CSV separator** — the single character used both when importing and when
  exporting CSV data (default `,`). Set it to a semicolon or another character if
  your spreadsheets use one.
- **Default rows** — the number of rows a new table starts with when a field
  does not specify its own default (default 5).
- **Default columns** — the number of columns a new table starts with, same
  fallback rule (default 5).

## Field settings

When you add a **Table Field** to a content type (**Structure → Content types →
Manage fields**), its field settings offer:

- **Default rows and columns** — set a starting grid size for this specific
  field by filling in its default‑value table. This overrides the global
  defaults above.
- **Export** *(off by default)* — show an "Export Table Data" CSV link on the
  displayed table. The link only appears for users who also hold the
  *Export tablefield* permission.
- **Restrict rebuild** *(on by default)* — require the *Rebuild tablefield*
  permission before an editor can change the number of rows or columns.
- **Restrict import** *(on by default)* — require the *Import tablefield*
  permission to use the CSV import.
- **Lock values** *(off by default)* — lock the field's default cell values so a
  fixed header row cannot be edited when creating or editing content.
- **Cell processing** *(plain text by default)* — switch cells from plain text
  to filtered (formatted) text, letting editors choose a text format per cell.
- **Empty rules** — fine‑tune when a table counts as "empty": you can tell
  Drupal to ignore changes to the row/column count, or to ignore a filled‑in
  first (header) row, when deciding whether the field has content.

## Widget settings

On the content type's **Manage form display** tab, the **Table Field** widget
has one option:

- **Input type** — render each cell as a single‑line **textfield** (default) or
  a multi‑line **textarea**.

Depending on the current user's permissions and the field settings above, the
widget also exposes a **Change number of rows/columns** control, an **Add Row**
button, a **Copy & Paste** box (paste tab‑, comma‑, semicolon‑, pipe‑, plus‑, or
colon‑separated text), and an **Import from CSV** file upload. Rows can be
reordered by dragging before saving, and a **Table Caption** field sits above the
grid.

## Formatter settings

On the **Manage display** tab, choose the **Tabular View** formatter. It offers:

- **Row header** *(on by default)* — render the first non‑empty row as a
  `<thead>` table header.
- **Column header** *(off by default)* — mark the cells in the first column as
  row headers, useful for a labelled matrix.

When the field's **Export** setting is on and the viewer has the *Export
tablefield* permission, the table also shows an "Export Table Data" link that
downloads the cells as a CSV.

## Permissions

TableField defines several permissions under **People → Permissions** that gate
the interactive controls:

- **Export tablefield** — use the CSV export link.
- **Rebuild tablefield** — change a table's number of rows and columns.
- **Import tablefield** — use the "Import from CSV" upload.
- **Paste tablefield** — use the "Copy & Paste" import box.
- **Addrow tablefield** — use the "Add Row" button.
- **Configure tablefield** — reach the global module settings form.
