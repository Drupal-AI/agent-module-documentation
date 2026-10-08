# PhpSpreadsheet — manual setup guide

**PhpSpreadsheet** (`phpspreadsheet`) is a thin wrapper module whose only job is
to ship the well‑known [PHPOffice/PhpSpreadsheet](https://github.com/PHPOffice/PhpSpreadsheet)
PHP library through Composer and register its classes with Drupal's autoloader.
Once it is installed, any other module — contrib or custom — can read and write
spreadsheet files (`.xlsx`, `.xls`, `.ods`, `.csv`) using the
`PhpOffice\PhpSpreadsheet` classes.

It has **no admin screens, no permissions, and no settings form** of its own.
There is genuinely nothing to click through: you install it, enable it, and then
other code depends on it. If you are here because another module told you it
needs PhpSpreadsheet, all you have to do is the Composer install on the next
page.

Because this module adds no routes or forms, it adds no attack surface by
itself. All the usual spreadsheet risks (CSV/formula injection on export, XXE on
loading untrusted files) live in the *consuming* code, not here — so keep the
library patched by updating the Composer constraint, and make sure whatever
module uses it sanitises cell values and validates uploaded files.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — pull in the library with Composer and
   enable the module.

There is **no configuration page** for this module — it has no settings form,
permissions, or config entities.

## How to use it

You don't use PhpSpreadsheet directly through the UI — it is a building block for
other modules. Once it is enabled, a module that wants to work with spreadsheets
simply declares `phpspreadsheet` as a dependency in its `.info.yml` and then uses
the library classes in PHP, for example building a `Spreadsheet` object and
writing it out with the `Xlsx` or `Csv` writer, or loading an uploaded file with
`IOFactory::load()`. Uninstalling PhpSpreadsheet is safe once no enabled module
still depends on the library.
