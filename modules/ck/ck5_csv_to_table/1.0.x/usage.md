A CKEditor 5 toolbar button that converts an uploaded .csv file into a standard, editable HTML table directly in the editor.

---

CKEditor 5 CSV to Table registers a CKEditor 5 plugin (`csvImport` toolbar item, JS plugin `csv_importer.CsvImporter`) that adds a "Import CSV and Generate Table" button. When clicked it opens a file picker, reads the chosen CSV client-side with `FileReader`, parses it with a custom chunked parser (handles quoted fields, escaped double-quotes, and CRLF/LF line endings), and builds a native CKEditor table via the editor model — the first row becomes the heading row (`headingRows: 1`). Everything happens in the browser: there is no server route, no upload endpoint, and no configuration form. Cell text is inserted through the CKEditor model's `writer.insertText` (text nodes only), and the resulting table markup is stored and filtered by the text format like any other CKEditor content. A progress overlay reports 0-100% while parsing (500 rows per tick) and inserting (25 rows per model change) to keep large files (up to 50MB, up to 6,000 rows / 100 columns after a confirm prompt) responsive. Visibility of the button is controlled by the `use csv importer` permission, which the module exposes to the client through `drupalSettings.ck5_csv_to_table.hasPermission` via a `#pre_render` callback on the `text_format` element. The generated table is a normal CKEditor table, so it remains fully editable with core table tools after insertion.

---

- Add a "CSV Importer" button to a CKEditor 5 toolbar so editors can build tables from spreadsheet exports without writing HTML.
- Let non-technical editors paste in comparison tables, pricing grids, or spec sheets exported as CSV from Excel or Google Sheets.
- Refresh a data table in an article by re-importing an updated CSV instead of hand-editing rows.
- Populate pricing tables, financial summaries, or quarterly report tables from a maintained CSV source.
- Insert event schedules, sports scoreboards, or timetables kept in a spreadsheet.
- Build inventory or product listing tables that change frequently.
- Generate feature-comparison matrices for product or landing pages.
- Convert KPI / analytics exports into on-page Drupal tables.
- Turn research datasets or survey results into readable tables in long-form content.
- Import multi-hundred-row datasets that would be tedious to type cell-by-cell.
- Load large CSVs (thousands of rows) with a progress bar and chunked processing that keeps the editor usable.
- Use the first CSV row automatically as the table header row.
- Restrict who can import CSVs by granting the "Use CSV Importer" permission only to trusted editorial roles.
- Keep tables fully editable after import using CKEditor's native table column/row/merge tools.
- Handle CSVs with commas inside quoted fields and escaped quotes without breaking columns.
- Import CSVs saved on Windows (CRLF) or Unix (LF) without manual cleanup.
- Cap oversized imports (rows/columns) with a user confirmation dialog before trimming to safe limits.
- Provide editors a one-click alternative to manually drawing tables cell by cell.
- Standardize table structure across a site by sourcing tables from CSV files.
- Speed up editorial workflows for data-heavy documentation pages.
