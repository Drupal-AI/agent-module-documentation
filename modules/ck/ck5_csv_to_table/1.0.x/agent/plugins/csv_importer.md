<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor plugin & JS behavior (csv_importer.CsvImporter)

Everything except the permission attachment is client-side JavaScript in
`js/csv-importer.js`. There is no PHP CSV parser and no server endpoint.

## Registration
- `ck5_csv_to_table.ckeditor5.yml`:
  - `ckeditor5.plugins: [csv_importer.CsvImporter]`
  - `ckeditor5.config.table.contentToolbar`: `tableColumn`, `tableRow`,
    `mergeTableCells`.
  - `drupal.label`: "Import CSV and Generate Table";
    `drupal.library: ck5_csv_to_table/importer`;
    `drupal.admin_library: ck5_csv_to_table/admin`.
  - `drupal.toolbar_items.csvImport` → the button.
  - `drupal.conditions.plugins: [ckeditor5_table]` (core Table required).
  - `drupal.elements`: `<table> <thead> <tbody> <tr> <td> <th>`.
- JS exposes `CKEditor5.csv_importer = { CsvImporter }` (IIFE over
  `window.CKEditor5 || window.Drupal?.CKEditor5`).

## Plugin class `CsvImporter extends Plugin`
`init()`:
- Reads `drupalSettings.ck5_csv_to_table.hasPermission`; `hasPermission =
  settings.hasPermission !== false`. If false, returns early (no button).
- Registers UI component `csvImport` — a `ButtonView` with an inline SVG icon
  and label "Import CSV and generate a table from CSV data".
- On `execute`: creates a hidden `<input type="file" accept=".csv,text/csv">`,
  clicks it, and on change validates and processes the file.

## File / content validation (client-side)
- `_isValidCSVFile(file)`: MIME must be in
  `['text/csv','text/plain','application/csv']` (or empty), and filename must
  end in `.csv` or `.txt`.
- Size cap: `50 * 1024 * 1024` (50MB) → `alert` and abort if exceeded.
- `_isValidCSVContent(csvText)`: rejects non-strings, empty, null bytes, and a
  list of regex "suspicious patterns" (`<script>`, `javascript:`,
  `data:text/html`, `vbscript:`, `on\w+=`, `<iframe|object|embed|applet|meta|
  link|style>`, `expression(`, `@import`, `&#x`). On match → `alert` and abort.
- These are browser-side convenience checks; the authoritative security
  boundary for stored content is the text format's own HTML filtering, which is
  unchanged by this module.

## Parsing & insertion
- `_parseCSVFast(csvText, cb)`: splits on `/\r?\n/`, parses 500 lines/tick
  (`setTimeout(...,1)`), handling quoted fields, escaped `""`, and trimming.
  Each cell passes through `_sanitizeText` (strips HTML tags, `javascript:/
  data:/vbscript:` prefixes, `on\w+=`, `&#`, `\u`/`\x` escapes, null bytes;
  truncates to 10,000 chars).
- `_parseAndInsertCSV`: enforces `MAX_ROWS = 6000`, `MAX_COLUMNS = 100`. If
  exceeded, `window.confirm` warns and (on OK) slices to the limits; cancel
  aborts.
- Inserts via the CKEditor model: `editor.execute('insertTable', {rows,
  columns})`, sets `headingRows: 1` on the table, then `_insertDataOptimized`
  writes cell text 25 rows per `model.change` using `writer.insertText`
  (text nodes only — no raw HTML injected into the model).

## UI
- `_showLoading(progress)` / `_hideLoading()`: an absolutely-positioned overlay
  (`.csv-importer-loading`) built with DOM APIs and `textContent` (not
  `innerHTML`), showing a 0-100% progress bar. Progress is throttled
  (~100-150ms). `css/admin-icons.css` (library `admin`) styles the button icon.

## Practical notes for agents
- The generated content is a normal CKEditor table; after import it is edited
  with core table tools and stored/filtered like any other field content.
- To debug a missing button: confirm the module is enabled, the `csvImport`
  item is in the format toolbar, the user has `use csv importer`, and cache is
  cleared. The JS logs to `console` (`console.error('CKEditor5 not found')`,
  suspicious-content warnings).
