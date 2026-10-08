# PDF API — agent index

Backend-agnostic HTML→PDF API. Defines a **`PdfGenerator` plugin type** (manager
`plugin.manager.pdf_generator`, annotation `@PdfGenerator`, dir `Plugin/PdfGenerator`,
interface `PdfGeneratorInterface`, base `PdfGeneratorBase`) with four bundled backends:
`dompdf`, `mpdf`, `tcpdf`, `wkhtmltopdf`. Only admin UI is the Dompdf settings form. No
permissions of its own, no Drush. Submodule `puphpeteer` adds a Puppeteer backend.

- **Dompdf settings form, config object, keys** → [configure/dompdf-settings.md](configure/dompdf-settings.md)
- **Generate a PDF from code (load a generator, build, emit)** → [api/generate-pdf.md](api/generate-pdf.md)
- **Implement a new PDF backend as a `PdfGenerator` plugin** → [plugins/pdf-generator.md](plugins/pdf-generator.md)

Key facts:
- Config object: `pdf_api.dom_pdf.settings` (route `pdf_api.settings` at `/admin/config/system/pdf-api`, permission `administer site configuration`).
- Bundled generator plugin ids: `dompdf`, `mpdf`, `tcpdf`, `wkhtmltopdf` (+ `puphpeteer` from the submodule).
- Alter hook for generator definitions: `hook_pdf_api_generator_alter()`.
- Submodule docs: [puphpeteer](../../modules/puphpeteer/2.4.x/agent/start.md)
