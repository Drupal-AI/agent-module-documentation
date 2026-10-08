A thin Drupal wrapper around the TCPDF PHP library for programmatically generating PDF documents (including HTML-to-PDF) from custom module code. It is a developer API — there is no UI. Version 3.0 moves to the TCPDF 7 library family and requires Drupal 11.3+ or 12.

---

The module ships the `tecnickcom/tcpdf` library (`^7.0.15`, a compatibility layer over the `tecnickcom/tc-lib-pdf` 8.x components) via Composer and exposes one procedural factory, `tcpdf_get_instance()`, which returns a fresh `TCPDFDrupal` object (a subclass of `TCPDF`). You pass constructor params (orientation, unit, format, unicode, encoding, diskcache, pdfa — sensible A4/portrait/UTF-8 defaults are merged in), optionally a custom subclass, and optionally an alternate config include. Before instantiating it defines `K_TCPDF_EXTERNAL_CONFIG` and loads the module's `tcpdf.config.inc`. In 3.0 that include defines only `K_PATH_FONTS` (resolved by the new `FontDirectory` service) and `PDF_IMAGE_SCALE_RATIO`; every other `K_*`/`PDF_*` constant comes from TCPDF 7's own `tcpdf_autoconfig.php`, and there is no module-managed cache directory. `TCPDFDrupal` adds Drupal-prefixed helpers, chiefly `DrupalInitialize($options)` for quickly setting title/subject/author/keywords/logo and building a Header/Footer (from an HTML string or a callback) without subclassing; it also calls `AddPage()` for you. From the returned instance you use the normal TCPDF API (`writeHTML()`, `Output()`, etc.). Because TCPDF 7 ships no fonts, they must be built from `tecnickcom/tc-lib-pdf-font` (optionally into a directory outside `vendor/` referenced by `$settings['tcpdf_fonts_path']`); a runtime requirements check (`\Drupal\tcpdf\Hook\TcpdfRequirements`) verifies the TCPDF class is available and the core fonts are present. A `tcpdf_example` submodule provides a permission-gated route that streams a sample PDF. The module has no config UI, no permissions of its own, and no plugins.

---

- Generate a PDF invoice, receipt, or order confirmation from a custom module.
- Convert an HTML/Twig-rendered template into a downloadable PDF via `writeHTML()`.
- Stream a generated PDF to the browser as a download from a controller.
- Build multi-page reports with headers, footers, and page numbers.
- Produce UTF-8 / Unicode PDFs (multilingual content, non-Latin scripts).
- Create PDF/A-compliant archival documents by passing `pdfa`.
- Add a logo/branding header to generated PDFs via `DrupalInitialize()` (`logo_path` or a header callback).
- Set document metadata (title, subject, author, keywords) programmatically.
- Render tables, barcodes, and images supported by TCPDF into a document.
- Generate certificates or tickets from entity data.
- Attach a generated PDF to an outgoing email.
- Save a generated PDF to the filesystem for later download.
- Use a custom `TCPDFDrupal` subclass for a house style shared across documents.
- Override page size, margins, or fonts by pre-defining TCPDF constants or a custom config include.
- Build and locate the TCPDF 7 fonts, keeping them across Composer updates via `$settings['tcpdf_fonts_path']`.
- Produce landscape or non-A4 documents by passing constructor params.
- Provide a "Download as PDF" action for nodes or Views rows in custom code.
- Embed local files outside the trusted directories by adding them to `K_ALLOWED_PATHS`.
- Learn the integration pattern from the `tcpdf_example` submodule's sample route.
