<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# PhpSpreadsheet

A dependency-only wrapper module that makes the `phpoffice/phpspreadsheet` PHP library available to a Drupal site, so other modules can read and write spreadsheet files (xlsx, xls, ods, csv, html).

---

The module ships no code of its own beyond a `phpspreadsheet.info.yml` and a `composer.json`. Its sole purpose is to declare a Composer requirement on `phpoffice/phpspreadsheet` (`~1`) so that the `PhpOffice\PhpSpreadsheet\` classes autoload across the site. Contrib and custom modules that need to generate or parse Excel/ODS/CSV files depend on it (listing `phpspreadsheet` in their own `.info.yml`) and then use the library's `Spreadsheet`, `IOFactory`, reader, and writer classes directly. There is no admin UI, no settings, no permissions, no services, and no hooks — enabling the module simply guarantees the library is present and autoloading.

---

- Make the `PhpOffice\PhpSpreadsheet` classes available to the Drupal autoloader.
- Provide the spreadsheet library that xlsx-export modules depend on.
- Provide the library that spreadsheet-import and parsing modules depend on.
- Build a `Spreadsheet` object in memory and populate its cells.
- Write a workbook to `.xlsx` with `Writer\Xlsx`.
- Write a workbook to legacy `.xls` with `Writer\Xls`.
- Export tabular data to `.csv` with `Writer\Csv`.
- Export a workbook to OpenDocument `.ods` with `Writer\Ods`.
- Render a workbook to HTML with `Writer\Html`.
- Read an uploaded spreadsheet with `IOFactory::load()`.
- Auto-detect a file's format via `IOFactory::identify()`.
- Convert an uploaded `.xlsx` into a PHP array with `toArray()`.
- Generate downloadable reports from query or Views results in a custom module.
- Produce Excel exports of entity or content data on demand.
- Import bulk content or configuration from a supplied spreadsheet.
- Set cell formatting, styles, and column widths programmatically.
- Add multiple worksheets to a single workbook.
- Set document metadata (title, author, company) on an export.
- Apply formulas and let PhpSpreadsheet calculate the values.
- Stream a generated spreadsheet as a file download response.
- Satisfy the library requirement for modules such as `phpexcel` or custom exporters.
- Keep a single, Composer-managed copy of the library shared by several modules.
- Enable the module with no configuration step (`drush en phpspreadsheet`).
- Uninstall cleanly once no dependent module needs the library.
