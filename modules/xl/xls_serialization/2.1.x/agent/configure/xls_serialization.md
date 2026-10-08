# Configure Excel export

## Global admin form
Route `xls_serialization.configuration` at
`/admin/config/user-interface/xls_serialization` (Admin → Config → User interface).
One config object, `xls_serialization.configuration`:

| Key | Effect | Default |
|---|---|---|
| `xls_serialization_autosize` | When truthy, **disables** per-column AutoSize (faster on big exports). When empty/false, columns are auto-sized. | `false` |

Set via drush: `drush cset xls_serialization.configuration xls_serialization_autosize 1`.

**Permission:** `administer xls serialization configuration` (restrict access) gates this form.

## Per-view options (the real configuration surface)
Most behavior is configured on the Views **Excel export** display/style, not a global
form. The style plugin (`excel_export`) reads an `xls_settings` array via
`Xls::setSettings()`:

| `xls_settings` key | Effect | Default |
|---|---|---|
| `xls_format` | Writer format. `Xlsx` or `Xls`. (`Excel2007`→`Xlsx`, `Excel5`→`Xls` are remapped.) | `Xlsx` |
| `strip_tags` | Strip HTML tags + decode entities on each value. | `TRUE` |
| `trim` | Trim whitespace on each value. | `TRUE` |
| `metadata` | Mapping of document properties (see below). | — |

`metadata` keys (set on the workbook's document properties): `creator`,
`last_modified_by`, `title`, `description`, `subject`, `keywords`, `category`,
`manager`, `company` (plus `created`/`modified` and typed `custom_properties` when
provided in code).

## Display-level options
The `excel_export` display plugin (`views.display.excel_export`, extends
`views.display.rest_export`) adds:

| Option | Effect |
|---|---|
| `filename` | Download filename; supports global tokens, sent as `Content-Disposition: attachment`. |
| `header_bold` | Make the header (first) row bold. |
| `header_italic` | Make the header row italic. |
| `header_background_color` | RGB hex background color for the header row. |
| `header_text_color` | Header text color. |
| `conditional_formatting_*_N` (N=0..4) | Up to five rules: pick a base field, operator (`=` / `<>`), a compare-to value, and an RGB background color applied to matching rows. |

Headers themselves come from the Views field **labels** (falling back to the raw key).
The worksheet title is set from the view title, sanitized (strips `: * / \ [ ] ?`,
trimmed to 30 chars).
