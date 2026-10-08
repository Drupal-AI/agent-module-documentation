# Configure TableField

## Module settings — `tablefield.settings`

Form `TablefieldConfigForm` at `/admin/config/content/tablefield` (route `tablefield.admin`,
menu "Tablefield settings" under Configuration → Content authoring). Edit via UI or
`drush cset tablefield.settings <key>`. Defaults (from `config/install/tablefield.settings.yml`):

| Key | Default | Meaning |
|---|---|---|
| `csv_separator` | `,` | Single-char separator used for CSV import AND export |
| `rows` | `5` | Default number of table rows (fallback when a field has no default) |
| `cols` | `5` | Default number of table columns (fallback) |

Config schema: `config/schema/tablefield.schema.yml` (config object). Exports/deploys with
`drush config:export`.

## Add a Table field

Add a field of type **Table Field** (`tablefield`) to any fieldable entity (Structure →
Content type → Manage fields). Value is stored as a serialized `blob` grid plus a `format`
(text format) and a `caption`. Rows/cols default: set them in the field's **Default value**
(a table widget instance) — those become the per-entity default; otherwise the module
`rows`/`cols` apply.

### Field settings (`defaultFieldSettings`, schema `field.field_settings.tablefield`)

| Setting | Default | Effect |
|---|---|---|
| `export` | `0` | Show a CSV "Export Table Data" link on the formatter (also needs `export tablefield` perm) |
| `restrict_rebuild` | `1` | Require `rebuild tablefield` perm to change rows/cols |
| `restrict_import` | `1` | Require `import tablefield` perm to import |
| `lock_values` | `0` | Lock default cell values (e.g. a fixed header) from edits during add/edit |
| `cell_processing` | `0` | `0` = plain text cells; `1` = filtered text (user picks input format → widget uses `text_format`) |
| `empty_rules.ignore_table_structure` | `0` | If set, row/col count changes don't make the item "non-empty" |
| `empty_rules.ignore_table_header` | `0` | If set, a filled first row alone doesn't make the item "non-empty" |

## Widget — `tablefield` ("Table Field")

Grid of cell inputs. One widget setting (`field.widget.settings.tablefield`):

| Setting | Default | Options |
|---|---|---|
| `input_type` | `textfield` | `textfield` or `textarea` per cell |

The widget renders a `#type => tablefield` element and, per the current user's permissions,
exposes: **Change number of rows/columns** rebuild (`rebuild tablefield`), **Add Row**
(`addrow tablefield`), **Copy & Paste** import (`paste tablefield`), and **Import from CSV**
file upload (`import tablefield`). Rows are draggable (tabledrag by weight). A "Table Caption"
textfield sits above the grid. Rebuild/add-row/paste/import are AJAX; paste supports TAB,
comma, semicolon, pipe, plus, and colon delimiters; CSV upload accepts only `.csv` files and
uses the `csv_separator` setting.

## Formatter — `tablefield` ("Tabular View")

Renders the stored grid as an HTML `<table>`. Settings (`field.formatter.settings.tablefield`):

| Setting | Default | Effect |
|---|---|---|
| `row_header` | `1` | Render the first (non-empty) row as a `<thead>` header |
| `column_header` | `0` | Mark the first column's cells as row headers |

When the field's `export` setting is on and the user has `export tablefield`, an "Export
Table Data" link streams a CSV (route `tablefield.export`). If `responsive_tables_filter`
is enabled, the table gets tablesaw stacking classes automatically.
