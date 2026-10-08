<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The "Display file contents as table" formatter

## Install & enable

```bash
composer require drupal/file_table_formatter
drush en file_table_formatter -y
```

Only dependency is core **`file`** (declared in `file_table_formatter.info.yml` as
`dependencies: - drupal:file`). No sub-modules, no permissions of its own, no routes, no Drush
commands.

## Enable it on a field

The formatter (plugin id **`file_table_formatter`**, label *"Display file contents as table"*,
class `FileTableFormatter` extending `FileFormatterBase`) applies to **core file fields**
(`field_types = {"file"}`). It does **not** apply to image, link, or any custom field type.

UI path: create/choose a **File** field on a bundle, then
*Structure → (bundle) → Manage display* → set that field's format to
**Display file contents as table** → click the gear to set the options below.

Drush / config equivalent (view display):

```bash
drush cset core.entity_view_display.node.article.default \
  content.field_csv.type file_table_formatter -y
drush cr
```

Upload **CSV files** to the field. Only files whose MIME type is `text/csv` are parsed; anything
else renders an empty table for that item. Multi-value fields render one table per file.

## Formatter settings

From `defaultSettings()` and `settingsForm()` in `FileTableFormatter.php`:

| Setting key | Default | Meaning |
|---|---|---|
| `header` | `FALSE` | Treat the **first CSV row** as a header. `getTableDataFromFile()` `array_shift()`s it into `#header`, so it renders as `<th>` cells. |
| `use_text_format` | `FALSE` | When on, each cell is wrapped as a `#type => 'processed_text'` render element (see below). When off, cells are plain strings escaped by the table theme. |
| `text_format` | `''` | Machine name of the filter format to apply to cells; the select is populated from all `filter_format` entities and is only shown (via `#states`) when *use text format* is checked. |

`settingsSummary()` shows `Files include a header row: Yes/No`, and — when both `use_text_format`
and `text_format` are set — `Use text format: <format label>` (loading the `filter_format` entity
for its label).

Config schema for these three keys lives in
`config/schema/file_table_formatter.schema.yml` → `field.formatter.settings.file_table_formatter`
(`header` boolean, `use_text_format` boolean, `text_format` string).

### Example view-display config

```yaml
# core.entity_view_display.node.article.default
content:
  field_csv:
    type: file_table_formatter
    label: above
    settings:
      header: true
      use_text_format: false
      text_format: ''
```

## How the table is built

1. `viewElements()` calls `getEntitiesToView($items, $langcode)` — so core's file access checks
   and the display flag are honored — and for each `File` calls
   `$this->fileTableFormatterProcessor->getTableDataFromFile($file, $includes_header, $text_format)`.
   The render array is `#theme => 'file_table_formatter_table'`, `#data => <FileTableData>`,
   `#datatables => FALSE`.
2. `FileTableFormatterProcessor::getTableDataFromFile()` (service
   **`file_table_formatter.processor`**, interface `FileTableFormatterProcessorInterface`):
   - guards on `$file->getMimeType() == 'text/csv'`;
   - reads the **managed file's own URI** with `fopen($file->getFileUri(), 'r')` and a
     `while ($row = fgetcsv($fhandle))` loop (default delimiter `,`, enclosure `"`, escape `\`);
   - if a text format is passed, replaces each cell with
     `['data' => ['#type' => 'processed_text', '#text' => $col, '#format' => $text_format]]`;
   - takes the table **title** from `$file->_referringItem->description` (the file field's
     Description) when present;
   - if *header* is on, `array_shift()`s the first parsed row into the header;
   - returns a `FileTableData` object.
3. `FileTableData` (`src/FileTableData.php`) is a plain value object holding the file, the referring
   item, `rows`, `header`, `title`, with getters `getFile/getItem/getHeader/getRows/getTitle`.
4. `template_preprocess_file_table_formatter_table()` (in `file_table_formatter.module`) builds a
   core `#theme => 'table'` render array (`#header` = `getHeader()`, `#rows` = `getRows()`) and sets
   `title` from `getTitle()`. Template `templates/file-table-formatter-table.html.twig` prints an
   `<h2 class="file-table-title">{{ title }}</h2>` (Twig-autoescaped) when a title exists, then the
   table.

## How a cell is rendered / escaping

- With `use_text_format` **off** (default), cell strings go into the core table theme's `data`
  positions and are **escaped** — a cell containing `<script>` or other HTML is shown as literal
  text.
- With `use_text_format` **on**, cells become `#type => 'processed_text'` and are run through the
  **filter format an administrator selected** on the display. That is the intended mechanism for
  allowing links/markup inside cells; choose a restrictive format (not *Full HTML*) if the CSV data
  is not fully trusted, exactly as you would for any processed-text field.
- The file is read from `$file->getFileUri()` — the **managed file entity's own URI**, not a
  request- or config-supplied path — so there is no path-traversal surface. `getEntitiesToView()`
  applies core file access before anything is read.

## Gotchas

- **Only `text/csv` is supported.** A non-CSV upload silently yields an empty table (the processor's
  MIME guard is the only file-type handling).
- No delimiter/enclosure/escape settings — `fgetcsv()` is called with PHP defaults, so a
  semicolon- or tab-delimited file will not split into columns.
- The old Drupal 7 **DataTables** client-side sorting is not wired up in this D8+ version;
  `#datatables` is hard-coded `FALSE`. The project page notes it may return once the DataTables
  module updates.
- The full CSV is parsed into a render array on every uncached view; large files mean proportional
  memory/time.
- `FileTableData::getRows()` is typed `: array`; a non-CSV file leaves `rows` as `NULL` inside the
  object, but that path is only reached through the preprocess which reads it after the processor —
  in practice an empty/absent table renders for non-CSV items.
