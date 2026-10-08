<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform XLSX Export — agent index

Adds one Webform exporter plugin, **`xlsx`** (label *"XLSX"*), that writes real Office Open
XML workbooks with **PhpSpreadsheet**, replacing Webform's fake-`.xls` `table` exporter.

Key facts:

- **No settings page** (`configure: null`), no permissions, no config object, no Drush
  commands of its own, no config schema. Enabling the module is the whole install.
- Requires `phpoffice/phpspreadsheet ^3.5` — installed by Composer; `hook_requirements()`
  reports it on `/admin/reports/status`.
- The plugin id used everywhere (Download form, `drush webform:export --exporter=xlsx`,
  saved export settings) is literally **`xlsx`**.
- Per-webform saved export settings live in **webform state**, key `results.export`
  (`$webform->getState('results.export')`), not in a config object.

Docs:

- **Export from the UI / Drush / code, and persist XLSX as a webform's default** →
  [configure/exporting.md](configure/exporting.md)
- **The `XlsxExporter` plugin: what it overrides, quirks, subclassing** →
  [plugins/xlsx-exporter.md](plugins/xlsx-exporter.md)
- **`drush webform:export` options that matter for XLSX** → [drush/webform-export.md](drush/webform-export.md)
