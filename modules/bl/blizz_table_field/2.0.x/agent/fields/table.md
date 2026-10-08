<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `table` field type, `table_widget` and `table_formatter`

## Install & enable

```bash
composer require drupal/blizz_table_field
drush en blizz_table_field -y
```

Also install the JS libraries (Handsontable 12.x + PapaParse 5.x) to `web/libraries/…` via
asset-packagist, and `league/commonmark ^2.3` — see [../config/settings.md](../config/settings.md).
Core deps: `field`, `file`, `filter`, `image`. No permissions or Drush of its own.

## Field type — `Table` (`src/Plugin/Field/FieldType/Table.php`)

- `@FieldType(id = "table", label = "Table", default_widget = "table_widget",
  default_formatter = "table_formatter")`.
- **One property/column** `value` (`DataDefinition::create('string')`, required). DB schema column
  `value` = `type: text, size: big`, with the column's `format` set from the storage setting.
- **Storage setting** `format` (`defaultStorageSettings()` → `'json'`). `storageSettingsForm()` shows
  a required select **JSON / CSV**; it is `#disabled` once the field has data (`$has_data`) — you
  cannot switch serialization format after content exists.
- `isEmpty()` = value is `NULL` or `''`. No custom constraints.

Add a field of type **Table** on any bundle (*Manage fields → Add field → Table*), pick JSON or CSV
in the storage settings, then configure the widget and formatter as below.

## Widget — `TableWidget` (`.../FieldWidget/TableWidget.php`)

Injects `config.factory` and reads `blizz_table_field.settings`. `formElement()` builds:

- a **hidden** `value` element holding the serialized table string (default seeded from a 4-column
  JSON or CSV skeleton when empty);
- a `<div class="rendered-table blizz format-{format}" data-blizz-config="{json}">` that the
  Handsontable JS (`js/init.handsontable.json.js` / `init.handsontable.csv.js`) binds to. The
  `data-blizz-config` JSON carries `rows`, `columns`, `readonly_rows`, `readonly_columns`,
  `limit_operations`, `selected_operations`;
- optional **Formatting options** `details` element whose help text comes from config
  `formatting_options` (unless `hide_formatting_options`);
- attaches library **`handsontable-json`** or **`handsontable-csv`** depending on the field's
  `format`, and passes `drupalSettings.handsontable.license_key` from config `license_key`.

Note: if the field's `format` storage setting is empty (a JSON Field contrib field), the widget
falls back to `json` and runs the raw setting through `Xss::filter()`.

### Widget settings (`defaultSettings()`)

| Key | Default | Meaning |
|---|---|---|
| `size` | `60` | `#size` of the underlying field. |
| `rows` | `1` | Minimum rows shown in the grid. |
| `columns` | `2` | Minimum columns shown in the grid. |
| `readonly_rows` | `0` | Number of leading rows locked read-only. |
| `readonly_columns` | `0` | Number of leading columns locked read-only. |
| `limit_operations` | `FALSE` | Restrict the grid context-menu operations. |
| `enabled_operations` | `[]` | When limiting, the allowed ops (checkboxes). |
| `hide_formatting_options` | `FALSE` | Hide the "Formatting options" help under the grid. |
| `placeholder` | `''` | Placeholder hint text. |

`getOperationOptions()` lists the selectable operations: `row_above`, `row_below`, `col_left`,
`col_right`, `remove_row`, `remove_col`, `undo`, `redo`, `cut`, `copy`. `enabled_operations` is only
honored when `limit_operations` is on (a JS-`#states` visible-when-checked checkboxes group).

## Formatter — `TableFormatter` (`.../FieldFormatter/TableFormatter.php`)

Injects `serialization.json` and the `markdown_extension.markdown` service. Declares
`field_types = { table, json, json_native, json_native_binary }`, so it can format a core-JSON /
JSON Field value as well as a `table` field.

`viewElements()` → `viewValue()` branches on the field's `format` item setting:

- **`csv`** → `tableFromCsv()`: `explode("\n", value)` then `str_getcsv()` per line.
- anything else → `tableFromJson()`: `json decode` of `value` (expects an array-of-arrays).

Both build a `#type => 'table'` render element with `#tableselect => TRUE` and the configured CSS
classes. When `render_header` is on, the **first row** becomes `#header` (each header cell is
Markdown-converted); otherwise a `no-header` class is added. Every data cell becomes
`['#markup' => <converted>]`. Conversion is `markdown->convertToHtml($cell)` unless
`skip_rendering_markdown` is set, in which case the raw cell string is used. Attaches library
`blizz_table_field/frontend` for styling.

### Formatter settings (`defaultSettings()`)

| Key | Default | Meaning |
|---|---|---|
| `render_header` | `TRUE` | Use the first row as a `<thead>` header. |
| `classes` | `''` | Space-separated CSS classes added to the `<table>`. |
| `skip_rendering_markdown` | `FALSE` | Output cell text verbatim instead of Markdown→HTML. |

Cell rendering and the Markdown/media features are documented in
[../api/markdown.md](../api/markdown.md).

## Config export shape

```yaml
# core.entity_form_display.node.article.default → content.field_table.settings
size: 60
rows: 3
columns: 4
readonly_rows: 1
readonly_columns: 0
limit_operations: true
enabled_operations: { row_above: row_above, row_below: row_below }
hide_formatting_options: false
placeholder: ''

# core.entity_view_display.node.article.default → content.field_table.settings
render_header: true
classes: 'table table-striped'
skip_rendering_markdown: false
```

Config schema for both is in `config/schema/blizz_table_field.schema.yml`
(`field.widget.settings.table_widget`, `field.formatter.settings.table_formatter`).
