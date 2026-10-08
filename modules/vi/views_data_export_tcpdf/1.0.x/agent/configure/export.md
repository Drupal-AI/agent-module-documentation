<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring a PDF Views Data Export

## Prerequisites
- `views_data_export` enabled.
- TCPDF library present in the site `libraries/` directory (README). The encoder uses TCPDF constants (`PDF_PAGE_ORIENTATION`, `PDF_MARGIN_*`, etc.).

## Create the export
1. Edit a View → **Add** a **Data export** display.
2. Set the format to **PDF** (this module registers the `pdf` encoder and overrides the `data_export` display class with `Drupal\views_data_export_tcpdf\Plugin\views\display\PdfDataExport`).
3. Configure fields as normal; column headers come from field labels (`extractHeaders()`).

## `pdf_settings` (style plugin options)
- **metadata**: `creator`, `title`, `subject`, `keywords` → `SetCreator/SetAuthor/SetTitle/SetSubject/SetKeywords`.
- **header**: `title` (defaults to view title), `subtitle`, `phone`/`email`/`website` (joined with ` | `), `address`, `notes`, and `logo` = a **file entity id**. The logo is loaded via the file storage and resolved with `fileSystem->realpath()`; only a local, existing path is used.
- **footer**: `left`, `center`, `right`; page numbers (`Page X of Y`) are added automatically.
- Header/footer are printed only when at least one relevant value (or logo) is set; margins adjust accordingly. Output is landscape (`AddPage('L')`).

## Optional: merge into an existing PDF
`PdfExportForm` (`src/Form/PdfExportForm.php`) lets a user upload a PDF (validators: extensions `pdf pdfx`, max upload size) or reference an existing file; `submitForm()` passes `_pdf_file` into `PdfDataExport::buildResponse()`. `ExportRedirectSubscriber` re-issues the export response when the export route carries a `_pdf_file` param.

## Rendering & escaping
`Pdf::encode()` builds an HTML `<table>` where **every** header and cell goes through `strip_tags()` + `Html::escape()` (`buildTableHtml`/`formatCellValue`), then `writeHTML()`; returns `Output('', 'S')` (string). No remote images or raw HTML from row data reach TCPDF.

## Access
Set the Data Export display's **access** plugin to match the sensitivity of the data — the PDF endpoint inherits it.
