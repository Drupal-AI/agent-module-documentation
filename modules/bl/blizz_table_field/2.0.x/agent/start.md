<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Blizz Table Field (blizz_table_field) — agent index

A **`table` field type** whose value is a serialized grid of cells, edited in a spreadsheet-like
**Handsontable** widget and rendered as an HTML table. Cells are authored in **Markdown** (League
CommonMark, raw HTML stripped), not HTML. Package `Blizz`. Depends on core **`field`, `file`,
`filter`, `image`**. Core `^9 || ^10 || ^11`. License GPL-2.0-or-later. Version **2.0.8**.

- **Field type + widget + formatter (how to add and display a table field, all settings)** →
  [fields/table.md](fields/table.md)
- **Site settings form + config object (license key, library paths, formatting help)** →
  [config/settings.md](config/settings.md)
- **Markdown rendering pipeline + the `MarkdownExtension` plugin type (events, media refs)** →
  [api/markdown.md](api/markdown.md)

## What it actually is (from source)

- **Field type** `Table` (id **`table`**, `src/Plugin/Field/FieldType/Table.php`) — one `value`
  text column (`type: text, size: big`). Storage setting `format` = `json` (default) or `csv`,
  locked once data exists. `default_widget = table_widget`, `default_formatter = table_formatter`.
- **Widget** `TableWidget` (id **`table_widget`**, `.../FieldWidget/TableWidget.php`) — renders a
  hidden input holding the serialized data plus a `<div class="rendered-table blizz">` that the
  Handsontable JS binds to. Settings: `size`, `rows`, `columns`, `readonly_rows`,
  `readonly_columns`, `limit_operations` + `enabled_operations`, `placeholder`,
  `hide_formatting_options`. Attaches library `handsontable-json` or `handsontable-csv`.
- **Formatter** `TableFormatter` (id **`table_formatter`**, `.../FieldFormatter/TableFormatter.php`)
  — decodes the stored JSON/CSV into a core `#type => 'table'` render array; first row → optional
  `#header`; each cell → `#markup` via the Markdown service. Settings: `render_header`, `classes`,
  `skip_rendering_markdown`. Also declares `field_types = { table, json, json_native,
  json_native_binary }` so it works on **JSON Field** contrib fields.
- **Markdown service** `markdown_extension.markdown` (`src/MarkdownExtension.php`) — wraps
  `League\CommonMark\CommonMarkConverter` (`html_input: strip`, `allow_unsafe_links: false`) and
  dispatches `MarkdownEvents` PRE/POST so listeners can rewrite cell text.
- **Plugin type** `MarkdownExtension` — manager `plugin.manager.markdown_extension`
  (`MarkdownExtensionManager`), annotation `@MarkdownExtension`, interface
  `MarkdownExtensionInterface`. Two plugins: `image_markdown_extension`, `file_markdown_extension`
  (resolve `Media-Entity-ID` refs to image/file URLs).
- **Config**: one config object `blizz_table_field.settings`; settings form
  `blizz_table_field.settings_form` at **`/admin/config/content/blizz_table_field/settings`**
  (permission **`administer site configuration`**). Config schema in `config/schema/`.
- No permissions of its own, no Drush, no update hooks beyond `blizz_table_field_update_9201`.
  `hook_requirements()` errors at runtime if the configured JS library files are missing.

## External libraries (required, not bundled)

Handsontable **12.x** (commercial JS grid) and PapaParse **5.x** (CSV parsing) must be installed to
`web/libraries/…` via Composer + asset-packagist; `league/commonmark ^2.3` via Composer. Paths are
configured in the settings form (see [config/settings.md](config/settings.md)).
