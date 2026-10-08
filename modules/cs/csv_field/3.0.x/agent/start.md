<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CSV Field (csv_field) — agent index

A file-field type that stores an uploaded **CSV file** and renders it as an interactive HTML table.
The table is built **client-side**: PapaParse parses the file, DataTables renders it. Package
`Field types`. Core `^9.3 || ^10 || ^11`. License GPL-2.0-or-later. Version 3.0.6.

Dependencies: core **`file`** and the contrib **`papaparse`** module (`drupal/papaparse ^1.0`).
No config settings form, **no permissions of its own**, no Drush, no submodules (`tests/modules/csv_field_test`
is a test fixture only).

- **Field type, widget, and every per-item display setting** → [fields/field.md](fields/field.md)
- **Formatter, client-side rendering pipeline, DataTables/PapaParse/Autolinker libraries** →
  [fields/formatter.md](fields/formatter.md)

## What it provides (from source)

- **Field type** `csv_file` — `src/Plugin/Field/FieldType/CsvFileItem.php`, extends core
  `FileItem`. Forces `file_extensions = 'csv'` (the extensions setting is shown disabled). Adds a
  serialized `settings` (text/big) column to the field storage schema. Default widget
  `csv_file_generic`, default formatter `csv_file_table`.
- **Widget** `csv_file_generic` — `src/Plugin/Field/FieldWidget/CsvFileWidget.php`, extends core
  `FileWidget`, implements `TrustedCallbackInterface`. Adds a "Display Configuration" details
  panel and (when a file is uploaded) a header preview with URL-column checkboxes. Validates the
  optional search prompt and URL-column-numbers input. All choices are saved into the item's
  `settings` array.
- **Formatter** `csv_file_table` — `src/Plugin/Field/FieldFormatter/CsvFileTableFormatter.php`,
  extends `DescriptionAwareFileFormatterBase`. One setting `display_as_datatable` (bool, default
  TRUE). Emits `#theme => 'csv_table'`, JSON-encoding the merged settings into
  `data-settings`.
- **Theme hook** `csv_table` (`csv_field_theme()` + `template_preprocess_csv_table()` in
  `csv_field.module`), template `templates/csv-table.html.twig`. Renders only a container
  `<div class="csv-table hidden">` and a file download `link`; attaches the JS library.
- **Config schema** `config/schema/csv_file.schema.yml` — storage/field/widget settings reuse the
  core file schemas; the formatter schema adds `display_as_datatable` (boolean).
- **Libraries** `csv_field.libraries.yml` — `csv_field` (front-end JS + CSS, depends on DataTables,
  PapaParse, Autolinker, DataTables Responsive), `csv_preview` (widget preview JS), and the
  CDN-hosted `papaparse` 5.3.0, `datatables_cdn` 2.3.7, `datatables_responsive` 3.0.7,
  `autolinker` 3.14.3 external libraries.

No routes, no services, no hooks beyond `hook_theme()` and the preprocess function.
