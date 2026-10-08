<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Webform XLSX Export adds an **XLSX** option to Webform's results-export screen and Drush export command, producing genuine Office Open XML workbooks via PhpSpreadsheet.

---

Webform core ships a `table` exporter that writes an HTML table with an `.xls` extension; recent Microsoft Excel versions warn that such files are not really Excel files. This module replaces that with a real `.xlsx` writer. It contributes exactly one plugin — `Drupal\webform_xlsx_export\Plugin\WebformExporter\XlsxExporter`, annotated `@WebformExporter(id = "xlsx", label = "XLSX")` — which extends Webform's `TabularBaseWebformExporter`, so it inherits all of the tabular options (which columns, header format, delimiters for multi-value elements, entity references, and so on). `getFileExtension()` returns `xlsx`; `createExport()` opens a new `PhpOffice\PhpSpreadsheet\Spreadsheet`; `writeHeader()` writes `buildHeader()` into row 1 and bolds it; `writeSubmission()` appends `buildRecord()` one row at a time; `closeExport()` writes the workbook with `IOFactory::createWriter($xls, 'Xlsx')`. Two details matter in practice: values beginning with `=` are written with a `StringValueBinder` so they are not interpreted as formulas (a CSV-injection style hazard), and `openExport()` resolves Drupal stream-wrapper URIs to real filesystem paths for `LOCAL_NORMAL` wrappers because PhpSpreadsheet cannot read stream wrappers. The module has **no settings page, no permissions, no config and no Drush commands of its own** — it is discovered automatically by Webform's exporter plugin manager, so it appears both at *Results → Download* and as `drush webform:export --exporter=xlsx`. `hook_requirements()` reports on the status page whether PhpSpreadsheet is installed.

---

- Download a webform's submissions as a real `.xlsx` file that Excel opens without a warning.
- Replace Webform's `.xls` "table" export that triggers "The file format and extension don't match".
- Schedule a nightly submission dump with `drush webform:export mywebform --exporter=xlsx --destination=…`.
- Save XLSX as a webform's default download format so editors don't have to pick it each time.
- Export only the submissions in a date range as XLSX from the Download tab.
- Export a specific set of elements/columns to XLSX for a stakeholder report.
- Export submissions of a webform attached to a specific node (source entity) as XLSX.
- Hand a survey's results to a data analyst in a spreadsheet format they can pivot directly.
- Produce a bolded header row automatically so the sheet is readable without post-processing.
- Avoid CSV escaping/encoding problems with commas, quotes and UTF-8 in free-text answers.
- Keep leading zeros and long numbers intact compared to a naive CSV opened in Excel.
- Protect against formula injection: answers starting with `=` are written as literal text.
- Export applications/registrations for offline review in Excel.
- Batch-export several webforms to XLSX in a shell loop over `drush webform:export`.
- Feed an XLSX into Power BI / Google Sheets import without an intermediate conversion.
- Give a client an Excel deliverable without installing Search-API-style extra tooling.
- Archive submissions in a durable, widely supported spreadsheet format before purging them.
- Export to a private:// or public:// destination and let another process pick the file up.
- Combine with Webform's "download and delete" workflows for GDPR-style retention rules.
- Check on the Status report whether PhpSpreadsheet is actually available before relying on XLSX.
- Reuse `TabularBaseWebformExporter` options (header format, multiple-value delimiter, files) with an XLSX target.
- Subclass `XlsxExporter` to add styling, column widths or extra sheets in a custom module.
- Standardise on one export format across a site with many webforms.
- Provide an Excel export for a webform-based data-collection app used by field staff.
