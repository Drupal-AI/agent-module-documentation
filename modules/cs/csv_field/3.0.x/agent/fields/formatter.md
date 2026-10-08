<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `csv_file_table` formatter and client-side rendering

## Enable it on a field

The `csv_file` field's default formatter is `csv_file_table` (label *"Render CSV file as table"*).
Set it per view-display at *Structure → (bundle) → Manage display*, or in
`core.entity_view_display.*` config (`content.<field>.type: csv_file_table`).

## Formatter — `CsvFileTableFormatter`

`src/Plugin/Field/FieldFormatter/CsvFileTableFormatter.php` extends
`\Drupal\file\Plugin\Field\FieldFormatter\DescriptionAwareFileFormatterBase`.

- `defaultSettings()`: `display_as_datatable = TRUE`, `use_description_as_link_text = TRUE`
  (plus the parent's file-formatter settings).
- `settingsForm()` adds one checkbox, **"Display as DataTable"** (`display_as_datatable`).
- `settingsSummary()` shows *"Displayed as DataTable"* when on.
- Config schema `field.formatter.settings.csv_file_table` (in `config/schema/csv_file.schema.yml`)
  extends `field.formatter.settings.file_default` and adds `display_as_datatable: boolean`.

### `viewElements()`

For each viewable file (`getEntitiesToView()` — core file access + display flag honoured) it
builds a render element:

```
#theme => 'csv_table'
#file  => <File entity>
#description => item->description (when use_description_as_link_text)
#attributes[class] => 'csv-table hidden'   (+ ' dataTable display' when display_as_datatable)
#cache[tags] => file cache tags
```

It then assembles the **settings** passed to the JS by merging the item's stored `settings`,
flattening the nested `urls` sub-array up to the top level, and forcing several values:

- `responsive` defaults to `childRow` if unset.
- `autolinkNewWindow = 0` (autolinked URLs open in the same window).
- `lengthMenu = [5, 10, 15]`; `pageLength` re-normalized via `CsvFileWidget::normalizePageLength()`.
- `stateSave = 1`, `stateDuration = 86400` (one day) — **note** the JS later overrides `stateSave`
  to `false` (see below).
- `order = []` — no initial column sort.
- If `download === 0`, any `downloadText` is dropped.

The merged settings are JSON-encoded onto `#attributes['data-settings']`.

## Theme + template

`csv_field_theme()` registers `csv_table` (vars: `file`, `attributes`, `settings`).
`template_preprocess_csv_table()` (in `csv_field.module`):

- `$file->createFileUrl(FALSE)` → the CSV URL; adds `url.site` cache context.
- Decodes `data-settings` into `settings`.
- Builds a download `Link`: text is `settings.downloadText` or *"Download table data as CSV"*
  (never the raw filename); the filename goes into the `title` attribute and `data-csv-filename`;
  `download => TRUE`; an `aria-label` is added when `tableLabel` is set.

`templates/csv-table.html.twig` renders only:

```
<div{{ attributes }}>{{ link }}</div>
{{ attach_library('csv_field/csv_field') }}
{% if settings.autolink %}{{ attach_library('csv_field/autolinker') }}{% endif %}
```

So the server sends **no table markup** — just a hidden container carrying `data-settings` plus the
download link.

## Client-side rendering — `js/csv-field.js`

`Drupal.behaviors.csvDatatables` runs once per `div.csv-table`:

1. Reads the download link `href`, parses `data-settings` (`normalizePageLengthSettings` caps
   `pageLength` at 15, forces `lengthMenu = [5,10,15]`), sets `stateSave = false`.
2. Resolves an accessible table label from `tableLabel` / `data-csv-table-label` / a surrounding
   `figure[aria-label]` / heading / `figcaption` (`resolveTableLabelContext`).
3. Parses URL column numbers (comma list, 1-based → 0-based, sorted descending).
4. `Papa.parse(link.href, {download:true, skipEmptyLines:true, transform, complete})` downloads and
   parses the CSV. When autolink is on, the `transform` callback runs `autolink.link(value)` on
   non-URL columns.
5. `renderTable(parsed)` creates a `<table>`, splits row 0 as header and the rest as body, and
   initializes DataTables: `columns` from the header (`{title: headerData[i]}`), `data` from the
   body rows, `layout` from `buildDatatablesLayout()` (search left / page-length right), optional
   `responsive` (childRow inline vs childRowImmediate), `firstColumnRowHeader` → a `columnDefs`
   entry with `cellType: 'th'`, `autoWidth:false`, and `deferRender:true` for >100 body rows.
6. When `searching === 1`, DataTables is initialized with `search.return = true` and a Search
   button is wired (`setupButtonSearch`) so filtering runs on click/Enter. When
   `hideSearchingData === 1`, the table/pagination are hidden until a search is submitted
   (`setupHideUntilSearch`).
7. Autolink: for each configured URL column, `Autolinker.link(url, {replaceFn})` builds an anchor
   whose visible text is the left-neighbour cell, then the text column is spliced out.
8. Extensive DataTables accessibility fixups run on init and re-run on `draw` /
   `column-visibility` / `responsive-resize` (`applyDatatablesA11yFixes` / `bindA11yReapply`):
   unique landmark labels, a skip link for link-heavy tables, download-link a11y, removal of
   `role="link"` from pagination buttons, hiding cloned/responsive rows from assistive tech, etc.

## Libraries (`csv_field.libraries.yml`)

- `csv_field` — `js/csv-field.js` + `css/csv-table.css`; depends on `core/drupal`,
  `csv_field/datatables_cdn`, `csv_field/papaparse`, `csv_field/autolinker`,
  `csv_field/datatables_responsive`.
- `csv_preview` — widget-only preview JS/CSS (`core/jquery`, `core/once`).
- External CDN libraries: `papaparse` **5.3.0**, `datatables_cdn` **2.3.7**,
  `datatables_responsive` **3.0.7**, `autolinker` **3.14.3** — all `type: external` from
  `cdnjs.cloudflare.com` / `cdn.datatables.net`.

## Gotchas

- The table exists only when JavaScript, the CDN libraries, and the CSV download all succeed; with
  JS off, the visitor sees just the download link inside a hidden container. `deferRender` kicks in
  above 100 rows, but the whole file is still downloaded and parsed in the browser — size source
  files accordingly.
- `stateSave` is set in the formatter (`= 1`) but explicitly disabled in the JS (`= false`), so
  DataTables state is **not** persisted despite the `stateDuration` value.
- Autolink expects the link-text column to sit immediately to the left of each URL column; the URL
  column itself is removed from the displayed table.
- The download link always serves the original uploaded file; the visible link text is generic and
  the filename is exposed only via the `title` attribute.
