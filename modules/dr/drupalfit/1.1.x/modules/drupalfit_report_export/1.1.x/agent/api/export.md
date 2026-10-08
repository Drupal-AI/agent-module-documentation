<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Export route, permission, and export_type plugins

## Enable

```bash
drush en drupalfit_report_export -y   # requires drupalfit
```

Once enabled, `drupalfit_get_export_data()` (in the parent module) adds an export link per discovered
format to the report page, and `drupalfit_preprocess_drupalfit_report()` attaches the `export_buttons`
library.

## Route & permission

- Route `drupalfit_report_export.export`
  (`drupalfit_report_export.routing.yml`): path
  `/admin/reports/drupalfit-report/export/{format}/{report_id}`, `report_id` defaults to `null`,
  `no_cache: true`, controller `Controller\ExportController::export`.
- Requirement `_permission: "view drupalfit reports+export drupalfit reports"` — the `+` means **either**
  permission grants access. `export drupalfit reports` is defined in
  `drupalfit_report_export.permissions.yml`; `view drupalfit reports` comes from the parent module.

## ExportController::export (`src/Controller/ExportController.php`)

1. 404 (`NotFoundHttpException`) if `{format}` is not a known `export_type` plugin.
2. `loadReportData($report_id)`: loads the `fit_report_history` entity by id, or — when no id — the latest
   one (entity query with `accessCheck(FALSE)`, sorted by `created`/`id` desc). Decodes `report_result` +
   `report_score` JSON and assembles `{overall_score, overall_max_score, group_scores, grouped_results,
   metadata:{report_id, generated_at, site_name, label}}`. Returns `NULL` (→ 404) if nothing usable.
3. Instantiates the plugin, calls `export($report_data)` for the body and `filename(...)` for a
   timestamped name, and returns a `Response` with `Content-Type` from `mimeType()`. Disposition is
   `inline` for `text/html` (the PDF/HTML format) and `attachment` otherwise. No file is written to disk;
   the content is streamed in the response.

## export_type plugin type

- Manager `PluginManager\ExportTypePluginManager` — dir `Plugin/ExportType`, interface
  `ExportTypeInterface`, attribute `Attribute\ExportType`, alter hook `export_type_info`.
- Attribute `ExportType(id, extension, mimeType, label, description?, deriver?)`.
- Base `ExportTypePluginBase` supplies `label()`, `extension()`, `mimeType()`,
  `filename($base) = "$base.$extension"`. A plugin implements `export(array $report_data): string|array`.

### Shipped plugins (`src/Plugin/ExportType/`)

- **`CsvExport`** (`csv`, `text/csv`): flattens the report to one CSV row per finding. Columns =
  `metadata__*` + `overall_score`, `overall_max_score`, `group`, `severity` + `group_score__*` +
  `item__*` (keys collected across all findings). Built via `fputcsv` on a `php://temp` stream.
  `normalizeValue()` JSON-encodes arrays/objects, maps bools to `true`/`false`, and — for values that
  look like HTML — runs `strip_tags` + `html_entity_decode` + whitespace-collapse so cells are clean
  plain text.
- **`JsonExport`** (`json`, `application/json`): `json_encode` of the whole `$report_data` with pretty
  print + unescaped unicode/slashes.
- **`PdfExport`** (id `pdf`, extension `html`, mime `text/html`): renders the parent module's
  `drupalfit_report` theme inside the `drupalfit_report_export_pdf_page` theme (template
  `templates/drupalfit-report-export-pdf-page.html.twig`) via `renderer->renderRoot()`, inlining
  `drupalfit`'s `css/security-report.css`, this module's `css/export-pdf.css`, and `js/export-pdf.js`
  (loaded from module paths with `file_get_contents`). Despite the `pdf` id/label it emits HTML; an
  installed PDF library (TCPDF/mPDF/Dompdf) is only *detected* by `hook_requirements`, not required.

## Config (`drupalfit_report_export.settings`)

Schema `config/schema/drupalfit_report_export.schema.yml`; install defaults
`config/install/drupalfit_report_export.settings.yml`: `default_format: 'csv'`, `pdf_library: 'html'`,
`max_export_size: 50` (MB). No config form ships in this submodule.
