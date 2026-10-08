<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `phpexcel` service — read/write spreadsheets

Service id **`phpexcel`** → `Drupal\phpexcel\PHPExcel` (`src/PHPExcel.php`). This is the whole
module: a thin wrapper over **PhpSpreadsheet** so your code never touches `PhpOffice\PhpSpreadsheet\*`
directly. Grab it with `\Drupal::service('phpexcel')` or inject the `phpexcel` service.

Constructor args (from `phpexcel.services.yml`): `@logger.channel.phpexcel`, `@event_dispatcher`,
`@module_handler`, `@config.factory`, `@string_translation`. A dedicated log channel `phpexcel`
(`logger.channel.phpexcel`) receives every error.

## Public methods

| Method | Signature | Returns |
|---|---|---|
| `export` | `export(array $headers = NULL, array $data = [], $path = '', array $options = NULL)` | `int` status code |
| `exportDbResult` | `exportDbResult(StatementInterface $result = NULL, $path, array $options = [])` | `int` status code |
| `import` | `import($path, $keyed_by_headers = TRUE, $keyed_by_worksheet = FALSE, array $custom_calls = [])` | `array` data, or `int` error |
| `setProperties` | `setProperties($properties, $options)` | void — sets creator/title/subject/description |
| `setHeaders` | `setHeaders($xls, &$headers, $options)` | void — writes the header row(s) |
| `setColumns` | `setColumns($xls, &$data, $headers = NULL, $options = [])` | void — writes data rows |
| `invoke` | `invoke($hook, $op, &$data, $phpexcel, $options, $column = NULL, $row = NULL)` | void — dispatches alter hooks (see hooks doc) |
| `mungeFilename` | `mungeFilename($path): string` | sanitized path |
| `getCacheSettings` | `getCacheSettings(): array` | cache method array (currently always empty, see configure doc) |

`setProperties` / `setHeaders` / `setColumns` / `invoke` / `mungeFilename` / `getCacheSettings` are
public but are the internal machinery of `export`/`import`; normal integrators only call `export`,
`exportDbResult`, and `import`.

## Status / error constants (class constants on `PHPExcel`)

`export`/`exportDbResult` return an int; success is `PHPEXCEL_SUCCESS`. Compare against the constant,
not the literal.

| Constant | Value | Meaning |
|---|---|---|
| `PHPEXCEL_ERROR_NO_HEADERS` | 0 | `$headers` empty and `ignore_headers` not set |
| `PHPEXCEL_ERROR_NO_DATA` | 1 | `$data` given but empty |
| `PHPEXCEL_ERROR_PATH_NOT_WRITABLE` | 2 | `$path` (or its dir) not writable |
| `PHPEXCEL_ERROR_LIBRARY_NOT_FOUND` | 3 | PhpSpreadsheet not installed |
| `PHPEXCEL_ERROR_FILE_NOT_WRITTEN` | 4 | writer ran but file absent afterwards |
| `PHPEXCEL_ERROR_FILE_NOT_READABLE` | 5 | import `$path` not readable |
| `PHPEXCEL_CACHING_METHOD_UNAVAILABLE` | 6 | (declared, unused) |
| `PHPEXCEL_SUCCESS` | 10 | ok |

## export()

Writes a spreadsheet to `$path`. Behaviour traced from source:

- Aborts with `PHPEXCEL_ERROR_NO_HEADERS` unless `$headers` is non-empty or `$options['ignore_headers']`
  is TRUE; aborts `PHPEXCEL_ERROR_NO_DATA` if `$data` is an empty array.
- Requires `$path` (or `dirname($path)`) writable, else `PHPEXCEL_ERROR_PATH_NOT_WRITABLE`.
- The filename is passed through `mungeFilename()` before writing.
- If the file already exists it is loaded and appended to; else if `$options['template']` is set that
  file is loaded as a template; else a fresh `Spreadsheet` is created.
- Format is `$options['format']` (lower-cased) or the file extension: `xlsx` → `Writer\Xlsx`,
  `csv` → `Writer\Csv`, `ods` → `Writer\Ods`, anything else → `Writer\Xls`.
- `$headers` may be 1-D (single sheet) or 2-D (`$headers[sheet][col]` → one sheet each). `$data` may be
  2-D (`$data[row][col]`) or 3-D (`$data[sheet][row][col]`). Numeric sheet keys become `Worksheet N`.

### `$options` keys honoured by export

| Key | Effect |
|---|---|
| `ignore_headers` | Skip the header row entirely (bool) |
| `format` | Force `xls` / `xlsx` / `csv` / `ods` (else taken from extension) |
| `creator` | Document author (defaults to `\PhpOffice\PhpSpreadsheet\Spreadsheet`) |
| `title` / `subject` / `description` | Document metadata |
| `template` | Path to a spreadsheet to open as the starting workbook |
| `merge_cells` | `['<sheetIndex>' => ['A1:C1', ...]]` — merges + centre-aligns those ranges |

Any extra keys you add to `$options` are passed unchanged to every alter hook.

```php
$phpexcel = \Drupal::service('phpexcel');
$status = $phpexcel->export(
  ['Title', 'Author', 'Created'],
  [['Page one', 'admin', '2026-01-01']],
  'public://report.xlsx',
  ['title' => 'Report', 'creator' => 'My Module'],
);
if ($status !== \Drupal\phpexcel\PHPExcel::PHPEXCEL_SUCCESS) {
  // Inspect the phpexcel log channel for the reason.
}
```

## exportDbResult()

Convenience wrapper: iterates a `\Drupal\Core\Database\StatementInterface`, takes column names of the
first row as `$headers` and each row's values as `$data`, then calls `export()`. Returns whatever
`export()` returns (an int status — the docblock says bool, but the code returns the int). Cheaper than
building the array yourself for large result sets.

```php
$stmt = \Drupal::database()->query('SELECT name, mail FROM {users_field_data}');
$phpexcel->exportDbResult($stmt, 'public://users.xlsx');
```

## import()

Reads `$path` back into a PHP array. Uses `IOFactory::createReaderForFile()` and always forces
`setReadDataOnly(TRUE)`. Returns the data array, or `PHPEXCEL_ERROR_FILE_NOT_READABLE` /
`PHPEXCEL_ERROR_LIBRARY_NOT_FOUND` on error.

- `$keyed_by_headers = TRUE` — first row is treated as headers and each data row becomes an assoc array
  keyed by those header labels (header row itself skipped). `FALSE` — headers stay as row 0 and rows are
  keyed numerically.
- `$keyed_by_worksheet = TRUE` — top-level array keyed by worksheet title instead of a numeric index.
- `$custom_calls` — `['<readerMethod>' => [args...]]`. Each `$method` that `method_exists()` on the
  reader is invoked with `call_user_func_array`. `setReadDataOnly => [TRUE]` is merged in first. Example:
  load only one sheet with `['setLoadSheetsOnly' => ['Sheet 2']]`.

```php
$rows = $phpexcel->import('public://uploaded.xlsx');           // keyed by header labels
$raw  = $phpexcel->import('public://uploaded.xlsx', FALSE);    // numeric rows, headers in row 0
$byWs = $phpexcel->import('public://book.xlsx', TRUE, TRUE);   // grouped by worksheet name
```

## Notes

- Large workbooks are built entirely in memory by PhpSpreadsheet (~1 KB/cell); prefer `exportDbResult`
  and batching for big exports.
- `mungeFilename()` runs the filename through a `FileUploadSanitizeNameEvent` (allowed extensions
  `xls xlsx csv ods`) so other modules can sanitize it; `$path`'s directory portion is preserved.
- Cell-value alter points are exposed as hooks — see [../hooks/alter-hooks.md](../hooks/alter-hooks.md).
