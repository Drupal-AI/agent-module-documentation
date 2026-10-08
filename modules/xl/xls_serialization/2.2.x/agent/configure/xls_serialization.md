<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Excel export

## Global admin form
Route `xls_serialization.configuration` at
`/admin/config/user-interface/xls_serialization` (Admin → Config → User interface;
menu link in `xls_serialization.links.menu.yml`). Form
`XlsSerializationConfigurationForm` (extends `ConfigFormBase`). One config object,
`xls_serialization.configuration`:

| Key | Effect | Default |
|---|---|---|
| `xls_serialization_autosize` | When truthy, **disables** per-column AutoSize (faster/fixed width on big exports). When empty/false, columns are auto-sized. | `false` |

![Xls Serialization settings form](../../../../../../../screenshots/xls_serialization/2.2.x/settings-form.png)

Set via drush: `drush cset xls_serialization.configuration xls_serialization_autosize 1`.

**Permission:** `administer xls serialization configuration` (`restrict access: true`)
gates this form and its menu link.

## Per-view options (the real configuration surface)
Most behavior is configured on the Views **Excel export** display/style, not a global
form. The style plugin (`excel_export`, `ExcelExportStyleTrait`) defines an `xls_settings`
array read by `Xls::setSettings()`:

| `xls_settings` key | Effect | Default |
|---|---|---|
| `xls_format` | Writer format. `Excel2007`→`Xlsx`, `Excel5`→`Xls` (remapped in `setSettings()`/constructor). | `Excel2007` (→ `Xlsx`) |
| `strip_tags` | Strip HTML tags + decode entities on each value. | `TRUE` |
| `trim` | Trim whitespace on each value. | `TRUE` |
| `metadata` | Mapping of document properties (see below). | — |

`metadata` keys (set on the workbook via `Xls::setMetaData()` / PhpSpreadsheet
`Document\Properties`): `creator`, `last_modified_by`, `title`, `description`, `subject`,
`keywords`, `category`, `manager`, `company` (plus `created`/`modified` and typed
`custom_properties` — `i`/`f`/`s`/`d`/`b` — when provided in code; only the nine text
fields are exposed in the Views UI).

## Display-level options
The `excel_export` display plugin (`views.display.excel_export`, extends
`views.display.rest_export`; logic in `ExcelExportDisplayTrait`) adds:

| Option | Effect |
|---|---|
| `filename` | Download filename; supports global tokens (`globalTokenReplace()`), sent as `Content-Disposition: attachment` in `ExcelExport::render()`. |
| `header_bold` | Make the header (first) row bold (`setHeaderRowBold()`). |
| `header_italic` | Make the header row italic (`setHeaderRowItalic()`). |
| `header_background_color` | 6-digit RGB hex for the header-row fill (`setHeaderRowBackgroundColor()`); validated by `validateRgbValue()`, uppercased on submit. |
| `conditional_formatting_*_N` (N=0..4) | Up to five rules: pick a base field, operator (`=` / `<>`), a compare-to value, and an RGB background color applied to matching rows (`setConditionalFormat()` / `setConditionalFormatting()`). All three of field/operator/compare-to must be set together, else a validation error. |

Note: `header_text_color` exists in the views schema (`config/schema/xls_serialization.views.schema.yml`)
but is **not** built by the display form or applied by the encoder in this version.

Headers themselves come from the Views field **labels** (falling back to the raw key),
via `Xls::extractHeaders()`. The worksheet title is set from the view title, sanitized
(strips `: * / \ [ ] ?`, trimmed to 30 chars) by `validateWorksheetTitle()`.
