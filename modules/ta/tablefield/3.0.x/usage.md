TableField adds a `tablefield` field type that stores a grid of text cells (rows × columns) on any fieldable entity, with a table widget for data entry and a table formatter for display, plus CSV/paste import and CSV export.

---

TableField defines a single field type, `tablefield`, whose value is a serialized array of table cells (stored in a `blob` column) alongside a text `format` and a `caption`. Editors enter data through the `tablefield` widget: a grid of `textfield` or `textarea` inputs (configurable per widget) whose row count and column count come from the field default, or fall back to the module-wide `tablefield.settings` defaults (`rows`/`cols`, both 5 out of the box). The widget can expose a "Change number of rows/columns" rebuild control, an "Add Row" button, a "Copy & Paste" importer (paste Excel/TSV/CSV-style text with a selectable delimiter), and an "Import from CSV" file upload — each gated by a permission (`rebuild`, `addrow`, `paste`, `import` tablefield) and by field settings (`restrict_rebuild`, `restrict_import`). Rows are draggable (tabledrag by weight), and a field setting can lock default cell values so a fixed header cannot be edited. The `tablefield` formatter ("Tabular View") renders the stored grid as an HTML `<table>`, optionally treating the first row as a `<thead>` header and/or the first column as row headers, and can show an "Export Table Data" link that streams the cell data back out as a CSV (separator taken from `tablefield.settings.csv_separator`). Because it is a standard Field API field it is automatically revisionable, multi-value capable, and Views-integrable. A module settings form at Admin → Configuration → Content authoring → Tablefield sets the CSV separator and the default row/column counts, and `hook_tablefield_encodings_alter()` lets code extend the encodings tried when importing a CSV.

---

- Store a small data table (e.g. a spec sheet or price grid) directly on a node without building a separate entity.
- Add a `tablefield` field to a content type so editors fill in a rows × columns grid of text cells.
- Let editors choose the number of rows and columns per entity via the "Change number of rows/columns" rebuild control.
- Set a site-wide default table size (5×5 by default) at the Tablefield settings form.
- Override the default rows/cols per field in the field's default-value settings.
- Capture a caption for each table to improve screen-reader accessibility.
- Use the first row as a table header when displaying the table (formatter `row_header`).
- Use the first column as row headers for a labelled matrix (formatter `column_header`).
- Import table data from an uploaded CSV file into the widget ("Import from CSV").
- Paste tab-separated data copied straight from Excel into the "Copy & Paste" box.
- Paste delimited text using a comma, semicolon, pipe, plus, or colon separator.
- Export a stored table as a downloadable CSV via the "Export Table Data" link.
- Configure the CSV separator (comma, semicolon, etc.) used for both import and export.
- Choose a `textfield` or `textarea` input for each cell via the widget settings.
- Let editors add extra rows on the fly with the "Add Row" button.
- Reorder rows by dragging (tabledrag) before saving.
- Lock default cell values so a fixed header row cannot be edited during node add/edit.
- Enable filtered (formatted) text per cell instead of plain text via the `cell_processing` field setting.
- Restrict who may rebuild a table's structure to users with the `rebuild tablefield` permission.
- Restrict CSV import to users with the `import tablefield` permission.
- Gate CSV export behind the `export tablefield` permission.
- Store tabular data that is automatically revisioned and multi-value along with the host entity.
- Expose table fields to Views like any other Field API field.
- Control when a table item counts as "empty" (ignore structure changes or an unfilled header) via the empty-rules field settings.
- Extend the character encodings tried during CSV import with `hook_tablefield_encodings_alter()`.
