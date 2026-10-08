<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Inpage navigation provides a block that scans a page's heading tags and renders an in-page (jump-link) navigation menu, letting visitors skip to sections of long content.

---

Configuration lives in `inpage.settings` and is edited at `/admin/structure/inpagenav/settings/config_settings` (`administer site configuration`): the parent wrapper class that contains the headings, wrapper classes whose headings should be excluded, a card-component wrapper-class exclusion, and which heading levels to include (e.g. `h1,h2,h3`). The `inpage` block (`InPageNav`) passes those settings to the `inpagenav/inpagenav` JS library via `drupalSettings` and renders through the `inpagenav` Twig template; the actual TOC is built client-side from the live DOM.

There are no controllers, permissions beyond core block placement, or external calls — it is a presentational block. All configuration is admin-gated.

---
- Add an in-page table of contents to long articles
- Place the "Inpage Navigation Block" in a sidebar or region
- Configure which heading levels (h1/h2/h3) become nav links
- Set the parent wrapper class that contains the headings
- Exclude headings inside specific wrapper classes
- Exclude headings inside card-component wrappers
- Generate jump links from existing on-page headings
- Improve navigation of documentation-style pages
- Let readers jump to sections without a manual anchor list
- Keep the TOC in sync with content since it's built from the DOM
- Theme the navigation via the `inpagenav` template
- Restrict TOC config changes to site administrators
- Include only h2/h3 levels for a shallower TOC
- Skip headings inside card components from the nav
- Add section jump-links to help pages and manuals
- Improve accessibility of long-form content navigation
