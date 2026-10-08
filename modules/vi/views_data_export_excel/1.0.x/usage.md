<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views Data Export Excel adds a native Excel (.xlsx) output format to the Views Data Export module.

---

Views Data Export gives a View downloadable output (CSV, XML, JSON). This add-on plugs in a spreadsheet format: it provides a Views display plugin and a Views style plugin (both keyed `data_export_excel`) that subclass Views Data Export's own DataExport display and style and mix in the Excel traits from the XLS Serialization module. XLS Serialization, in turn, uses `phpoffice/phpspreadsheet` to build the workbook, so the file is a real `.xlsx` (or legacy `.xls`) rather than a CSV with a spreadsheet extension. That distinction is the point of the module: a genuine spreadsheet keeps cell types, so a column of zero-padded reference codes stays text instead of being coerced into `1.23457E+11`, and date-shaped strings are not silently turned into dates.

Because it is just another Views Data Export format, the View still owns the fields, filters, sorts, pager and access plugin; this only adds the output option and a handful of Excel-specific presentation controls (bold/italic/coloured header row, document metadata, and conditional row formatting, all supplied by XLS Serialization). It requires XLS Serialization 2.1.0+ and depends on Views Data Export; it defines no routes, permissions, services or Drush commands of its own — the export route and its access come from the Views Data Export display it extends. Note that large exports are memory-hungry (the workbook is built in memory before being streamed), and that an exported file, like any export, no longer carries the site's access controls once it is downloaded and forwarded.

---

- Add an Excel (.xlsx) download to an existing View.
- Offer a spreadsheet export alongside CSV/XML/JSON on a Data Export display.
- Preserve leading zeros in reference or account codes.
- Keep numbers as numbers and text as text in an export.
- Avoid CSV coercing code strings into scientific notation.
- Avoid CSV turning date-shaped strings into dates.
- Give a finance or reporting team a file they can open directly in Excel.
- Reuse a View's existing fields, filters and sorts for the export.
- Reuse a View's configured access plugin for who can export.
- Produce a legacy .xls file instead of .xlsx via the style's format setting.
- Bold or italicise the header row of the exported sheet.
- Set a background colour on the header row.
- Add document metadata (author, title, subject, keywords, company) to the workbook.
- Apply conditional background colouring to rows based on a field's value.
- Strip HTML tags from field output before writing cells.
- Trim whitespace from cell values.
- Auto-size columns and auto-height rows in the generated sheet.
- Set the worksheet title from the View title.
- Attach an Excel export as a companion display to a page View (Data Export display).
- Batch a large Excel export via the Data Export display's batching.
- Stay compatible with the XLS Serialization Extras feature set.
- Standardise reporting output on a spreadsheet format across many Views.
