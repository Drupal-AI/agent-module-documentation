<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Provides the 'Files / Downloads' Paragraphs bundle that references media documents and lists them for download.

---

A one-bundle submodule of DROWL Paragraphs for Bootstrap. The `attachments` paragraph type has a multi-value media entity reference (`field_attachments`) plus a referenced-entity view-mode selector (`field_nodeentityrefvm`). Its preprocess moves Bootstrap `btn-*` UI-Styles classes off the paragraph wrapper and passes them down to the referenced media documents so download links can be rendered as buttons.

It is a presentational, config-only paragraph bundle: no permissions, routes, services or config schema of its own. Enable it alongside its parent `drowl_paragraphs_bs` and the Paragraphs / Layout Paragraphs stack, then add the bundle to a Paragraphs or Layout Paragraphs field. Per-instance styling is driven by UI Styles from the Paragraphs 'Settings'.

---

- Attach a set of downloadable PDFs / documents to a page.
- Render a media document list as Bootstrap buttons via `btn-*` UI Styles.
- Pick the view mode used to render each referenced media item.
- Group project files into a reusable download block.
- Offer press-kit or datasheet downloads inside a Layout Paragraphs section.
- Enable the submodule to make its paragraph bundle(s) available in Layout Paragraphs / Paragraphs fields.
- Use it as a component inside a `layout` / `layout_slideshow` container built with the layout_paragraphs module.
- Style each instance from the Paragraphs 'Settings' (UI Styles) without writing CSS.
- Override the shipped `paragraph--drowl-paragraphs-bs--<bundle>.html.twig` in your (Bootstrap 5 / Radix / DROWL Base) theme to adjust markup.
- Uninstall the submodule alone if the bundle is not needed, keeping the rest of the DROWL paragraph set.
