<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DrupalFit Report Export (drupalfit_report_export) — agent index

Optional DrupalFit submodule. Adds a permission-gated download route that renders a stored
`fit_report_history` report as CSV, JSON, or printable HTML via an `export_type` plugin type.
Package `DrupalFit`. Core `^10.2 || ^11`. Depends on `drupalfit:drupalfit`. License GPL-2.0-or-later.
Version 1.1.3.

- **Export route, permission, the export_type plugin type, the 3 shipped formats, config** →
  [api/export.md](api/export.md)

## What it provides

- **Plugin type** `export_type` (`ExportTypePluginManager`, dir `Plugin/ExportType`, interface
  `ExportTypeInterface`, base `ExportTypePluginBase`, attribute `Attribute\ExportType`, alter hook
  `export_type_info`, service `plugin.manager.drupalfit_export_type`).
- **3 plugins**: `csv` (`CsvExport`), `json` (`JsonExport`), `pdf` (`PdfExport`, id `pdf` but extension
  `html`, mime `text/html`).
- **Route** `drupalfit_report_export.export`:
  `/admin/reports/drupalfit-report/export/{format}/{report_id}` → `Controller\ExportController::export`.
- **Permission** `export drupalfit reports`. Route requirement is
  `view drupalfit reports+export drupalfit reports` (either permission grants access).
- **Config** `drupalfit_report_export.settings` (`default_format`, `pdf_library`, `max_export_size`);
  schema + install defaults ship. No settings form route in this submodule.
- **Hooks** (`.module`): `hook_help`, `hook_theme` (`drupalfit_report_export_pdf_page`). `.install`
  `hook_requirements` reports whether TCPDF/mPDF/Dompdf is available (info-only).
- Libraries `export_buttons` / `export_pdf` and JS `export-dropdown.js`, `export-pdf.js`.

## Key facts

- The export route/controller loads report data with `report_id` when provided, else the latest report
  (query uses `accessCheck(FALSE)` on the entity query for the "latest" lookup). Missing/invalid report →
  404. Access is enforced by the route permission, not by per-entity access.
- CSV output is built with `fputcsv` on a `php://temp` stream; `CsvExport::normalizeValue()` strips tags
  and decodes entities from message strings and JSON-encodes nested values. JSON export is
  `json_encode` of the whole report array. PDF export renders the `drupalfit_report` theme into a
  standalone HTML document with inlined CSS/JS (read from module files with `file_get_contents`).
