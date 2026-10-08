<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Excel Importer (excel_importer) — agent index

Bulk-creates Drupal **nodes** from an uploaded `.xlsx` spreadsheet. One worksheet per content
type; the sheet title is the content-type machine name and the header row holds field machine
names. Parsing is done by `phpoffice/phpspreadsheet ^3`; requires PHP `^8.1`, core
`^9.5 || ^10 || ^11`. No module dependencies declared in `info.yml` (uses core node/taxonomy).

`configure`: `excel_importer.admin_settings` (`/admin/config/content/excel_importer`). Defines
2 permissions, no Drush commands, no plugin types, one config object with schema.

- **Run an import — the upload form, spreadsheet contract, validation, node creation** →
  [configure/import.md](configure/import.md)
- **Admin settings — allowed content types + intro text, the config object** →
  [configure/settings.md](configure/settings.md)
- **The two permissions** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Routes: `excel_importer.import_form` → `/excel-import` (perm `use excel_importer`, form
  `ExcelImporterForm`); `excel_importer.admin_settings` → `/admin/config/content/excel_importer`
  (perm `administer excel_importer`, form `ExcelImporterSettingsForm`).
- Config object `excel_importer.settings` with keys `allowed_types` (sequence of content-type
  machine names; install default `[article]`) and `introduction` (a `text_format` string).
- Upload field `excel_file` is a `managed_file`, extension-restricted to `xlsx`, stored at
  `public://content/excel_files/`, required.
- Import is synchronous in `ExcelImporterForm::submitForm()` (no Batch API); nodes are created with
  `entityTypeManager->getStorage('node')->create($values)->save()`.
- Spreadsheet layout: sheet title = bundle machine name; **row 2** = field-machine-name header;
  rows **> 2** = data; row 1 and fully-empty rows are ignored. No column may be named `type`.
- Permissions `excel_importer.permissions.yml`; help theme hook `excel_importer_help`
  (template `templates/excel-importer-help.html.twig`), rendered by `hook_help`.
