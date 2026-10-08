<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Printjs adds a Print button, backed by the third-party Print.js library, that prints one region of the page — a chosen div, a view's results, a node's content — instead of the whole browser window.

---

Install it with `composer require drupal/printjs` and enable it (`drush en printjs`); no other modules are required. Out of the box the button loads the **Print.js** JavaScript from a public CDN — if you prefer to self-host, download the library from its GitHub releases into `libraries/Print.js/` and tick the **"Use libraries/Print.js"** checkbox so it loads locally. There are three ways to place a button: the **Print button** block (Block layout, category *Print*), a **PrintJs** area handler you add to a view's header or footer, or a call to the `print.js` service (`getBtnPrintjs()`) from your own code. Each button targets a content selector — by default the element with `id="print"`, but you can point it at any id, class, or the results of a view via the settings at `/admin/config/printjs/settings` or per instance. When clicked, the wrapper script gathers the page's stylesheets so the printout keeps its styling, isolates the target region, and hands it to Print.js; options let you print the element's parent instead, auto-print on load, and (via `hook_preprocess_printjs`) switch Print.js into its PDF, image, or JSON modes. Note that only what is already in the DOM prints — anything lazy-loaded or hidden behind "show more" will be missing — and where you control the theme a plain print stylesheet remains the more robust foundation. It runs on Drupal 8.8 through 12.

---

- Print a specific `#print` div instead of the whole page.
- Print a view's results from a header or footer button.
- Add a Print button block to any region.
- Print a node's body without the navigation and sidebars.
- Give visitors a clean printed copy of a report.
- Print a filtered or sorted listing.
- Add printing without writing a print stylesheet.
- Print a table of data.
- Produce a paper copy of a roster or schedule.
- Print an invoice or order region.
- Print a product specification sheet.
- Add a print button to a dashboard.
- Print a checklist or agenda.
- Auto-print a page when it loads.
- Print the parent wrapper of a target element.
- Self-host the Print.js library instead of using the CDN.
- Render a print button from custom code via the `print.js` service.
- Switch the button to print a PDF, image, or JSON with `hook_preprocess_printjs`.
- Print search results.
- Give editors a quick print preview.
- Target print output at a custom id or class selector.
- Keep the page's CSS on the printed output.
