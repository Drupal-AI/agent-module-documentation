<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# XLS Views Data Export (xls_views_data_export) — agent index

Extends **Views Data Export** so a `data_export` display can write its rows into an
**existing XLS/XLSX template workbook** (a branded sheet with headers/formatting/formulas already
in place) instead of a blank grid. It swaps the class behind the built-in `data_export` display via
`hook_views_plugins_display_alter`, adds a few per-display options, and streams the merged workbook
through a small upload form. Requires `phpoffice/phpspreadsheet ^2.3` and the PHP `zip` extension.

Dependencies: `views_data_export` and `xls_serialization` (Drupal modules; **not** declared in
composer.json — install them explicitly), plus Composer libs `phpoffice/phpspreadsheet` + `ext-zip`.
No settings page (all config is per-view-display). No permissions of its own, no Drush, no config
schema shipped.

- **Add XLS/XLSX-into-template export to a view** → [views/xls_data_export.md](views/xls_data_export.md)
- **Understand the per-display options (default template, worksheet name, override, flip path)** → [views/xls_data_export.md](views/xls_data_export.md)
- **How the export route/form/response merge into the template at runtime** → [views/xls_data_export.md](views/xls_data_export.md)
- **The request subscriber that fulfils the export redirect** → [events/export_redirect.md](events/export_redirect.md)

Key facts:
- Display plugin: `Drupal\xls_views_data_export\Plugin\views\display\XlsDataExport extends
  Drupal\views_data_export\Plugin\views\display\DataExport`, `const DISPLAY_PLUGIN = 'data_export'`.
- Installed by ALTER, not by a new plugin id: `xls_views_data_export_views_plugins_display_alter()`
  rewrites `$definitions['data_export']['class']` to `XlsDataExport`.
- Per-display option keys (stored on `views.display.data_export`): `default_fid`,
  `default_worksheet_name`, `default_override_sheet`, `flip_path`.
- Export form: `Drupal\xls_views_data_export\Form\XlsExportForm` (form id `xls_export_form`).
- Service: `xls_views_data_export.export_redirect` →
  `Drupal\xls_views_data_export\EventSubscriber\ExportRedirectSubscriber` (KernelEvents::REQUEST, priority -64).
- Route created per view/display only when export is enabled: `view.<view_id>.<display_id>.export`
  (with `_excel_file` / `_worksheet_name` / `_override_sheet` path params).
- Install requirement: `xls_views_data_export_requirements()` errors if the PHP `zip` extension is missing.
