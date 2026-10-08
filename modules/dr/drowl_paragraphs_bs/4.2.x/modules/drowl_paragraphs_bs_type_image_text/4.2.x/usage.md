<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Provides the 'Image in Text' Paragraphs bundle: a floated image that body text wraps around, with optional CSS shape.

---

A one-bundle submodule of DROWL Paragraphs for Bootstrap. The `image_text` paragraph type floats an image left or right (`float-start`/`float-end` UI-Style) and lets body text wrap around it. An optional `field_image_clip_path` value adds a per-paragraph CSS clip-path / shape-outside so text can wrap a non-rectangular shape.

It is a presentational, config-only paragraph bundle: no permissions, routes, services or config schema of its own. Enable it alongside its parent `drowl_paragraphs_bs` and the Paragraphs / Layout Paragraphs stack, then add the bundle to a Paragraphs or Layout Paragraphs field. Per-instance styling is driven by UI Styles from the Paragraphs 'Settings'.

---

- Wrap article text around a left- or right-floated image.
- Create a magazine-style image-in-text block.
- Apply a CSS clip-path shape so text follows a non-rectangular image edge.
- Reuse responsive image styles and zoom inside a text block.
- Combine a media image and rich text in a single paragraph.
- Enable the submodule to make its paragraph bundle(s) available in Layout Paragraphs / Paragraphs fields.
- Use it as a component inside a `layout` / `layout_slideshow` container built with the layout_paragraphs module.
- Style each instance from the Paragraphs 'Settings' (UI Styles) without writing CSS.
- Override the shipped `paragraph--drowl-paragraphs-bs--<bundle>.html.twig` in your (Bootstrap 5 / Radix / DROWL Base) theme to adjust markup.
- Uninstall the submodule alone if the bundle is not needed, keeping the rest of the DROWL paragraph set.
