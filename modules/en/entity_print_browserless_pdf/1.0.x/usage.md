<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Adds a Browserless (headless Chrome) print engine to Entity Print, rendering PDFs on a remote HTTP service instead of a local PHP library.

---

Entity Print Browserless PDF is a print-engine plugin for the Entity Print module. Instead of rendering PDFs with a bundled PHP library (Dompdf, TCPDF, or a local wkhtmltopdf binary), it POSTs the entity's generated print HTML to a Browserless `/pdf` endpoint — a headless-Chrome-as-a-service API — and streams back the resulting PDF. Browserless can be self-hosted with the open-source `browserless/chrome` Docker image or consumed through the browserless.io paid service. Because the pages are rendered by real Chrome, output fidelity (CSS, web fonts, backgrounds) is typically higher than PHP renderers. The engine is selected and configured entirely from Entity Print's own settings form; it adds one Guzzle-based HTTP client, a set of Chrome print options (paper size, margins, background graphics, header/footer templates, safe mode), an endpoint URL, and an optional access token. It requires the `entity_print` module (`^2.4`) and supports Drupal 10 and 11.

---

- Render Entity Print PDFs with headless Chrome instead of a local PHP PDF library.
- Offload PDF generation to a separate Browserless service to reduce web-server load.
- Use the browserless.io hosted service so no local PDF binary needs installing.
- Point the engine at a self-hosted `browserless/chrome` container on your own infrastructure.
- Get higher-fidelity PDFs that honor modern CSS, web fonts, and background graphics.
- Produce print-quality PDFs of nodes, commerce orders, invoices, or any printable entity.
- Choose a paper format (Letter, Legal, Tabloid, Ledger, A0–A6) for generated PDFs.
- Set independent top/right/bottom/left page margins in millimeters or pixels.
- Enable background-graphics printing so themed backgrounds appear in the PDF.
- Add a repeating HTML header on every PDF page via a header template.
- Add a repeating HTML footer (e.g. page numbers) on every PDF page via a footer template.
- Turn on Browserless "safe mode" to avoid page-render crashes in headless Chrome.
- Secure a self-hosted Browserless instance with an access token passed by the engine.
- Combine multiple print pages into one PDF with automatic page breaks between them.
- Rewrite relative asset URLs (CSS/JS) to absolute ones so remote Chrome can fetch them.
- Override the asset base URL when the site's public host differs from what Chrome should fetch.
- Test connectivity to the Browserless endpoint directly from the settings form.
- Force PDF download or render it inline in the browser, per Entity Print's request.
- Swap the print engine to Browserless without changing how Entity Print links/routes are used.
- Generate PDFs for bulk or programmatic export flows built on Entity Print's API.
- Standardize PDF rendering across environments by centralizing it on one Browserless service.
