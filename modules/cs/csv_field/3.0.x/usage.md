CSV Field provides a `csv_file` file-field type whose default formatter renders the uploaded CSV as an interactive, client-rendered HTML table (DataTables + PapaParse).

---

CSV Field extends core's file field with a purpose-built field type (`csv_file`), widget (`csv_file_generic`) and formatter (`csv_file_table`). Editors upload a `.csv` file; the widget exposes a "Display Configuration" panel whose choices — initial page length, whether end users can change rows-per-page, responsive mode, searching (with an optional "hide data until searched" mode), a download link, centering, first-column-as-row-header, and accessibility labels — are stored per field item and serialized into a `data-settings` attribute on output. The formatter emits only a hidden container plus a download link; the actual table is assembled in the browser: PapaParse downloads and parses the CSV file referenced by the link, and DataTables turns the parsed rows into a paginated, searchable, responsive table. This keeps the table HTML off the wire. An "autolink" option can turn designated URL columns into hyperlinks (via Autolinker), using link text taken from the column immediately to the left. External libraries (PapaParse, DataTables, DataTables Responsive, Autolinker) are loaded from CDN. The module depends on core `file` and the contrib `papaparse` module.

---

- Publish a spreadsheet export (CSV) on a node and have it shown as a sortable, paginated table without hand-building HTML.
- Attach tabular open-data (budgets, rosters, statistics) to content and present it interactively to visitors.
- Reduce page weight by sending the CSV file instead of a large rendered `<table>`, letting the browser build the table.
- Give end users a searchable table with a Search button that filters on submit (click/Enter), not on every keystroke.
- Offer an optional "hide data until search is submitted" mode so a large table is revealed only after the visitor searches (with a required accessible search prompt).
- Let editors choose an initial page length of 5, 10 or 15 rows, and optionally let visitors change it.
- Provide a "Download table data as CSV" link so visitors can grab the original file, with custom link text.
- Present the table responsively: fit columns that go across, and either show an expansion button or auto-expand overflow fields below each row.
- Turn a URL column into clickable links using descriptive text from the neighbouring column (autolink), hiding the raw URL column.
- Support several URL columns in one table by listing their column numbers (for example `3,5,8`).
- Tag the first column's cells as row headers (`<th>`) for accessible key-value style tables.
- Center table content for numeric or short-value tables.
- Give each table a short accessibility label so pagination and length controls get unique screen-reader names when multiple CSV tables share a page.
- Add a skip link before link-heavy tables so keyboard users can jump past body links to the footer controls.
- Normalize legacy content that stored large page-length values (25, 50…) down to the supported maximum (15) at runtime without a database migration.
- Preview the first rows of an uploaded CSV in the widget while choosing which columns hold URLs.
- Display multiple independent CSV tables on a single page, each with its own settings and accessible names.
- Swap the display off DataTables (plain client-rendered table) via the formatter's "Display as DataTable" toggle.
- Replace ad-hoc "paste an HTML table" workflows with a maintainable upload-a-CSV workflow for editors.
- Show reference data (price lists, schedules, directories) that changes by re-uploading a file rather than editing markup.
