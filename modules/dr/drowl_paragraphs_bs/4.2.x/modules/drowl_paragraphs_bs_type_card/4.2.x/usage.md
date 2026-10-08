<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Provides the 'Card / Tile' Paragraphs bundle: image + title + subtitle + text + link as a Bootstrap card or image-overlay tile.

---

A one-bundle submodule of DROWL Paragraphs for Bootstrap. The `card` paragraph type composes an image, title, subtitle, body text and link into a Bootstrap `.card`. A `card--type-*` UI-Style switches between a regular vertical card and a `tile` where the body overlays the image; on tiles, `bg-*`/`backdrop-filter-*` classes are moved to the overlay body and `btn-*` classes to the card button.

It is a presentational, config-only paragraph bundle: no permissions, routes, services or config schema of its own. Enable it alongside its parent `drowl_paragraphs_bs` and the Paragraphs / Layout Paragraphs stack, then add the bundle to a Paragraphs or Layout Paragraphs field. Per-instance styling is driven by UI Styles from the Paragraphs 'Settings'.

---

- Build a grid of clickable teaser cards linking to other content.
- Create image tiles whose caption overlays the picture.
- Show a media image with title, subtitle and read-on button.
- Use zoomable / responsive image styles inside a card.
- Colour a tile overlay with Bootstrap background and backdrop-filter classes.
- Enable the submodule to make its paragraph bundle(s) available in Layout Paragraphs / Paragraphs fields.
- Use it as a component inside a `layout` / `layout_slideshow` container built with the layout_paragraphs module.
- Style each instance from the Paragraphs 'Settings' (UI Styles) without writing CSS.
- Override the shipped `paragraph--drowl-paragraphs-bs--<bundle>.html.twig` in your (Bootstrap 5 / Radix / DROWL Base) theme to adjust markup.
- Uninstall the submodule alone if the bundle is not needed, keeping the rest of the DROWL paragraph set.
