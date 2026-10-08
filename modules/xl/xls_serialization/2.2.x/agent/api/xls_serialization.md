<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Encode Excel in code / REST

Two encoder services, each tagged `{ name: encoder, format: … }` (see
`xls_serialization.services.yml`):

| Service | Class | Format | Writer |
|---|---|---|---|
| `xls_serialization.encoder.xls` | `Drupal\xls_serialization\Encoder\Xls` | `xls` | phpspreadsheet, format `Xlsx` by default (see note) |
| `xls_serialization.encoder.xlsx` | `Drupal\xls_serialization\Encoder\Xlsx` (subclass of `Xls`) | `xlsx` | phpspreadsheet `Xlsx` |

Normally you call the core `serializer` service and ask for the `xls`/`xlsx` format
rather than instantiating the encoder. Both encoders take `@config.factory` as their
sole DI argument; `Xls::__construct()` also accepts an optional `$xls_format` (defaults
`Xlsx`; the legacy `Excel2007` constant is remapped to `Xlsx`).

## Library dependency
Requires **`phpoffice/phpspreadsheet`** (`^2.4.6 || ^3.10.6 || ^5.8.0`), pulled in by
`composer require drupal/xls_serialization`. Without it the encoder throws. Module deps:
core `rest` + `serialization`.

## Encode
```php
$serializer = \Drupal::service('serializer');
// $data is an array of associative rows; first row's keys become the header row.
$xlsx = $serializer->serialize($data, 'xlsx', [
  // Optional; normally supplied by a Views style plugin (see configure doc).
  'views_style_plugin' => $style_plugin,
]);
```
- `Xls::encode()` normalizes input: non-array scalars are wrapped in an array; objects
  are cast to arrays. Each row is cast to `(array)` again in `setData()`/`extractHeaders()`.
- Each value passes through `formatValue()`: when `stripTags` is on it runs
  `strip_tags()` **then** `Html::decodeEntities()` (that order avoids truncating strings
  like `"low pressure, &lt;1 MPa"`); when `trimValues` is on it `trim()`s.
- `setData()` writes values that start with `=` (and length > 1) through a
  PhpSpreadsheet `StringValueBinder`, so they are stored as **literal text, not formulas**.
- Columns are auto-sized (`setColumnsAutoSize()`) unless the global
  `xls_serialization_autosize` config is truthy; rows get auto-height + wrapped text
  (`setRowsAutoHeight()`).
- Worksheet title is set from the view title, sanitized by `validateWorksheetTitle()`
  (strips `: * / \ [ ] ?`, trimmed to 30 chars).
- Output is the raw binary workbook string: `IOFactory::createWriter()` then
  `$writer->save('php://output')` captured via `ob_start()`/`ob_get_clean()`.
- Any library exception is rethrown as `InvalidDataTypeException`.
- In Views **live preview** (`$context['views_style_plugin']->view->live_preview`), the
  encoder returns pretty-printed JSON (`JsonEncoder`) instead of unreadable binary.

## REST
`XlsSerializationServiceProvider` (a `ServiceModifierInterface`) registers the formats
with `http_middleware.negotiation`:
- `xls` → `application/vnd.ms-excel`
- `xlsx` → `application/vnd.openxmlformats-officedocument.spreadsheetml.sheet`

So a REST resource returns Excel via `?_format=xlsx` (or `?_format=xls`). Enable the REST
resource and grant its format/permission through the REST/serialization stack as usual.

## Views
The module also provides an `excel_export` Views **display** plugin (extends REST export,
content type `xlsx`) and an `excel_export` **style** plugin (extends the REST `Serializer`
style; `initializeSerializerFormats()` locks its formats to `xls`/`xlsx`). Add a "Data
export" / "Excel export" display, accept the `xls`/`xlsx` format, and the style's
`xls_settings` + display-level options drive filename, header styling, metadata and
conditional formatting — see [../configure/xls_serialization.md](../configure/xls_serialization.md).
