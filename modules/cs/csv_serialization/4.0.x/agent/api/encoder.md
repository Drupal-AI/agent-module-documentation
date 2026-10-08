# Encode / decode CSV in code

Service: `csv_serialization.encoder.csv` (class `Drupal\csv_serialization\Encoder\CsvEncoder`),
tagged `{ name: encoder, format: csv }`. Normally you call the core `serializer` service and
ask for the `csv` format rather than the encoder directly.

## Encode
```php
$serializer = \Drupal::service('serializer');
// $data is an array of associative rows; row keys of the first row become headers.
$csv = $serializer->serialize($data, 'csv', [
  'csv_settings' => [
    'delimiter' => ',',
    'enclosure' => '"',
    'output_header' => TRUE,
  ],
]);
```
- Non-array scalars are wrapped; objects are cast to arrays.
- Multi-dimensional / multi-value cells are flattened with `|` (e.g. `a|b|c`).
- When a Views style plugin is in `$context['views_style_plugin']`, its field **labels**
  are used as column headers and its `options['csv_settings']` are applied automatically.
- Output is `trim()`-med; an optional UTF-8 BOM can be prepended (see
  [../configure/csv-settings.md](../configure/csv-settings.md)).

## Decode
```php
$rows = $serializer->deserialize($csvString, NULL, 'csv');
// or: \Drupal::service('serializer')->decode($csvString, 'csv');
```
- Returns an array of rows; any cell containing `|` is exploded back into an array.

## REST
Because a service provider registers `csv`→`text/csv` with the negotiation middleware, a
REST resource returns CSV via `?_format=csv` (accept `text/csv`). Enable the REST resource
and grant its format/permission through the REST/serialization stack as usual.
