<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
PHPExcel wraps the PhpSpreadsheet library in a small Drupal service: give it headers and rows and it writes an XLSX file, or point it at a file and it reads one back as an array — without your module touching PhpSpreadsheet directly.

---

The module is a service, not a feature. `phpexcel` (`Drupal\phpexcel\PHPExcel`, injected with a dedicated logger channel, the event dispatcher, module handler, config factory and translation) exposes a compact API: `export(array $headers, array $data, $path, array $options)` writes a spreadsheet; `exportDbResult(StatementInterface $result, $path, array $options)` does the same straight from a database statement, which is the cheap path for large result sets; and `import($path, $keyed_by_headers = TRUE, $keyed_by_worksheet = FALSE, array $custom_calls = [])` reads a file back, optionally keying rows by header names and grouping by worksheet, with `custom_calls` letting you invoke arbitrary PhpSpreadsheet methods during the read. Presentation helpers `setProperties()`, `setHeaders()` and `setColumns()` handle document metadata, header rows and column formatting. An `invoke()` method dispatches hooks at each stage (`$hook, $op, &$data, $phpexcel, $options, $column, $row`), so other modules can alter cells as they are written or read. A settings form sits at `/admin/config/development/phpexcel` behind the module's own `administer phpexcel` permission. The library comes from Composer (`phpoffice/phpspreadsheet ^1 || ^2`) — note the module keeps the historical "PHPExcel" name even though PHPExcel itself is long superseded by PhpSpreadsheet.

---

- Export a report to XLSX from a custom module.
- Write a database query result straight to a spreadsheet.
- Import an uploaded spreadsheet into Drupal.
- Read a spreadsheet keyed by its header row.
- Handle multi-worksheet workbooks on import.
- Set document properties (title, author) on generated files.
- Format header rows distinctly from data rows.
- Apply column formatting to exported data.
- Alter cell values from another module via hooks.
- Avoid coupling custom code to PhpSpreadsheet's API.
- Generate an XLSX attachment for an email.
- Produce a spreadsheet from a batch process.
- Import reference data supplied by a client.
- Export content listings for offline editing.
- Log spreadsheet operations to a dedicated channel.
- Keep spreadsheet handling consistent across modules.
- Restrict spreadsheet settings to trusted administrators.
- Support both PhpSpreadsheet 1.x and 2.x.
- Provide a migration path from the old PHPExcel library.
- Reuse one service for both import and export paths.
