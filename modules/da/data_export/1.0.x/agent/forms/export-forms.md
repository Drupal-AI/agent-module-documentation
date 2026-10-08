<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Data Export — forms, service & writers

## Install / enable
`drush en data_export`. No config to set up. Before using an export format, install its PHP writer
library (none are declared in a composer.json):
`composer require phpoffice/phpspreadsheet phpoffice/phpword tecnickcom/tcpdf`.
`hook_page_attachments()` attaches the `data_export/global_styling` library (Bootstrap + Font Awesome +
`css/style.css`) on every page of the site.

## Routes & access (`data_export.routing.yml`)
All three routes require the **core** permission `administer site configuration` (the module defines no
permission of its own):

| Route id | Path | Handler |
|---|---|---|
| `export_module.export_table_name` | `/admin/content/export-table-name` | Form `ExportTableNameForm` |
| `export_module.export_using_code` | `/admin/content/export-using-code` | Form `ExportUsingCodeForm` |
| `export_module.view_export_options` | `/admin/content/view-export-options` | `ExportController::viewExportRoutes` |

`ExportController::viewExportRoutes()` returns a `#theme => 'export_options'` render array (template
`templates/export-options.html.twig`) listing the two forms as links. Menu links in
`data_export.links.menu.yml` place an "Export Data" item under `system.admin`.

## ExportTableNameForm (`src/Form/ExportTableNameForm.php`)
- `buildForm()`: a `table_name` textfield with an AJAX `change` callback `fetchTableHeaders()`. When a
  table name is present, `getTableColumns($table_name)` queries `information_schema.columns`
  (filtered by `TABLE_NAME` and the current connection's `TABLE_SCHEMA`) and renders one checkbox per
  column (all checked by default). Plus an `export_format` select (csv/xlsx/pdf/docx) and submit.
- `submitForm()`: collects the ticked `header_*` checkboxes into `$selected_headers`, calls
  `fetchData($table_name, $selected_headers)` which runs
  `Database::getConnection()->select($table_name, 't')->fields('t', $selected_headers)->execute()->fetchAll()`,
  then dispatches to `DataExportService::exportTable{Csv,Xlsx,Pdf,Docx}($data, $selected_headers, $table_name)`.
  Selected headers are logged via `\Drupal::logger('data_export')`.

## ExportUsingCodeForm (`src/Form/ExportUsingCodeForm.php`)
- `buildForm()`: a required `sql_query` textarea, a "Show Records" submit with AJAX callback
  `showQueryResults()`, an `export_format` select, and an Export submit. Attaches the `data_export/datatables`
  library.
- `executeQuery($sql_query)`: `Database::getConnection()->query($sql_query)->fetchAll()` (wrapped in
  try/catch, errors surfaced via Messenger).
- `showQueryResults()`: runs the query and renders the rows into an HTML table (cell values passed through
  `htmlspecialchars`) for preview.
- `submitForm()`: runs the query, casts each `stdClass` row to an array, and dispatches to
  `DataExportService::export{Csv,Xlsx,Pdf,Docx}($results_array)`.

## DataExportService (`src/Service/DataExportService.php`)
Registered as `data_export.data_export_service` with no constructor args. Two families of methods:
- Query-form family `exportCsv/exportXlsx/exportPdf/exportDocx($data)` — treats `$data` as an array of
  associative rows; header row is `array_keys(reset($data))`.
- Table-form family `exportTableCsv/exportTableXlsx/exportTablePdf/exportTableDocx($data, $headers, $table_name)`.

Each method sets `Content-Type`/`Content-Disposition` headers, writes to `php://output`
(CSV via `fputcsv`; XLSX via `PhpSpreadsheet` `Xlsx` writer; PDF via `TCPDF::writeHTML` + `Output(..., 'D')`;
DOCX via `PhpWord` `Word2007` writer), and calls `exit()`. Because the service `exit()`s mid-request, the
"Export initiated" status messages set after the dispatch never actually render.

## Procedural writers (`data_export.module`)
`exportPDF/exportDocx/exportCSV/exportXLSX($headers, $data)` are standalone helpers taking explicit header
and data arrays. Each raises `memory_limit` to 512M and `set_time_limit(0)`, calls
`validate_headers_data($headers, $data)` (both must be arrays and every row's column count must equal the
header count), then streams the same four formats. These are callable from custom code but are **not** wired
to any route or form in this module.

## Operating notes
- Exports read straight from the database layer, not from Drupal entities.
- All exports are triggered by form POST submissions (core CSRF token applies); the listing route is a
  read-only GET.
- The PDF and CSV writers `htmlspecialchars`/`fputcsv` cell values; DOCX/`PhpWord` `addText` treats values
  as plain text (no HTML interpretation). Files are downloaded, not rendered in the site.
