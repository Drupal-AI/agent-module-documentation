PDF API is a backend-agnostic API for turning HTML into PDF documents from Drupal code. It ships a `PdfGenerator` plugin type with four bundled backends (dompdf, mPDF, TCPDF, wkhtmltopdf) and an admin settings form for the default dompdf backend.

---

The module defines a `PdfGenerator` plugin type: an annotation (`@PdfGenerator`) discovered from `Plugin/PdfGenerator`, a plugin manager service `plugin.manager.pdf_generator`, an interface `Drupal\pdf_api\Plugin\PdfGeneratorInterface`, and a base class `PdfGeneratorBase`. Four generator plugins ship in-box — `dompdf`, `mpdf`, `tcpdf` and `wkhtmltopdf` — each wrapping a Composer PDF library declared in the module's own `composer.json` (`dompdf/dompdf`, `mpdf/mpdf`, `tecnickcom/tcpdf`, `mikehaertl/phpwkhtmltopdf`). Consuming code loads a generator via the manager, then calls interface methods (`setter()`, `addPage()`, `setHeader()`, `setFooter()`, `setPageOrientation()`, `setPageSize()`, `save()`, `stream()`, `send()`) to build and emit a document. The only bundled admin UI is the **Dompdf** settings form at `/admin/config/system/pdf-api` (route `pdf_api.settings`, permission *administer site configuration*), whose values are stored in the `pdf_api.dom_pdf.settings` config object (font, DPI, PDF backend, remote/JS/PHP toggles, chroot, temp/font dirs, and a set of debug flags). The module itself renders nothing on the front end — it is a service other modules (notably Entity Print / Printable) build on. It has no permissions of its own, no Drush commands, and no hooks beyond `hook_help`. An optional `puphpeteer` submodule adds a fifth headless-Chrome/Puppeteer backend (documented separately) and is not enabled by default because it needs Node.js and the Puppeteer library.

---

- Generate a PDF of a rendered node or entity's HTML from custom code without picking a library up front.
- Swap the PDF rendering backend (dompdf ↔ mPDF ↔ TCPDF ↔ wkhtmltopdf) without changing calling code.
- Provide the low-level PDF engine that Entity Print / Printable uses to export content.
- Build an invoice or order-confirmation PDF from an HTML template in a controller or service.
- Produce a downloadable "print this page" PDF for articles or documentation pages.
- Email a generated PDF (e.g. a receipt) as an attachment from a queue worker or hook.
- Save a PDF to a file directory (`save()`) for later download or archival.
- Stream a PDF inline to the browser (`stream()`) instead of forcing a download.
- Set landscape vs portrait orientation and paper size (A4, Letter, etc.) per document.
- Add repeating header and footer HTML (page numbers, logos) to every PDF page.
- Configure the default dompdf font, DPI, and font/temp directories site-wide at `/admin/config/system/pdf-api`.
- Harden dompdf by disabling inline PHP, inline JavaScript, or remote asset loading via config.
- Enable dompdf debug flags (debug PNG, debug layout, keep-temp) while troubleshooting a broken PDF layout.
- Register a brand-new PDF backend as a `PdfGenerator` plugin (e.g. wrapping a SaaS PDF API).
- Alter or replace an existing generator plugin definition via the `pdf_api_generator` alter hook.
- Batch-render many entities to PDF in a cron or queue job for a nightly export.
- Concatenate several HTML fragments into one multi-page PDF with repeated `addPage()` calls.
- Choose the dompdf PDF backend engine (CPDF, GD, PDFLib) for different rendering trade-offs.
- Constrain dompdf's filesystem access with the `chroot` setting for security.
- Generate certificates, tickets, or badges from templated HTML.
- Provide a report-export-to-PDF feature for a dashboard or Views page.
- Use wkhtmltopdf when you need real browser-grade CSS/JS rendering fidelity.
- Use dompdf when you want a pure-PHP backend with no external binary.
- Read `getStderr()` / `getStdout()` / `displayErrors()` to debug a failing external-binary backend.
- Serve the same document as either an inline stream or a named download depending on context.
