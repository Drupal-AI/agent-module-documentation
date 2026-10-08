<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
XLS Views Data Export extends the Views Data Export module so a `data_export` display can write its rows into an **existing XLS/XLSX template workbook** — a branded sheet with headers, formatting and formulas already in place — instead of generating a blank grid, with an upload form and export route to drive it.

---

Views Data Export gives Views a `data_export` display that streams CSV/XML/JSON, and `xls_serialization` adds XLS/XLSX encoders. This module builds on both. Rather than registering a new display id, `xls_views_data_export_views_plugins_display_alter()` swaps the class behind the existing `data_export` display to `XlsDataExport`, which subclasses `DataExport` (`const DISPLAY_PLUGIN = 'data_export'`) and only alters behaviour when the selected format resolves to content type `xls`. Its headline feature is merging the exported rows into a pre-built workbook: the parent renders the view to a fresh XLSX via `xls_serialization`, then `buildResponse()` loads both that output and a template file with PhpSpreadsheet's `IOFactory`, moves the result sheet into the template with `addExternalSheet()` (optionally overriding a same-named sheet), and streams the combined `Excel2007` workbook. Four per-display options — `default_fid` (a template file entity), `default_worksheet_name`, `default_override_sheet`, and `flip_path` — are added under the display's Path settings; an `XlsExportForm` lets the user upload or confirm a template and name the sheet at request time; and an `ExportRedirectSubscriber` returns the merged workbook directly when a default template is preconfigured. `collectRoutes()` builds a `view.<view_id>.<display_id>.export` route (only when export is enabled) and rewrites contextual-filter segments into named parameters so exports work on argument-driven views. Note the module's `info.yml` carries a `@TODO` admitting its `views_data_export` and `xls_serialization` dependencies are not declared in composer.json (install them explicitly), it needs `phpoffice/phpspreadsheet ^2.3` and the PHP `zip` extension, and its config-schema-adding hook is misnamed so the four option keys ship without config schema.

---

- Export a view into a branded spreadsheet template.
- Preserve headers, formatting and formulas defined in an existing workbook.
- Provide XLSX downloads from a Views listing.
- Export a filtered report into a designer-supplied layout.
- Generate exports from views that use contextual filters.
- Offer an export route only where the display has export enabled.
- Let editors upload a template and pick a worksheet name at export time.
- Preconfigure a default template file so exports skip the upload form.
- Write view rows into a specific named worksheet of a workbook.
- Override an existing sheet in the template instead of duplicating it.
- Swap the export form to the primary view path via the flip-path option.
- Redirect straight to the finished download when a template is preset.
- Produce recurring finance or management reports with a consistent look.
- Standardise report appearance across a site.
- Reuse one branded template across several views.
- Provide XLSX alongside CSV from the same data-export display.
- Support large exports through Views Data Export's batching.
- Give editors a one-click, formatted report download.
- Combine live Views filters with a fixed report template.
- Export member or order listings for external systems.
- Reduce manual work assembling monthly spreadsheets.
- Keep column styling under a designer's control, not the exporter's.
