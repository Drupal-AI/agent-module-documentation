<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Toc NG builds a table of contents from a page's headings entirely in the browser (JavaScript), exposed as a configurable Drupal block, with an optional submodule to toggle it per node.

---

You place the **Toc NG block** wherever you want the contents to appear and configure it through the block form. Settings control which elements become entries (`selectors`, e.g. `h2,h3`), the container to scan (`container`, default `.node`), a minimum heading count before the TOC shows, the anchor/class `prefix`, list type (`ul`/`ol`), the title text/tag/classes, and a range of UX/accessibility options: "back to top" and "back to toc" links (with labels/classes), heading focus, smooth scrolling, scroll highlighting with an offset, sticky positioning with an offset, and re-scanning after AJAX page updates. These values are passed to `drupalSettings` and the bundled `tocng.js`/`toc_ng.js` build the anchored list on the client; the block preprocess uses `Html`/`Xss` helpers for the markup it does emit. The submodule **Toc NG per node** adds a block that reads a per-node setting so editors can enable/disable the TOC on individual nodes, guarded by its own `administer toc_ng` permission.

Operationally the module is display-only: it registers no routes and no controllers; all configuration happens through the standard block configuration form, which is gated by core's block-administration permission, and the per-node submodule adds the `administer toc_ng` permission. Because the TOC is generated client-side from already-rendered headings, there is no server-side processing of request data, no external calls, and no mutating endpoints. Setup: enable `toc_ng` (optionally `toc_ng_per_node`), place the Toc NG block on the desired region/pages, and tune the selectors/container to match your theme's markup.

---
- Add an automatic table of contents to content pages
- Place the Toc NG block in a sidebar or above the content
- Choose which heading levels become TOC entries (e.g. `h2,h3`)
- Restrict scanning to a container selector (default `.node`)
- Require a minimum number of headings before showing the TOC
- Set the TOC title text, HTML tag and CSS classes
- Use an ordered or unordered list for the TOC
- Add a custom anchor/class prefix for generated ids
- Show "back to top" links next to headings
- Show "back to table of contents" links next to headings
- Enable smooth scrolling to anchors
- Highlight the current section on scroll (with an offset)
- Make the TOC sticky with a configurable offset
- Set focus on the target heading for accessibility
- Re-generate the TOC after AJAX page updates
- Toggle the TOC per node with the `toc_ng_per_node` submodule
- Grant editors the `administer toc_ng` permission for per-node control
- Style the TOC via the module's CSS library and prefix classes
- Provide keyboard/screen-reader-friendly in-page navigation
- Add TOCs without server-side parsing of content
