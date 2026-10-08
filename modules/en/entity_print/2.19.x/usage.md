Entity Print converts any Drupal content entity (and, with its submodule, any View) into a downloadable PDF or other printable document, rendering the entity's HTML through a pluggable print engine such as Dompdf.

---

Entity Print renders an entity using a normal Drupal render pipeline into an HTML document (the `entity-print.html.twig` template) and then feeds that HTML to a **print engine** to produce a file. The default engine is Dompdf (bundled via Composer); Wkhtmltopdf and TCPDF are supported as optional engines, and the export-type system also allows EPub and Word `.docx` output. Site builders enable a "View PDF" pseudo-field on an entity type's Manage Display, or place the Print Links block / a bulk action, giving visitors a link to `print/{export_type}/{entity_type}/{entity_id}`. A settings form at Admin → Configuration → Content authoring → Entity Print controls default CSS, forced download, base URL, and per-engine options such as paper size, orientation, and DPI. Access is finely controlled: a global bypass permission plus dynamically generated per-entity-type and per-bundle "use print engines" permissions. Developers drive it programmatically through the `entity_print.print_builder` service to stream, render, or save documents to disk, and can add new engines by implementing a `PrintEngine` plugin. A rich set of events lets you alter the CSS, the generated HTML, the filename, and the engine configuration. CSS is best managed from your theme so print output can be styled independently of the screen. It is a production-ready, well-tested replacement for the older Print module.

---

- Add a "Download PDF" link to article or page nodes.
- Generate a printable PDF invoice from a Commerce order entity.
- Produce PDF certificates or badges from a user or custom entity.
- Let visitors save a printable version of a taxonomy term page.
- Export a View (e.g. a report or directory) to a single PDF.
- Provide a bulk "Print" action to download PDFs from a content listing.
- Place a Print Links block that offers PDF/EPub/Word links for a node.
- Offer multiple formats (PDF, EPub, Word .docx) side by side.
- Render an entity to PDF and save it to private file storage for archiving.
- Attach a generated PDF to an outgoing email in custom code.
- Batch-generate PDFs of many entities in a queue worker.
- Style print output separately from the screen via a print CSS library.
- Set default paper size and orientation (A4 portrait, Letter landscape, etc.).
- Force the browser to download rather than display the document.
- Switch the PDF engine to Wkhtmltopdf for better CSS/JS rendering.
- Use TCPDF where Dompdf's rendering is insufficient.
- Restrict PDF access to specific roles per entity type or bundle.
- Grant a trusted role the ability to bypass all print access checks.
- Debug print output by viewing the raw HTML at the `/debug` route.
- Add a custom print engine for a new document format via a plugin.
- Alter the generated filename with the filename-alter event.
- Inject extra CSS into the print document with the CSS-alter event.
- Post-process the rendered HTML before it is sent to the engine.
- Change engine configuration (DPI, HTTP auth) at runtime via an event.
- Embed images as base64 in PDFs using the provided field formatter.
- Provide a printable, brandable quote or packing slip for e-commerce.
