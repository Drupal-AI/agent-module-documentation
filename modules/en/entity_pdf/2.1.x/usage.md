Entity PDF renders any content entity in any view mode to a PDF, served at a URL or downloaded in bulk, using a pluggable rendering engine (mPDF 8 by default). You control the whole PDF markup through a single overridable `htmlpdf.html.twig` template.

---

Two routes expose the feature: `/node/pdf/{node}/{view_mode}` (nodes, gated by the `view entity pdf` permission) and `/entity_pdf/{entity_type}/{entity}/{view_mode}` (any entity, gated by a custom access check). `PdfEntityController::view()` calls the `entity_pdf.generator` service, which renders the entity's view mode inside the `htmlpdf` theme wrapper (`renderEntity()`), passes the resulting HTML to the selected rendering-engine plugin (`RenderingEngineMpdf` wraps `Mpdf\Mpdf::WriteHTML()`), and returns a `CacheableResponse` with `Content-Type: application/pdf`. Whether the PDF opens inline or downloads is controlled by the `openInBrowser` setting and a `?inline=1` query override. The settings form (`/admin/config/system/entity_pdf`, permission `administer entity pdf settings`, restricted) configures the token-based filename (e.g. `[node:nid].pdf`), the mPDF temp dir, an optional custom template path, the browser/download default, and the rendering engine plus its options. Rendering engines are a plugin type (`@EntityPdfRenderingEngine`, manager `plugin.manager.entity_pdf_rendering_engine`) so other modules can add PDF back-ends; `hook_mpdf_config_alter()` and `hook_entity_pdf_filename_alter()` are the extension points. A configurable VBO/Views action ("Entity Pdf Download") streams a multi-page PDF for a set of selected nodes, and a Display Suite field adds a PDF link on node view modes. A dynamic per-view-display permission (`view <entity_type>.<bundle>.<view_mode> pdf`) exists alongside the blanket `view entity pdf`.

---

- Generate a PDF of a node from `/node/pdf/{nid}/{view_mode}` (e.g. `/node/pdf/5/pdf`).
- Generate a PDF of any entity type via `/entity_pdf/{entity_type}/{id}/{view_mode}`.
- Design a dedicated "pdf" view mode and theme fields specifically for print output.
- Fully control the PDF's HTML/CSS by overriding `htmlpdf.html.twig` in your theme/module.
- Name generated files with entity tokens, e.g. `[node:title]-[node:nid].pdf`.
- Open PDFs inline in the browser instead of forcing a download (global or `?inline=1`).
- Force download for specific links even when inline is the default (omit/adjust `?inline`).
- Bulk-download a combined multi-page PDF for many nodes via a Views/VBO bulk action.
- Add a "Download PDF" link to node view modes using the Display Suite integration.
- Swap the PDF engine by installing a module that provides an `EntityPdfRenderingEngine` plugin.
- Tune mPDF (margins, fonts, page size) with `hook_mpdf_config_alter()`.
- Alter the computed filename per entity with `hook_entity_pdf_filename_alter()`.
- Produce invoices, tickets, certificates, or reports from structured content.
- Give editors a print-ready export of an article or landing page.
- Restrict PDF access per view display with the granular `view <type>.<bundle>.<mode> pdf` perm.
- Point mPDF at a writable temp directory under the Drupal root for font caching.
- Generate localized PDFs by passing/using the langcode in the render pipeline.
- Cache PDF responses with entity + config cacheability metadata bubbled from the render.
- Build a custom controller/service call to `entity_pdf.generator` for programmatic PDFs.
- Attach a PDF-download button to any entity template via a route link.
- Produce consistent branded documents with no Drupal CSS/JS leaking into the PDF.
