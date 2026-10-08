# Encode Excel in code / REST

Two encoder services, each tagged `{ name: encoder, format: … }`:

| Service | Class | Format | Writer |
|---|---|---|---|
| `xls_serialization.encoder.xls` | `Drupal\xls_serialization\Encoder\Xls` | `xls` | phpspreadsheet, format `Xlsx` by default (see note) |
| `xls_serialization.encoder.xlsx` | `Drupal\xls_serialization\Encoder\Xlsx` (subclass of `Xls`) | `xlsx` | phpspreadsheet `Xlsx` |

Normally you call the core `serializer` service and ask for the `xls`/`xlsx` format
rather than instantiating the encoder.

## Library dependency
Requires **`phpoffice/phpspreadsheet`** (`^2.4.0 || ^3.10.0`), pulled in by
`composer require drupal/xls_serialization`. Without it the encoder throws.
Module deps: core `rest` + `serialization`.

## Encode
```php
$serializer = \Drupal::service('serializer');
// $data is an array of associative rows; first row's keys become the header row.
$xlsx = $serializer->serialize($data, 'xlsx', [
  // Optional; normally supplied by a Views style plugin (see configure doc).
  'views_style_plugin' => $style_plugin,
]);
```
- Non-array scalars are wrapped in an array; objects are cast to arrays.
- Each value is (by default) tag-stripped + entity-decoded and trimmed via `formatValue()`.
- Values that start with `=` are written with a `StringValueBinder` so they are stored
  as literal text, not spreadsheet formulas.
- Columns are auto-sized (unless the global `xls_serialization_autosize` config is set)
  and rows get auto-height + wrapped text.
- Output is the raw binary workbook string (written to `php://output` and captured).
- In Views **live preview** (`views_style_plugin->view->live_preview`), the encoder
  returns pretty-printed JSON instead of unreadable binary.

## REST
A `ServiceModifierInterface` service provider registers the formats with the negotiation
middleware:
- `xls` → `application/vnd.ms-excel`
- `xlsx` → `application/vnd.openxmlformats-officedocument.spreadsheetml.sheet`

So a REST resource returns Excel via `?_format=xlsx` (or `?_format=xls`). Enable the REST
resource and grant its format/permission through the REST/serialization stack as usual.

## Views
The module also provides an `excel_export` Views **display** plugin (extends REST export,
content type `xlsx`) and an `excel_export` **style** plugin. Add a "Data export" / "Excel
export" display, accept the `xls`/`xlsx` format, and the style's `xls_settings` +
display-level options drive filename, header styling, metadata and conditional formatting
— see [../configure/xls_serialization.md](../configure/xls_serialization.md).
