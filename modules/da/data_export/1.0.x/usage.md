Data Export gives a site administrator two admin forms for dumping database rows into downloadable PDF, DOCX, CSV, or XLSX files.

---

The module adds an "Export Data" admin section with two workflows. "Export Using Table Name" (`/admin/content/export-table-name`) takes a database table name, lists that table's columns as checkboxes (read from `information_schema.columns`), and exports the selected columns. "Export Using Code" (`/admin/content/export-using-code`) runs a hand-written SQL query, optionally previews the first rows in a DataTables grid, and exports the result set. Both forms end in a format selector (CSV, XLSX, PDF, DOCX). File generation is centralised in `DataExportService` (per-row array data) and in procedural helpers in `data_export.module` (`exportCSV`, `exportXLSX`, `exportPDF`, `exportDocx`, which take explicit `$headers`/`$data` arrays and validate that column counts match). CSV uses `fputcsv`, XLSX uses PhpSpreadsheet, PDF uses TCPDF, and DOCX uses PhpWord; each writer streams to `php://output` as a file download. Every route requires the core `administer site configuration` permission. The module ships no permissions, no config objects, no config schema, and no Drush commands, and it depends on three PHP libraries (phpoffice/phpspreadsheet, phpoffice/phpword, tecnickcom/tcpdf) that are not declared in a composer.json and must be installed manually.

---

- Give a site administrator a quick way to download the contents of a single database table as CSV.
- Export a chosen subset of a table's columns by ticking only the columns you need before export.
- Export the result of an ad-hoc SQL query without writing a custom module or Views export.
- Produce an XLSX spreadsheet of query results for a stakeholder who works in Excel.
- Generate a printable PDF report of tabular data with a bordered table and page footer.
- Produce a DOCX document of tabular data for editing or inclusion in a Word report.
- Preview the first rows of a SQL query in a DataTables grid before committing to an export.
- Pull a list of rows from a custom (non-entity) table that Views does not model.
- Do a one-off data extract during a migration or QA pass without database client access.
- Hand a non-technical admin a UI to download reference data instead of running raw queries.
- Export a join across multiple tables by writing the JOIN in the "Export Using Code" form.
- Snapshot a lookup/config table to a file for archival or diffing between environments.
- Offer the same dataset in four formats (CSV, XLSX, PDF, DOCX) from one form submission.
- Call the procedural `exportCSV($headers, $data)` helper from custom code to stream a CSV download.
- Call `exportXLSX($headers, $data)` from custom code to build an XLSX with bold, centered headers.
- Call `exportPDF($headers, $data)` from custom code to render an HTML table into a TCPDF download.
- Call `exportDocx($headers, $data)` from custom code to build a DOCX table download.
- Use `DataExportService::exportCsv($rows)` when your data is an array of associative rows (keys become headers).
- Validate that headers and data have matching column counts before exporting via `validate_headers_data()`.
- Add an admin-only "download this table" affordance to an internal Drupal tool.
- Extract audit/log rows from a custom logging table for offline analysis.
- Give an admin a self-service report export so developers are not asked to run exports by hand.
