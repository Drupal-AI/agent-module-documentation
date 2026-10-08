<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Data Export Excel (views_data_export_excel) — agent index

Adds a native **Excel (.xlsx)** output format to **Views Data Export**. Version **1.0.2**.
Package `Views`. Core `^10.3 || ^11`. License GPL-2.0-or-later.

## What it actually is

A thin glue module: **two plugin classes and a config schema**, nothing else. No routes,
permissions, services, hooks, Drush commands or submodules of its own. The export route and its
access come from the **Views Data Export** `DataExport` display it subclasses; the actual `.xlsx`
writing (via `phpoffice/phpspreadsheet`) comes from the **XLS Serialization** module it mixes in.

- **Dependencies** (`.info.yml` + `composer.json`): `views_data_export:views_data_export` and
  `xls_serialization:xls_serialization` (require `^2.1`, needs **2.1.0+**). PhpSpreadsheet is a
  transitive dependency pulled in by XLS Serialization.
- Subclasses classes owned by Views Data Export, so a BC break there can break this module.

## Provides (both keyed `data_export_excel`)

- **Display plugin** `Drupal\views_data_export_excel\Plugin\views\display\ExcelExport`
  (`@ViewsDisplay id="data_export_excel"`, `uses_route=TRUE`, `returns_response=TRUE`) —
  extends `views_data_export\...\display\DataExport`, uses `xls_serialization`'s
  `ExcelExportDisplayTrait`. Overrides `$contentType = 'xlsx'` and `buildOptionsForm()` to add the
  style/format-header/conditional-formatting sub-forms.
- **Style plugin** `Drupal\views_data_export_excel\Plugin\views\style\ExcelExport`
  (`@ViewsStyle id="data_export_excel"`, `display_types={"data"}`) — extends
  `views_data_export\...\style\DataExport`, uses `xls_serialization`'s `ExcelExportStyleTrait`,
  calls `initializeSerializerFormats()` from its constructor.

## Config schema (`config/schema/views_data_export_excel.views.schema.yml`)

Extends the Views Data Export schema types:
- `views.display.data_export_excel` → `header_bold`, `header_italic`, `header_background_color`,
  `header_text_color`.
- `views.style.data_export_excel` → `xls_settings` (`xls_format`, `strip_tags`, `trim`, and a
  `metadata` mapping: creator, last_modified_by, title, description, subject, keywords, category,
  manager, company).

## Solution docs

- **Install, the two plugins, and how to add the export to a View** →
  [plugins/excel-export.md](plugins/excel-export.md)
- **Config schema keys, the Excel presentation options, and where writing actually happens** →
  [config/options.md](config/options.md)
