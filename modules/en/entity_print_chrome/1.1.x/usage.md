<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Print Chrome plugs a Chromium/Chrome-based PDF renderer into the Entity Print module. Where Entity Print ships engines like Dompdf and wkhtmltopdf, this adds a `chrome` print engine that uses the `chrome-php/chrome` PHP library to drive a headless Chrome browser and produce high-fidelity PDFs from the same HTML Entity Print renders for an entity.
It is useful when you need modern CSS support in printed PDFs (flexbox, grid, web fonts) that older engines render poorly. All page selection, routing and access control come from Entity Print itself; this module only supplies the engine and a small HTML post-processor.
---
Install with `composer require drupal/entity_print_chrome` (which pulls in `chrome-php/chrome`) and enable it plus `entity_print`. A Chrome/Chromium binary must be present on the server; set its path in the engine configuration (default `/usr/bin/google-chrome`). Then select "Chrome" as the PDF engine in Entity Print's settings (`/admin/config/content/entityprint`) and optionally enable "Print background images".
Under the hood the engine writes the accumulated HTML to a temporary file, opens it in headless Chrome (`noSandbox => TRUE`) via `file://`, waits for network idle, and calls Chrome's `pdf()` (10s timeout) to get the bytes. A `PostRenderSubscriber` rewrites root-relative `href`/`src` attributes to `file://` absolute URLs so local assets resolve when rendering from the temp file (skipped on Entity Print's debug routes).
---
- Install: `composer require drupal/entity_print_chrome && drush en entity_print entity_print_chrome -y`.
- Ensure a Chrome/Chromium binary exists on the server (e.g. `/usr/bin/google-chrome`).
- Set the binary path in the Chrome engine settings if it differs from the default.
- Choose "Chrome" as the PDF engine in Entity Print settings.
- Optionally enable "Print background images" for full-color output.
- Generate a node PDF via Entity Print's route (access governed by Entity Print permissions).
- Get better CSS fidelity (grid/flex/fonts) than Dompdf/wkhtmltopdf.
- Use `->getBlob()` programmatically through Entity Print's PrintBuilder.
- Force download or inline display via Entity Print's `send()` flow.
- Rely on the post-render subscriber to fix root-relative asset paths.
- Debug HTML on `entity_print.view.debug` (URL rewriting is skipped there).
- Runs Chrome with `noSandbox` — run behind a low-privilege service user/container.
- The Chrome binary path is admin-only config; keep the print settings form restricted to trusted admins.
- Temp HTML files are written to `temporary://` and unlinked after rendering.
- Tune expectations around the 10s PDF timeout for very large documents.
- Combine with entity_print_views to print View results.
