<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# File Table Formatter (file_table_formatter) — agent index

A single field formatter that reads an uploaded **CSV file** and renders its rows as an **HTML
table** on the entity display. Depends only on core **`file`**. Core requirement
`^8 || ^9 || ^10 || ^11`. License GPL-2.0-or-later. Version 2.0.2. No package set in `.info.yml`.

- **The formatter, its three settings, the processor service, the theme hook, and how to enable
  it** → [fields/formatter.md](fields/formatter.md)

## What it actually is

- One plugin: `FileTableFormatter` (id **`file_table_formatter`**, label *"Display file contents
  as table"*), in `src/Plugin/Field/FieldFormatter/FileTableFormatter.php`, extending core's
  `FileFormatterBase`. `field_types = {"file"}` — core **file fields only** (not image, not link,
  not a custom type). No widget, no field type, **no routes, no permissions, no Drush, no hooks
  other than theme**.
- It changes only how a file field is **displayed**. Selected per view-display on *Manage display*.
- One service: **`file_table_formatter.processor`** → `FileTableFormatterProcessor`
  (`src/FileTableFormatterProcessor.php`), interface `FileTableFormatterProcessorInterface`. It
  turns a `File` entity into a `FileTableData` value object (`src/FileTableData.php`).
- One theme hook: **`file_table_formatter_table`** (template
  `templates/file-table-formatter-table.html.twig`), registered in
  `file_table_formatter.module`; preprocess builds a core `#theme => 'table'` render array.
- Config schema for the formatter settings: `config/schema/file_table_formatter.schema.yml`
  (`field.formatter.settings.file_table_formatter`).

## Mechanism (from source)

- `FileTableFormatter::viewElements()` iterates `getEntitiesToView($items, $langcode)` (so core
  file access / display flag is honored), and for each `File` calls
  `$this->fileTableFormatterProcessor->getTableDataFromFile($file, $includes_header, $text_format)`,
  emitting `#theme => 'file_table_formatter_table'`, `#data => <FileTableData>`, `#datatables => FALSE`.
- `FileTableFormatterProcessor::getTableDataFromFile()` **only** processes files whose
  `getMimeType() === 'text/csv'`. It reads the **managed file's own URI** with
  `fopen($file->getFileUri(), 'r')` and a `while ($row = fgetcsv($fhandle))` loop (default CSV
  parameters). With a text format selected, each cell becomes a `#type => 'processed_text'` render
  array; otherwise the raw cell string. If *header* is on, `array_shift()` removes the first row as
  the header. Table **title** = the referring field item's `description` (`$file->_referringItem->description`).
- `FileTableData` is a plain value object with `getFile/getItem/getHeader/getRows/getTitle`.
- `template_preprocess_file_table_formatter_table()` maps that object onto a core
  `#theme => 'table'` (`#header` = `getHeader()`, `#rows` = `getRows()`) plus a `title` variable;
  the Twig template prints an `<h2>` title (autoescaped) then the table.

## Settings (formatter, `defaultSettings()`)

`header` (FALSE — treat first CSV row as `<th>` header), `use_text_format` (FALSE),
`text_format` (`''`). Details, the settings form, `settingsSummary()`, and a config-export example
in [fields/formatter.md](fields/formatter.md).

## Notes / caveats

- **Only `text/csv` files render** — any other MIME type yields an empty table for that item.
- Cell text placed into the core table array is **escaped by the table theme**; when
  *use text format* is on, cells are instead run through the **admin-selected filter format**
  (a display-config choice), which is the intended way to allow links/markup in cells.
- The whole CSV is parsed into a render array on each uncached view — size source files accordingly.
- The old Drupal 7 **DataTables** client-side sorting is **not** implemented in this D8+ version
  (`#datatables` is hard-coded `FALSE`); the project page notes it may return if DataTables updates.
