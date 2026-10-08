<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Provides the 'Layout: Grid' Paragraphs container bundle used by layout_paragraphs to group child paragraphs into Bootstrap grid regions.

---

A one-bundle submodule of DROWL Paragraphs for Bootstrap. The `layout` paragraph type is a layout_paragraphs section container: it structures child paragraphs into Bootstrap grid regions and supports an optional background media image with an overlay, an overlay link, an anchor id/title and custom background-image classes.

It is a presentational, config-only paragraph bundle: no permissions, routes, services or config schema of its own. Enable it alongside its parent `drowl_paragraphs_bs` and the Paragraphs / Layout Paragraphs stack, then add the bundle to a Paragraphs or Layout Paragraphs field. Per-instance styling is driven by UI Styles from the Paragraphs 'Settings'.

---

- Create a multi-column section that holds other paragraphs.
- Give a section a full-width background image with a coloured overlay.
- Make a whole section clickable via an overlay link.
- Anchor a section for one-page / scrollspy navigation.
- Constrain a section to page-width or full-width containers.
- Enable the submodule to make its paragraph bundle(s) available in Layout Paragraphs / Paragraphs fields.
- Use it as a component inside a `layout` / `layout_slideshow` container built with the layout_paragraphs module.
- Style each instance from the Paragraphs 'Settings' (UI Styles) without writing CSS.
- Override the shipped `paragraph--drowl-paragraphs-bs--<bundle>.html.twig` in your (Bootstrap 5 / Radix / DROWL Base) theme to adjust markup.
- Uninstall the submodule alone if the bundle is not needed, keeping the rest of the DROWL paragraph set.
