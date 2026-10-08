<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Provides the 'Image' and 'Vector Image' Paragraphs bundles for responsive raster and SVG media.

---

A submodule of DROWL Paragraphs for Bootstrap shipping two bundles. `image` renders a responsive, optionally zoomable and linked raster image through the base `inc/flexible_image.html.twig` (drowl_media). `vector_image` renders an SVG media reference, optionally wrapped in a link. Bootstrap border/rounding UI-Styles (`img-wrapper__*`, `img-*`, `ratio*`) are moved onto the image wrapper by the preprocess.

It is a presentational, config-only paragraph bundle: no permissions, routes, services or config schema of its own. Enable it alongside its parent `drowl_paragraphs_bs` and the Paragraphs / Layout Paragraphs stack, then add the bundle to a Paragraphs or Layout Paragraphs field. Per-instance styling is driven by UI Styles from the Paragraphs 'Settings'.

---

- Place a single responsive image with a chosen image style.
- Make an image zoomable (Photoswipe) or clickable to another page.
- Embed an SVG (vector) image that scales sharply on any device.
- Add Bootstrap borders, colours, opacity and rounded corners to an image.
- Constrain an image with a Bootstrap ratio helper.
- Enable the submodule to make its paragraph bundle(s) available in Layout Paragraphs / Paragraphs fields.
- Use it as a component inside a `layout` / `layout_slideshow` container built with the layout_paragraphs module.
- Style each instance from the Paragraphs 'Settings' (UI Styles) without writing CSS.
- Override the shipped `paragraph--drowl-paragraphs-bs--<bundle>.html.twig` in your (Bootstrap 5 / Radix / DROWL Base) theme to adjust markup.
- Uninstall the submodule alone if the bundle is not needed, keeping the rest of the DROWL paragraph set.
