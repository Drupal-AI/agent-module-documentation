<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CSV File Formatter (csvfile_formatter) — agent index

A single field formatter that reads an uploaded **CSV file** and renders it as an **HTML table**
on the entity display. Package `Fields`. Depends only on core **`file`**. Core requirement
`^8 || ^9 || ^10 || ^11`. License GPL-2.0-or-later. Version 1.0.26.

- **The formatter, every setting, how to enable it, and the DataTables integration** →
  [fields/formatter.md](fields/formatter.md)

## What it actually is

- One plugin: `CSVFileFormatter` (id **`csvfile_formatter`**, label *"CSV file as table"*), in
  `src/Plugin/Field/FieldFormatter/CSVFileFormatter.php`, extending core's `FileFormatterBase`.
  `field_types = { "file" }` — it targets **core file fields only** (not link fields, not a
  custom field type). No widget, no field type, **no permissions**, no Drush, no hooks.
- It changes only how a file field is **displayed**. Selected per view-display on *Manage
  display*.

## Mechanism (from source)

- `viewElements()` iterates `getEntitiesToView()` (so core file access / display flag is honored),
  resolves the real path with `file_system->realpath($file->uri) ?: $file->getFileUri()`, and
  calls `readCsv()`.
- `readCsv()` uses `fopen()` + a `fgetcsv($handle, 0, $separator, $enclosure, $escape)` loop.
  First row → `#header` when *has header* is on; remaining rows → `#rows`. Builds a
  `#theme => 'table'` render array with optional `#caption` (field description or filename),
  `#sticky`, CSS classes and an `id` of `{field}-{n}-csvfiletable`.
- Cell text goes into the table array's `data` keys → **escaped by the table theme** (safe;
  literal `<script>` renders as text). `processColumnData()` optionally converts URL / email /
  `[text](url)` Markdown cells into `Link` objects when *smart URLs* is on.
- Reads the **managed file's own URI** — not a request- or config-supplied path — so there is no
  path-traversal surface.

## Settings (formatter, `defaultSettings()`)

`csvfile_formatter_download_link` (TRUE), `_download_link_after_table` (FALSE), `_has_header`
(FALSE), `_separator` (`,`; literal `\t` → tab), `_enclosure` (`"`), `_escape` (`\`),
`_table_class` / `_header_class` / `_row_class` (''), `_utf8_process` (FALSE), `_sticky_headers`
(FALSE), `_smart_urls` (FALSE), `_use_datatables` (FALSE). Details + a config-export example in
[fields/formatter.md](fields/formatter.md).

## DataTables (optional)

- Site-wide form `DataTablesSettingsForm` at **`/admin/config/csvfile_formatter/data-tables-settings`**
  (menu under *Configuration → Media*, route permission **`administer site configuration`**),
  writing config object **`csvfile_formatter.settings`** (`dataTableSettings` mapping; schema in
  `config/schema/`, install defaults in `config/install/`).
- When *Use DataTables* is on, the table gets class `add-externaljs-csvfiletable`; `js/csvfile-formatter.js`
  (`Drupal.behaviors.csvfileFormatter`) calls `.DataTable()` on it. Library `datatables` loads
  DataTables **2.2.2 from `cdn.datatables.net`**; `datatables_local` loads from `/libraries/…`
  (requires manually installing the datatables.net libraries — see README). The module tells you
  to enable *has header* before *Use DataTables*.

## Notes / caveats

- `readCsv()` toggles `ini_set('auto_detect_line_endings', …)`, which is **deprecated in PHP 8.1
  and removed in PHP 9** — expect a deprecation notice on newer PHP.
- The whole CSV is parsed into a render array on each uncached view; very large files mean
  proportional memory/time. Content is editor-supplied (upload access-gated), so this is a
  capacity note, not an access issue.
- Smart-URL Markdown handling passes the cell's URL to `Url::fromUri()`; a dangerous scheme like
  `javascript:` makes core throw (rejected by `UrlHelper::isExternal`) rather than emit a link —
  so it degrades to a render error, never to an executable link.
