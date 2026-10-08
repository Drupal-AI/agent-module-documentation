<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Services

Four plain services, registered in `bulk_csv_delete.services.yml`. None are tagged; all are
consumed by the Drush command (see [drush-command.md](drush-command.md)). No events, no hooks, no
config.

## `bulk_csv_delete.csv_parser` → `CsvParserService`

`src/Service/CsvParserService.php`. No constructor args.

- `parse(string $file_path, int $column_index, bool $has_header = FALSE, string $delimiter = ','):
  array` — `fopen()` then a `fgetcsv($handle, 0, $delimiter)` loop. `$column_index` is **0-based**
  (the command passes `column_number - 1`). Skips the first row when `$has_header`. For each data
  row it trims the target column; empty or out-of-range columns are counted as `skipped_empty`; the
  first 3 rows are kept as `preview_rows`. Values are collected, then `array_unique`d.
- Returns `['values', 'total_rows', 'skipped_empty', 'duplicates_removed', 'preview_rows',
  'header_row']`. Throws `\RuntimeException` if the file cannot be opened.

## `bulk_csv_delete.node_matcher` → `NodeMatcherService`

`src/Service/NodeMatcherService.php`. Args: `@entity_field.manager`, `@database`.
Const `QUERY_CHUNK_SIZE = 500`.

- `getFieldStorageInfo(string $content_type, string $field_name): array|false` — resolves the DB
  location. **Base field** → `['table' => 'node_field_data', 'column' => $field_name,
  'is_base_field' => TRUE]`. **Custom field** → table `node__{field}`, column
  `{field}_{mainProperty}` where the main property comes from
  `storageDefinition->getMainPropertyName()` (falls back to the first column key). This is how it
  supports text (`_value`), entity reference (`_target_id`), link (`_uri`), etc. FALSE if the field
  is unknown.
- `isFieldIndexed(string $content_type, string $field_name): ?bool` — custom fields only (NULL for
  base fields or unknown table). Runs `SHOW INDEX FROM {table} WHERE Column_name = :column`; TRUE if
  a row exists, FALSE if not, NULL on error. Drives the command's index warning.
- `findMatchingNodes(string $content_type, string $field_name, array $values): array` — chunks
  `$values` by 500 and, per chunk, calls `queryChunk()`. Categorises each value into `nids`
  (deduped flat list), `value_to_nids`, `not_found`, and `multi_match` (values hitting >1 node).
- `queryChunk(...)` (protected) — builds `SELECT {id_column} AS nid, {value_column} AS field_value
  FROM {table} WHERE {bundle_column} = :bundle AND {value_column} IN (:val_0, :val_1, …)`. Id/bundle
  columns are `nid`/`type` for base fields, `entity_id`/`bundle` for custom fields. **All values are
  bound placeholders**; the content type is bound as `:bundle`. Table and column identifiers come
  from `getFieldStorageInfo()`, i.e. from validated field metadata, not raw user text.
- `filterNidsByField(string $content_type, string $field_name, string $value, array $nids): array`
  — used by `--filter`. For each 500-nid chunk, `SELECT {id} FROM {table} WHERE {bundle} = :bundle
  AND {value_column} = :val AND {id} IN (…)`; returns the deduped surviving nids.

## `bulk_csv_delete.batch_deleter` → `BatchDeleterService`

`src/Service/BatchDeleterService.php`. Arg: `@entity_type.manager`.

- `deleteBatches(array $nids, int $batch_size, int $delay, ?callable $progress_callback = NULL):
  array` — `array_chunk($nids, $batch_size)`, then per batch: `loadMultiple()`, `$storage->delete()`
  the loaded entities (this fires entity delete hooks), `usleep($delay * 1000)` (ms→µs), tally
  deleted, record any nids that failed to load as errors. A `try/catch` around the batch records the
  exception message per nid and **continues** with remaining batches. After every batch,
  `$storage->resetCache($batch_nids)` clears the in-memory entity static cache to keep memory flat;
  then the optional progress callback is invoked `(batchNum, totalBatches, batchNids, batchTime,
  deletedSoFar)`.
- Returns `['deleted' => int, 'errors' => [nid => message], 'duration' => float]`.

## `bulk_csv_delete.delete_logger` → `DeleteLoggerService`

`src/Service/DeleteLoggerService.php`. Arg: `@file_system`.

- `open(string $log_dir, bool $dry_run = FALSE): void` — `prepareDirectory(... CREATE_DIRECTORY |
  MODIFY_PERMISSIONS)`, resolves the real path (throws `\RuntimeException` — "Is private file system
  configured?" — if it cannot), opens `<Y-m-d_His>.log` (`dry_run_` prefix for dry runs) for writing.
- `log(string $message): void` — appends `"[Y-m-d H:i:s] $message\n"` if a handle is open.
- `close(): void`, `getLogPath(): ?string`.
