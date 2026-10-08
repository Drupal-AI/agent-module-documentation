A thin Drupal wrapper around the TCPDF PHP library for programmatically generating PDF documents (including HTML-to-PDF) from custom module code. It is a developer API — there is no UI.

---

The module ships the `tecnickcom/tcpdf` library via Composer and exposes one procedural factory, `tcpdf_get_instance()`, which returns a fresh `TCPDFDrupal` object (a subclass of `TCPDF`). You pass constructor params (orientation, unit, format, unicode, encoding, diskcache, pdfa — sensible A4/portrait/UTF-8 defaults are merged in), optionally a custom subclass, and optionally an alternate config include. Before instantiating it defines `K_TCPDF_EXTERNAL_CONFIG` and loads the module's `tcpdf.config.inc`, which sets TCPDF's `K_*`/`PDF_*` constants (page format, margins, fonts, cache dir at `temporary://tcpdf/cache`, etc.) only if not already defined — so you can pre-define any constant to override it. `TCPDFDrupal` adds Drupal-prefixed helpers, chiefly `DrupalInitialize($options)` for quickly setting title/keywords and building a Header/Footer (from an HTML string or a callback) without subclassing. From the returned instance you use the normal TCPDF API (`AddPage()`, `writeHTML()`, `Output()`, etc.). `hook_requirements` verifies the TCPDF class is available and the temporary cache directory is writable. A `tcpdf_example` submodule provides a permission-gated route that streams a sample PDF. The module has no config UI, no permissions of its own, and no plugins.

---

- Generate a PDF invoice, receipt, or order confirmation from a custom module.
- Convert an HTML/Twig-rendered template into a downloadable PDF via `writeHTML()`.
- Stream a generated PDF to the browser as a download from a controller.
- Build multi-page reports with headers, footers, and page numbers.
- Produce UTF-8 / Unicode PDFs (multilingual content, non-Latin scripts).
- Create PDF/A-compliant archival documents by passing `pdfa`.
- Add a logo/branding header to generated PDFs via `DrupalInitialize()` callbacks.
- Set document metadata (title, author, keywords) programmatically.
- Render tables, barcodes, and images supported by TCPDF into a document.
- Generate certificates or tickets from entity data.
- Attach a generated PDF to an outgoing email.
- Save a generated PDF to the filesystem for later download.
- Use a custom `TCPDFDrupal` subclass for a house style shared across documents.
- Override page size, margins, or fonts by pre-defining TCPDF constants or a custom config include.
- Batch-generate PDFs (e.g. per user or per node) in a queue/cron job.
- Produce landscape or non-A4 documents by passing constructor params.
- Provide a "Download as PDF" action for nodes or Views rows in custom code.
- Cache TCPDF working files under the site's temporary directory.
- Learn the integration pattern from the `tcpdf_example` submodule's sample route.
