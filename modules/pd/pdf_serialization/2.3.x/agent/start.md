# pdf_serialization (Serialization (PDF)) 2.3.x

Extension for **Views Data Export**. Registers a `pdf` serializer encoder and makes the
Views **Data export** display able to output view results as a PDF table (rendered by mPDF).
Not a REST `?_format=pdf` module and not standalone — it only works through views_data_export.

## Facts
- Requires: contrib `views_data_export`, core `serialization`; PHP lib `mpdf/mpdf ^8.0`.
- No config page, no permissions, no Drush, no routes of its own. Provides config schema for
  `pdf_settings` on the data_export style.
- Encoder service `pdf_serialization.encoder.pdf` (tag `encoder`, format `pdf`).
- Manager service `pdf_serialization.pdf_manager` (`PdfManager::getPdf(array $content, array $options, $destination)`).
- Views style plugin `PdfExport` (extends views_data_export `DataExport`); swapped in via
  `hook_views_plugins_style_alter` so `pdf` appears as a Data export format.
- Theme hooks/templates: `pdf_serialization_pdf`, `_pdf_header`, `_pdf_footer` (per-view/display suggestions).
- Library `pdf_serialization/encoder_styles` (css/pdf-encoder.css) attached to the export feed icon.

## Setup (per-View, no UI settings page)
1. Create a View listing the data; add fields + exposed filters.
2. Add a **Data export** display; in Format settings choose **pdf**.
3. Set Pager to "Display all items" (otherwise limited to page size).
4. Path must end in `.pdf` (e.g. `/export/report.pdf`); "Attach to" a Page display to show the icon.
5. Optional "PDF settings" fieldset: page format A1-A5 (default A4), show_header + header_content,
   show_footer + footer_content, show_page_number. Header/footer support mPDF aliases (`{PAGENO}`),
   filtered with Xss::filterAdmin.

## Docs
- `agent/api/encoder.md` — encoder + PdfManager wiring, pdf_settings, how PDF output is produced/requested.
