# Using the PhpSpreadsheet library

The `phpspreadsheet` module carries no code of its own — it exists so that requiring
`drupal/phpspreadsheet` via Composer pulls in `phpoffice/phpspreadsheet` (`~1`) and registers
the `PhpOffice\PhpSpreadsheet\` namespace with Drupal's autoloader. Consuming modules then use
the library classes directly. There is no service or factory to inject; you instantiate the
library classes yourself.

## Declaring the dependency

In the consuming module's `<module>.info.yml`:

```yaml
dependencies:
  - phpspreadsheet:phpspreadsheet
```

That guarantees the module (and therefore the library) is present before your code runs.
Composer resolves the library itself when the site is built with
`composer require drupal/phpspreadsheet`.

## What becomes available

The full PhpSpreadsheet 1.x API under `PhpOffice\PhpSpreadsheet\`. The classes used most:

| Class | Purpose |
|---|---|
| `PhpOffice\PhpSpreadsheet\Spreadsheet` | In-memory workbook you build up |
| `PhpOffice\PhpSpreadsheet\IOFactory` | Auto-detect a reader/writer; load or save a file |
| `PhpOffice\PhpSpreadsheet\Writer\Xlsx` (also `Xls`, `Csv`, `Ods`, `Html`) | Write a workbook to disk |
| `PhpOffice\PhpSpreadsheet\Reader\Xlsx` (also `Xls`, `Csv`, `Ods`) | Read a file into a `Spreadsheet` |

## Write a spreadsheet

```php
use PhpOffice\PhpSpreadsheet\Spreadsheet;
use PhpOffice\PhpSpreadsheet\Writer\Xlsx;

$spreadsheet = new Spreadsheet();
$sheet = $spreadsheet->getActiveSheet();
$sheet->setCellValue('A1', 'Title');
$sheet->setCellValue('B1', 'Count');
$sheet->fromArray([['Widgets', 42], ['Gadgets', 7]], NULL, 'A2');

$path = \Drupal::service('file_system')->realpath('public://report.xlsx');
(new Xlsx($spreadsheet))->save($path);
```

Swap `Writer\Xlsx` for `Writer\Xls`, `Writer\Csv`, `Writer\Ods`, or `Writer\Html` to emit
other formats from the same `Spreadsheet` object.

## Read a spreadsheet

```php
use PhpOffice\PhpSpreadsheet\IOFactory;

$path = \Drupal::service('file_system')->realpath('public://uploaded.xlsx');
$spreadsheet = IOFactory::load($path);
$rows = $spreadsheet->getActiveSheet()->toArray();
```

`IOFactory::load()` auto-detects the format; `IOFactory::identify($path)` returns the reader
type without loading.

## Notes

- PhpSpreadsheet builds the whole workbook in memory, so very large exports are memory-heavy;
  batch or stream large jobs where possible.
- Readers and writers need a real filesystem path — resolve stream wrappers (`public://…`)
  with `file_system::realpath()` first.
- This module pins the library to major `~1`; keep it current via Composer.
