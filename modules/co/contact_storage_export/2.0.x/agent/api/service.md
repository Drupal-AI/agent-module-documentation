# The exporter service

Service id **`contact_storage_export.exporter`** →
`\Drupal\contact_storage_export\ContactStorageExportService`
(constructor args: `csv_serialization.encoder.csv`, `renderer`,
`plugin.manager.field.field_type`). Use it to turn `contact_message` entities into CSV.

## Public methods

| Method | Purpose |
|---|---|
| `getLabels(MessageInterface $message): array` | Field machine name → human label map (used as CSV headers). Labels are sanitised for use as array keys. |
| `serialize(MessageInterface $message, array $settings = []): array` | One message → `[label => value]` row. `$settings` may include `columns` (keys to include), `labels`, `date_format`. Always drops `uuid`. |
| `getFormattedValue(MessageInterface $message, string $field, array $settings): array` | Formats one field's items: `link` → absolute URL; `created`/`datetime`/`daterange`/`timestamp` → formatted date (`settings['date_format']`, default `short`); `entity_reference` → label (no link); everything else → default field formatter output rendered to string. |
| `encode(array $messages, array $settings = [], string $format = 'csv'): string` | Serialize many messages and encode them. Derives labels from the first message if not supplied. |
| `encodeData(array $data, string $format = 'csv', bool $output_header = TRUE): string` | Encode already-serialized rows via the `csv_serialization` CsvEncoder (toggle the header row). |

## Example

```php
$exporter = \Drupal::service('contact_storage_export.exporter');
$messages = \Drupal\contact\Entity\Message::loadMultiple($ids); // same contact_form bundle
$csv = $exporter->encode($messages, ['date_format' => 'medium']);
```

## Batch entry points

The UI runs the export through Batch callbacks in `ContactStorageExportBatches`
(`processBatch`/`finishBatch`, wrapped by `_contact_storage_export_process_batch` /
`_contact_storage_export_finish_batch`), which page messages 25 at a time, append CSV to a temp
file, update the per-form `last_id` watermark on "since last export", and hand off to the
download form. For programmatic use, call the exporter service directly rather than the batch.
