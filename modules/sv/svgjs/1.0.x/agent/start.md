<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SVG.js (svgjs) — agent index
**Attaches the SVG.js JS library (local `/libraries/svgjs/svg.min.js` or jsDelivr CDN v3.2.0) site-wide for manipulating/animating SVG.**

- **Version:** 1.0.x (1.0.0-alpha1)
- **Core:** ^8.8 || ^9 || ^10 || ^11
- **Libraries:** `svgjs/svgjs.js` (local) and `svgjs/svgjs.cdn` (external CDN).
- **Attach logic:** `svgjs_page_attachments()` — local if `svgjs_check_installed()`, else CDN; skipped if `svgjs_ui` module exists.
- **Helpers:** `svgjs_element_options()`, `svgjs_easing_options()`, `svgjs_transform_options()`, `svgjs_fill_rule_options()`.

**Security:** no routes, permissions, forms, or user input; the module only loads a JS asset and does not render or sanitize user-supplied SVG, so it adds no stored-XSS surface. (Loads a third-party CDN asset when no local library is installed.)
