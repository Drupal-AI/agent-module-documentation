<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
A CSS-only support module that attaches admin-theme, toolbar, Layout Builder and CKEditor styling fixes to Drupal administration pages, meant to sit under the other DROWL (`drowl_*`) modules.

---

DROWL Admin is a small, configuration-free helper from the German agency DROWL. On admin routes it attaches a set of minified CSS libraries that polish the backend: CKEditor tweaks, admin-theme overrides for Gin and Adminimal, Layout Builder overrides for Claro and Gin, and fixes for the admin toolbar and contextual links. It also strips `h1` from the `full_html` CKEditor toolbar's format dropdown and, when the optional `project_wiki_markdown_content` module is present, contributes bundled editorial Markdown documentation through a `ProjectWikiContent` plugin. Its only hard dependency is core Layout Builder; it expects the front-end iconset library `npm-asset/drowl-admin-iconset` to be installed at `/libraries/drowl-admin-iconset/` (a runtime requirements check warns if missing). The module ships no routes, permissions, settings form, config, services or Drush commands — it is essentially declarative CSS attachment driven by three hooks, and is not useful on its own without the other `drowl_*` modules.

---

- Apply DROWL's admin CSS polish across the Drupal administration backend.
- Attach CKEditor styling tweaks (`admin_ckeditor_tweaks`) on every admin route.
- Load Gin admin-theme CSS overrides when the admin theme is Gin.
- Load Adminimal admin-theme CSS overrides when the admin theme is Adminimal.
- Apply Layout Builder CSS overrides for the Claro admin theme on Layout Builder routes.
- Apply Layout Builder CSS overrides for the Gin admin theme on Layout Builder routes.
- Fix admin toolbar styling via `admin_toolbar_fixes` attached in `hook_toolbar_alter()`.
- Fix contextual-links styling via the `contextual_links` library.
- Remove the `h1` option from the `full_html` CKEditor format-tags dropdown (leaves `p;h2;h3;h4;h5;h6;pre`) to keep editors from using page-level H1s.
- Provide a shared CSS variables base (`drowl_admin/admin`) that other DROWL admin styling builds on.
- Serve the DROWL admin iconset stylesheet from `/libraries/drowl-admin-iconset/style.css`.
- Surface a Status Report requirement warning when the iconset library is not installed.
- Underpin the admin UI of sibling modules such as `drowl_layouts` and `drowl_paragraphs`.
- Contribute bundled editorial Markdown docs to a project wiki when `project_wiki_markdown_content` is enabled.
- Document field-display class conventions (`field__label--colon`, `field-items--inline`, `field--label-column`) for editors via that wiki content.
- Enable a consistent backend look-and-feel across a multi-module DROWL install.
- Keep all styling changes scoped to admin routes so the public/front-end theme is untouched.
- Deploy as a low-risk, no-configuration dependency (enable and forget).
- Standardize Layout Builder editing chrome across Claro and Gin.
