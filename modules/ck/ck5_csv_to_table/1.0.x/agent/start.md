<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor 5 CSV to Table (ck5_csv_to_table) — agent index

Client-side CKEditor 5 plugin. Adds a toolbar button that reads a chosen `.csv`
file in the browser and inserts it as a native, editable CKEditor table (first
row = heading row). No server route, no upload endpoint, no config form, no
custom text-format filter — the generated table is stored and filtered by the
text format like any other CKEditor content.

## Requirements / dependencies
- Drupal core `^10 || ^11`; module dependency `drupal:ckeditor5`.
- No Composer requirements, no submodules, no config schema, no services,
  no routing, no Drush commands.
- Package: `CKEditor 5`. License GPL-2.0-or-later. Not covered by a security policy.

## What it provides
- **CKEditor 5 plugin** `csv_importer.CsvImporter` with toolbar item `csvImport`
  (`ck5_csv_to_table.ckeditor5.yml`). Declares allowed elements
  `<table> <thead> <tbody> <tr> <td> <th>` and requires the core
  `ckeditor5_table` plugin. Extends `table.contentToolbar` with
  `tableColumn`, `tableRow`, `mergeTableCells`.
- **Libraries** (`ck5_csv_to_table.libraries.yml`): `importer`
  (`js/csv-importer.js`; deps `core/ckeditor5`, `core/drupalSettings`) and
  `admin` (`css/admin-icons.css`).
- **Permission** `use csv importer` (`ck5_csv_to_table.permissions.yml`,
  `restrict access: true`) — gates whether the button is shown.
- **Hook** `hook_element_info_alter()` (`ck5_csv_to_table.module`) adds a
  `#pre_render` callback to the `text_format` element pointing at
  `ElementSettingsAttachment::getSettings`.
- **PHP class** `Drupal\ck5_csv_to_table\Render\ElementSettingsAttachment`
  (implements `TrustedCallbackInterface`) — attaches
  `drupalSettings.ck5_csv_to_table.hasPermission` and adds
  `user.permissions` + `session` cache contexts. This is the only PHP logic.

## Behavior notes
- All CSV parsing and table building is JavaScript (`js/csv-importer.js`):
  `FileReader.readAsText`, a custom chunked CSV parser (500 rows/tick), and
  insertion via the CKEditor model (`insertTable` + `writer.insertText`,
  25 rows per model change) with a progress overlay.
- Limits: 50MB file, 6,000 rows, 100 columns, 10,000 chars/cell (confirm
  prompt then trim when rows/cols exceeded).

## Solution docs
- [Install, permission & toolbar setup](config/setup.md)
- [The CKEditor plugin & JS behavior](plugins/csv_importer.md)
