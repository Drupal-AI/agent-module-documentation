<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Print integration with TypeSet.sh adds a `typeset` print-engine plugin to the Entity Print module so entities can be rendered to PDF with the commercial pure-PHP typeset.sh HTML-to-PDF library.

---

Entity Print abstracts document generation behind swappable print-engine plugins; this module contributes one more engine, `Plugin\EntityPrint\PrintEngine\Typeset`, which extends Entity Print's `PdfEngineBase` and is annotated `@PrintEngine(id="typeset", label="Typeset.sh", export_type="pdf")`. Internally it creates a `Typesetsh\HtmlToPdf` object, renders a single block of HTML through `addPage()` (which calls the library's `render()`), and then either streams the result with `send()` (Content-Type `application/pdf`, inline or as an attachment) or returns the raw bytes with `getBlob()`. The engine only appears when the library is installed, because `dependenciesAvailable()` checks that the `Typesetsh\HtmlToPdf` class exists, and it offers a single paper size (A4). typeset.sh is a paid dependency: you must add its private Composer repository and credentials and require the package before the engine becomes available. This 1.0.0-alpha2 release is described by its maintainers as between experimental and proof-of-concept. The module has no settings, routes, permissions, services or config of its own — all rendering runs in-process in PHP with no shell-out and no outbound HTTP from the module.

There is nothing to configure in the module itself: once the paid library is installed and the module is enabled, you simply choose the *Typeset.sh* engine wherever Entity Print lets you pick one (its settings form and print links). The typical workflow is to install and authenticate the typeset.sh Composer package, enable this module, and then select this engine for your PDF exports so entities render through typeset.sh instead of the default engines such as dompdf or wkhtmltopdf.

---

- Render a Drupal entity to PDF using the typeset.sh engine
- Add a high-fidelity HTML-to-PDF engine option to Entity Print
- Select *Typeset.sh* as the active PDF engine in Entity Print settings
- Export a node as a nicely typeset A4 PDF
- Offer an alternative to the dompdf, wkhtmltopdf or PhantomJS engines
- Produce print-quality PDFs from rendered entity HTML
- Use the commercial typeset.sh renderer through its Composer package
- Stream a generated PDF inline in the browser
- Force a generated PDF to download as an attachment
- Retrieve raw PDF bytes with `getBlob()` for programmatic or queued use
- Gate PDF export on the typeset.sh library being installed and licensed
- Generate PDFs of content rendered in a specific view mode
- Integrate PDF generation into Entity Print's print links and blocks
- Keep the PDF engine choice swappable per Entity Print configuration
- Render invoices, certificates, tickets or reports as PDFs
- Produce printable case files or dossiers from structured content
- Extend Entity Print with a new engine without modifying its core code
- Attach a typeset.sh-generated PDF to an outgoing email via custom code
- Batch-export many entities to PDF using the same engine
- Standardize on A4 PDF output across a site
- Access the underlying `HtmlToPdf` object via `getPrintObject()` for advanced use
- Prototype typeset.sh output quality before committing to a full rollout
