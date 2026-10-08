<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Noahs Page Builder is a drag-and-drop visual page builder for Drupal that edits entities (nodes, commerce products) through a live iframe editor made of pluggable widgets and styling controls.
---
The module adds an "Edit with Noahs" surface at `/noahs_edit/{entity_type}/{entity}` where content is composed from Widget plugins (rows, columns, headings, buttons, carousels, galleries, tabs, forms, Drupal blocks/views/tokens, etc.) styled by Control plugins (padding, margin, color, background, typography, borders, shadows, and more). The builder saves its layout as JSON via `POST /noahs_page_builder/save_page` into custom tables (`noahs_page_builder_page`, with generated CSS), and renders it on the front end through an event subscriber and Twig templates. Widgets and Controls are two annotation/attribute-based plugin systems (`WidgetManager`, `ControlManager`) backed by services, so the palette is extensible.

Operationally the whole editing/admin surface is behind **one** permission, `administer noahs_page_builder`: the admin pages (`/admin/structure/noahs*`), the editor/preview routes, every `/noahs-admin/*` AJAX endpoint (widget forms, modal media, icons, tokens, URL autocomplete, media image helpers), and the `save_page` mutation all require it. There are no anonymous or `_access: TRUE` routes — the front-end render path is a read-only theming layer. Persistence uses the Drupal database API with parameterized queries (no raw SQL concatenation), and the settings form's HTTP check uses `CURLOPT_SSL_VERIFYPEER = TRUE`.

Two things to watch when operating it: (1) the media upload endpoint (`/noahs-admin/noahs_page_builder/upload_file`) saves uploaded files to `public://` while preserving the original extension and applies **no server-side extension/MIME allowlist** (it explicitly accepts SVG), so it relies entirely on the single admin permission for safety — grant `administer noahs_page_builder` only to fully trusted users; (2) widgets accept arbitrary CSS/HTML/plain-code that is rendered to site visitors, so that permission is effectively equivalent to a full-HTML/site-styling capability. Setup: enable the module, visit `/admin/structure/noahs` to configure settings and styles, then open any node's "Edit with Noahs" tab to build a page.
---
- Build a landing page visually on top of any node.
- Edit a commerce product page with the drag-and-drop builder.
- Compose layouts from row/column/card-grid widgets.
- Add heading, text, button, and separator widgets.
- Insert carousels, slideshows, and galleries.
- Add tabs, accordions, and countdown widgets.
- Embed a Drupal block, view, or webform as a widget.
- Insert token values or another node's content into a page.
- Style any element with padding/margin/border/radius controls.
- Set background images, gradients, and overlays per element.
- Apply typography controls (font, font styles) to text.
- Add custom CSS to a specific element via a control.
- Upload media through the builder's media modal.
- Pick icons from the icon list for icon/icon-list widgets.
- Configure global builder settings at /admin/structure/noahs/settings.
- Manage reusable style presets at settings_styles.
- Save a page layout as JSON (POST /noahs_page_builder/save_page).
- Preview an entity's Noahs layout before saving.
- Extend the palette with a custom Widget plugin.
- Add a custom styling Control plugin.
- Use the noahs_gallery submodule for gallery config entities.
- Restrict all builder access to trusted editors via one permission.
- Render built pages to visitors via the response subscriber + Twig.