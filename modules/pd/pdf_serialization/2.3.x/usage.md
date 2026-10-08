PDF serialization registers a `pdf` serialization format/encoder and plugs it into the Views Data Export module, letting a View's Data export display render its rows as a downloadable PDF table (page size A1-A5, optional header/footer, page numbers) generated with mPDF.

---

This module is an extension for the contrib **Views Data Export** module; it does not work on its own. On install it (1) registers a Symfony serializer encoder tagged `encoder` with format `pdf` (service `pdf_serialization.encoder.pdf`), and (2) swaps the `data_export` Views style plugin class for its own `PdfExport` (via `hook_views_plugins_style_alter`), which adds `pdf` to the format choices on a Data export display and injects a "PDF settings" fieldset into the Views UI style options. When a Data export display's format is `pdf`, the view's field values are collected into a render-array `#type => table` (headers taken from the display's field labels), rendered to HTML, and passed to mPDF by the `PdfManager` service, which returns the PDF bytes. Configuration is entirely per-View: there is no global settings page, no permissions, and no Drush commands. PDF options live in the display's style options as `pdf_settings` (page `format` A1-A5 default A4; `show_header` + `header_content`; `show_footer` + `footer_content`; `show_page_number`), with header/footer text supporting mPDF replaceable aliases (e.g. `{PAGENO}`) and filtered through `Xss::filterAdmin`. Output is themed through overridable templates (`pdf_serialization_pdf`, `pdf_serialization_pdf_header`, `pdf_serialization_pdf_footer`) with per-view / per-display theme suggestions, and a small CSS library (`pdf_serialization/encoder_styles`) is attached to the feed icon. The PDF is delivered by Views Data Export's normal export mechanism (standard synchronous export or batch), so access is governed by the View's own access settings and the export path you configure (must end in `.pdf`).

---

- Export a View of content (nodes, users, taxonomy terms, commerce orders, etc.) as a PDF table for download.
- Add a "Download PDF" feed icon/link to a normal View page that lists filtered results.
- Build a filterable report page (exposed filters) whose current result set can be exported to PDF on demand.
- Produce printable A4 (or A1-A5) reports directly from Views without writing custom code.
- Give site admins a PDF export of an administrative listing (e.g. a moderation queue or user roster).
- Generate recurring data extracts as PDF via the Data export display path (e.g. `/export/report.pdf`).
- Provide the same View in multiple export formats (CSV, XLS, PDF) by adding several Data export displays.
- Add a branded page header to exported PDFs (logo/title text via `header_content`).
- Add a page footer with custom text to exported PDFs (`footer_content`).
- Show automatic page numbers in the PDF footer (`{PAGENO}` / `show_page_number`).
- Choose a large page format (A1/A2/A3) for wide tables with many columns.
- Use field labels from the Data export display as the PDF table column headers.
- Override PDF markup per-view or per-display using theme suggestion templates.
- Style the exported PDF table with custom CSS via the attached library or a theme override.
- Export batched (large) result sets to PDF using Views Data Export's batch export method.
- Let anonymous or authenticated users download a public report as PDF (gated by the View's access control).
- Attach a PDF export display to an existing page display so users filter, then export what they see.
- Serve compliance/audit style tabular exports (activity logs, orders, submissions) as PDF.
- Combine exposed filters with a PDF export to create parameterised, downloadable reports.
- Replace ad-hoc "print to PDF" browser workflows with a server-generated, consistent PDF.
- Use `PdfManager::getPdf()` from custom code to turn a render array into PDF bytes.
- Migrate an existing CSV/XLS Views export to PDF by adding `pdf` as the format on the Data export display.
