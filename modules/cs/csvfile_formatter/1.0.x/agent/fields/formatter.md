<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The "CSV file as table" formatter

## Install & enable

```bash
composer require drupal/csvfile_formatter
drush en csvfile_formatter -y
```

Only dependency is core **`file`**. No sub-modules, no permissions of its own, no Drush commands.

## Enable it on a field

The formatter (plugin id **`csvfile_formatter`**, label *"CSV file as table"*) applies to **core
file fields** (`field_types = { "file" }`). It does **not** apply to link fields, image fields or
any custom type.

UI path: create/choose a **File** field on a bundle, then
*Structure → (bundle) → Manage display* → set that field's format to **CSV file as table** →
click the gear to set the options below.

Drush / config equivalent (view display):

```bash
drush cset core.entity_view_display.node.article.default \
  content.field_csv.type csvfile_formatter -y
drush cr
```

## Formatter settings

From `defaultSettings()` in `CSVFileFormatter.php`:

| Setting key | Default | Meaning |
|---|---|---|
| `csvfile_formatter_download_link` | `TRUE` | Show a download link to the original file (`#theme => 'file_link'`). |
| `csvfile_formatter_download_link_after_table` | `FALSE` | Put that link **after** the table instead of before it. |
| `csvfile_formatter_has_header` | `FALSE` | Treat the **first row** as a header (`<th>` cells). Enable before using DataTables. |
| `csvfile_formatter_separator` | `,` | Field separator passed to `fgetcsv`. The literal string `\t` is converted to a real tab (TSV support). |
| `csvfile_formatter_enclosure` | `"` | Field enclosure character for `fgetcsv`. |
| `csvfile_formatter_escape` | `\` | Escape character for `fgetcsv`. |
| `csvfile_formatter_table_class` | `''` | Space-separated CSS classes added to `<table>` (`#attributes[class]`). |
| `csvfile_formatter_header_class` | `''` | CSS class applied to each header cell. |
| `csvfile_formatter_row_class` | `''` | CSS class applied to each data row. |
| `csvfile_formatter_utf8_process` | `FALSE` | Run each cell through `mb_convert_encoding($cell, 'UTF-8', mb_list_encodings())`. |
| `csvfile_formatter_sticky_headers` | `FALSE` | Set the table render array's `#sticky = TRUE`. |
| `csvfile_formatter_smart_urls` | `FALSE` | Convert URL / email / `[text](url)` Markdown cells into links (see below). |
| `csvfile_formatter_use_datatables` | `FALSE` | Attach the DataTables JS library and behavior (see below). |

The settings form also shows a **"More DataTables settings"** link to the site-wide config form.
`settingsSummary()` lists the active choices on the Manage-display summary line.

### Example view-display config

```yaml
# core.entity_view_display.node.article.default
content:
  field_csv:
    type: csvfile_formatter
    label: above
    settings:
      csvfile_formatter_download_link: true
      csvfile_formatter_download_link_after_table: false
      csvfile_formatter_has_header: true
      csvfile_formatter_separator: ','
      csvfile_formatter_enclosure: '"'
      csvfile_formatter_escape: '\'
      csvfile_formatter_table_class: 'table table-striped'
      csvfile_formatter_header_class: ''
      csvfile_formatter_row_class: ''
      csvfile_formatter_utf8_process: false
      csvfile_formatter_sticky_headers: true
      csvfile_formatter_smart_urls: false
      csvfile_formatter_use_datatables: false
```

## How a cell is rendered

`readCsv()` reads the file with `fopen()` and a `fgetcsv($handle, 0, $separator, $enclosure,
$escape)` loop, resolving the file from the **managed file's own URI**
(`file_system->realpath($file->uri) ?: $file->getFileUri()`). Header cells become `#header`,
data rows become `#rows`, and everything is assembled as `#theme => 'table'`. The table gets
`id="{field}-{n}-csvfiletable"`, an optional `#caption` (the field description if the field has a
description, else the filename), and any configured classes.

Because cell text is placed into the table array's `data` keys, **it is escaped by Drupal's table
theme** — a cell containing `<script>` or other HTML is displayed as literal text, not executed.

### Smart URL handling

When `csvfile_formatter_smart_urls` is on, `processColumnData()` inspects each cell:

- passes `FILTER_VALIDATE_URL` → link to that URL;
- passes `FILTER_VALIDATE_EMAIL` → `mailto:` link;
- matches `/\[(.*)\]\((.*)\)/` (a simple `[text](url)` Markdown link) → link, and if the target
  starts with `#`, an in-page anchor to `<current>` with that fragment (current query preserved).

Links are built with `Link::fromTextAndUrl()`, so link text is escaped and the URL is validated by
core; a dangerous scheme such as `javascript:` is rejected by core URL handling (it throws) rather
than being emitted.

## DataTables integration

1. Turn on **Use DataTables** on the formatter (and normally **has header** too).
2. Configure behavior site-wide at **`/admin/config/csvfile_formatter/data-tables-settings`**
   (menu: *Configuration → Media → DataTables settings*; route permission
   **`administer site configuration`**). Values are stored in config object
   **`csvfile_formatter.settings`** under `dataTableSettings`.

Site-wide DataTables options (`DataTablesSettingsForm`): `dataTableLibrarySourceLocal` (radio:
CDN vs local), `autoWidth`, `deferRender`, `info`, `lengthChange`, `ordering`, `paging`,
`pageLength` (int, default 10), `processing`, `searching`, `stateSave`, `scrollX` (int, `-1` =
off), `scrollY` (int, `-1` = off).

At render time the formatter adds class `add-externaljs-csvfiletable` to the table and attaches:

- library `csvfile_formatter/csvfile_formatter` (CDN) or `csvfile_formatter/csvfile_formatter_local`
  depending on `dataTableLibrarySourceLocal`;
- `drupalSettings.csvFormatter.dataTable` with the config.

`js/csvfile-formatter.js` (`Drupal.behaviors.csvfileFormatter`, using `core/once`) calls
`jQuery(el).DataTable(settings)` on each such table, computing `scrollX` from the column count vs
the configured minimum and dropping `scrollY` when it is negative.

### Library sources

- **CDN** (`datatables` library): DataTables **2.2.2** JS + CSS from `cdn.datatables.net`.
- **Local** (`datatables_local` library): expects the files at `/libraries/datatables.net/js/…`
  and `/libraries/datatables.net-dt/…`. Install them yourself (README documents the
  `composer-custom-directory-installer` + `datatables.net/datatables.net-dt` route) before
  selecting "Load from local files".

## Gotchas

- If DataTables is enabled without a header row, sorting/search headers have nothing to attach to —
  the module's own field description tells you to enable *has header* first.
- `readCsv()` sets `ini_set('auto_detect_line_endings', …)`, deprecated in PHP 8.1 and removed in
  PHP 9; expect a deprecation notice on modern PHP.
- The full file is parsed into a render array on every uncached view — size the source files
  accordingly.
- No config schema exists for the **formatter** settings themselves (only for the site-wide
  `csvfile_formatter.settings`), so strict config-schema tooling may flag the view-display config;
  the settings still save and work.
