<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Alter hooks: `hook_phpexcel_export` / `hook_phpexcel_import`

During every export and import the service calls `PHPExcel::invoke()`, which fans out to
`\Drupal::moduleHandler()->invokeAllWith('phpexcel_export' | 'phpexcel_import', ...)`. Implement the
matching hook in *your* module to observe or alter cell values, sheets, and rows as they stream through.

Because the payload is passed **by reference**, the module uses a custom `invoke()` (not the standard
`hook` helpers). Your implementation receives positional args, not an alter-array:

```php
/**
 * Implements hook_phpexcel_export().
 */
function MYMODULE_phpexcel_export($op, &$data, $phpexcel, $options, $column, $row) { }

/**
 * Implements hook_phpexcel_import().
 */
function MYMODULE_phpexcel_import($op, &$data, $phpexcel, $options, $column, $row) { }
```

| Param | Meaning |
|---|---|
| `$op` | The stage (see tables below) — branch on this |
| `&$data` | The value at that stage; mutate it to alter output/parsed data |
| `$phpexcel` | The current PhpSpreadsheet object for the stage (workbook, sheet, cell, reader…) |
| `$options` | The full `$options` array from the caller (your custom keys survive here) |
| `$column` | Zero-based column index, or `NULL` for non-cell ops |
| `$row` | Row number (PhpSpreadsheet is 1-based), or `NULL` for non-cell ops |

## `hook_phpexcel_export` — `$op` values (in call order)

| `$op` | `&$data` is… | `$phpexcel` is… |
|---|---|---|
| `headers` | the whole headers array | the `Spreadsheet` |
| `new sheet` | the new sheet id (int) | the `Spreadsheet` |
| `data` | the whole data array | the `Spreadsheet` |
| `pre cell` | the value about to be written | the active `Worksheet` |
| `post cell` | the value just written | the active `Worksheet` |
| `post data` | the whole data array | the `Spreadsheet` |

`pre cell` / `post cell` fire for both header cells and data cells, with `$column` and `$row` set.

## `hook_phpexcel_import` — `$op` values (in call order)

| `$op` | `&$data` is… | `$phpexcel` is… |
|---|---|---|
| `full` | the loaded `Spreadsheet` | the reader |
| `sheet` | the current `Worksheet` | the reader |
| `row` | the current `Row` | the reader |
| `pre cell` | the raw trimmed cell value | the `Cell` |
| `post cell` | the stored cell value | the `Cell` |

Use `pre cell` on import to normalise/validate values before they land in the result array, or
`post cell` on export to apply styling to the cell you can reach via `$phpexcel` (the worksheet).
