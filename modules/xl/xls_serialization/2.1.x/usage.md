Serialization (Excel) registers `xls` and `xlsx` as serialization formats for Drupal's Serialization API, letting REST resources and Views "Data export" / "REST export" displays emit downloadable Excel spreadsheets.

---

The module adds two encoder services — `Xls` (format `xls`) and `Xlsx` (format `xlsx`, a subclass) — each tagged as an `encoder`, plus a service provider that registers the `xls` → `application/vnd.ms-excel` and `xlsx` → `application/vnd.openxmlformats-officedocument.spreadsheetml.sheet` MIME types with Drupal's content-negotiation middleware. Under the hood it uses the external `phpoffice/phpspreadsheet` library to build the workbook, so that library must be installed via Composer. It also ships custom Views `excel_export` display and style plugins (extending REST export) so a view can attach an Excel download with a token-based filename, bold/italic/background-colored header rows, and up to five conditional-formatting rules. When encoding, the first data row supplies the header row (Views field labels are used as headers when a Views style plugin is in context), each value is optionally tag-stripped and trimmed, columns are auto-sized (unless disabled), rows are set to auto-height with wrapped text, and values beginning with `=` are written as literal strings rather than formulas. A per-view `xls_settings` array controls the output format (`Xlsx`/`Xls`), tag stripping, trimming, and document metadata (creator, title, subject, keywords, company, etc.). A tiny admin form at `/admin/config/user-interface/xls_serialization` exposes one global toggle: disable column AutoSize (`xls_serialization_autosize`). In Views live-preview mode the encoder returns pretty-printed JSON instead of unreadable binary. A companion submodule, `xls_serialization_open_spout`, swaps the XLSX backend for the faster, lower-memory OpenSpout library at the cost of styling/metadata features.

---

- Add a Views "Data export" (or REST export) display that downloads results as an `.xlsx` file.
- Offer an Excel export of a content listing (nodes, users, terms) for editors.
- Serve a REST resource in Excel format via `?_format=xlsx` (or `?_format=xls`).
- Export the legacy binary `.xls` (Excel 5) format for older consumers.
- Give non-technical stakeholders spreadsheets that open natively in Excel.
- Export commerce orders or line items to a formatted workbook for accounting.
- Set a custom download filename with replacement tokens on the Excel export display.
- Make the header row bold, italic, or a chosen background color.
- Use Views field labels as human-readable column headers.
- Auto-size columns to fit their content (default), or globally disable AutoSize for speed.
- Auto-set row heights and wrap long text in cells.
- Apply conditional formatting that colors rows when a field matches a value.
- Strip HTML tags from rendered field values so cells contain clean text.
- Trim whitespace from every exported cell value.
- Embed document metadata (author, title, subject, keywords, company, manager) in the workbook.
- Set custom document properties (typed integer/float/string/date/boolean) on the file.
- Preview a Views Excel export safely (returns JSON, not binary, in live preview).
- Serialize arbitrary arrays to Excel programmatically via the core `serializer` service.
- Provide a scheduled/batched large export via `views_data_export`.
- Feed a decoupled front end or external system an Excel data endpoint.
- Keep leading-`=` values (e.g. codes) from being interpreted as spreadsheet formulas.
- Name each worksheet automatically from the view title (sanitized to 31 chars).
- Build an "export to spreadsheet" button backed by a Views REST export.
- Switch to the OpenSpout backend for memory-efficient large XLSX exports.
- Restrict who can change the global AutoSize setting via a dedicated permission.
