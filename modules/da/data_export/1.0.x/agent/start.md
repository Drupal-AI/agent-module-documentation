<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Data Export (data_export) — agent index

Admin utility that exports database rows to **PDF, DOCX, CSV, or XLSX** downloads. Core `^10 || ^11`,
package `Custom`, security-advisory **not-covered**. Ships no permissions, no config, no config schema,
no Drush commands, no submodules.

## What it provides
- **Routes** (`data_export.routing.yml`), all gated by core permission `administer site configuration`:
  - `export_module.export_table_name` — `/admin/content/export-table-name`, form `ExportTableNameForm`.
  - `export_module.export_using_code` — `/admin/content/export-using-code`, form `ExportUsingCodeForm`.
  - `export_module.view_export_options` — `/admin/content/view-export-options`, `ExportController::viewExportRoutes`
    (a listing linking to the two forms; theme hook `export_options`).
- **Service** `data_export.data_export_service` = `Drupal\data_export\Service\DataExportService` (no args) —
  `exportCsv/exportXlsx/exportPdf/exportDocx($rows)` for associative-row arrays and
  `exportTableCsv/exportTableXlsx/exportTablePdf/exportTableDocx($data, $headers, $table_name)`.
- **Procedural helpers** in `data_export.module`: `exportCSV/exportXLSX/exportPDF/exportDocx($headers, $data)`,
  `validate_headers_data($headers, $data)`, plus `hook_theme()` and `hook_page_attachments()`.
- **Libraries** (`data_export.libraries.yml`): `datatables` (DataTables CDN + `js/datatables-init.js`) and
  `global_styling` (Bootstrap + Font Awesome CDN + `css/style.css`); the latter is attached on every page.
- **Menu links** (`data_export.links.menu.yml`) under System admin: "Export Data" and the two form links.

## Runtime dependencies (not auto-installed)
No `composer.json` ships. The writers require `phpoffice/phpspreadsheet` (XLSX), `phpoffice/phpword` (DOCX),
and `tecnickcom/tcpdf` (PDF) — `require` them manually or the corresponding format fatals.

## Solution docs
- [Forms, routes & operation](forms/export-forms.md) — the two export forms, the service, the procedural
  writers, permissions, and how a request flows to a download.
