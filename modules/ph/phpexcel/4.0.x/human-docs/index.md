# PHPExcel — manual setup guide

**PHPExcel** (`phpexcel`) wraps the
[PhpSpreadsheet](https://github.com/PHPOffice/PhpSpreadsheet) library in a small,
reusable Drupal **service**, so your own module can read and write real Excel
(`.xlsx`) files without touching PhpSpreadsheet's API directly. Give the service
headers and rows and it writes a spreadsheet; point it at a file and it reads one
back as an array. The idea is a single, consistent way to handle Excel import/export
across a site instead of every module rolling its own.

This is a **developer's tool**, not a click‑and‑go feature — the module provides no
end‑user screens. You call the `phpexcel` service from custom code:

```php
$phpexcel = \Drupal::service('phpexcel');
$phpexcel->export(
  ['Title', 'Author', 'Created'],
  [['Page one', 'admin', '2026-01-01']],
  'public://report.xlsx'
);
$rows = $phpexcel->import('public://uploaded.xlsx');
```

It offers `export()` (write from arrays), `exportDbResult()` (write straight from a
database statement — the cheaper path for large result sets), and `import()` (read a
file back, optionally keyed by header row and grouped by worksheet), plus helpers for
document properties, header rows and column formatting, and alter hooks so other
modules can adjust cells as they are written or read. The PhpSpreadsheet library is
pulled in automatically by Composer.

> **A note on the name.** The project is still called "PHPExcel" for historical
> reasons, but the original PHPExcel library is long abandoned — this 4.x version
> actually wraps its successor, **PhpSpreadsheet**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and the PhpSpreadsheet
   library with Composer, and enable it.

The module does register a small settings page at **Configuration → Development →
PHPExcel** (`/admin/config/development/phpexcel`, behind the *administer phpexcel*
permission), but the module is used primarily from code as shown above — there is no
end‑user workflow to configure.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)); the
   PhpSpreadsheet library comes with it via Composer.
2. From your own module, inject or fetch the `phpexcel` service and call `export()`,
   `exportDbResult()` or `import()` as in the example above.

> **Watch memory on large exports.** PhpSpreadsheet builds the workbook in memory, so
> for large data sets prefer `exportDbResult()` and batch the work where you can.
