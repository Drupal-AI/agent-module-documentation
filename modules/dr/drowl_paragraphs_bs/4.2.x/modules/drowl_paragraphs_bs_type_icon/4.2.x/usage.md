<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Provides the 'Icon' Paragraphs bundle: a Micon vector symbol combined with optional title, subtitle, text and link.

---

A one-bundle submodule of DROWL Paragraphs for Bootstrap. The `icon` paragraph type renders a Micon icon (`field_icon`) inside an 'icon-combo' with optional title, subtitle, body text and a wrapping link. Its preprocess sorts a large set of UI-Styles classes onto the correct wrapper: `icon-combo--`/`icon-combo__` classes to the combo, `icon__` classes to the icon, and some Bootstrap flex utilities to the combo.

It is a presentational, config-only paragraph bundle: no permissions, routes, services or config schema of its own. Enable it alongside its parent `drowl_paragraphs_bs` and the Paragraphs / Layout Paragraphs stack, then add the bundle to a Paragraphs or Layout Paragraphs field. Per-instance styling is driven by UI Styles from the Paragraphs 'Settings'.

---

- Build an icon + heading + text feature block (a 'USP' item).
- Lay out a row of linked icon tiles for services or features.
- Position the icon top/bottom/left/right of the text.
- Style the icon with Bootstrap colour, circle background, size and shape.
- Make the whole icon-combo a link to other content.
- Enable the submodule to make its paragraph bundle(s) available in Layout Paragraphs / Paragraphs fields.
- Use it as a component inside a `layout` / `layout_slideshow` container built with the layout_paragraphs module.
- Style each instance from the Paragraphs 'Settings' (UI Styles) without writing CSS.
- Override the shipped `paragraph--drowl-paragraphs-bs--<bundle>.html.twig` in your (Bootstrap 5 / Radix / DROWL Base) theme to adjust markup.
- Uninstall the submodule alone if the bundle is not needed, keeping the rest of the DROWL paragraph set.
