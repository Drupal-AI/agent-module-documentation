<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Provides the simplest 'Text' Paragraphs bundle: a single formatted rich-text body field.

---

A one-bundle submodule of DROWL Paragraphs for Bootstrap. The `text` paragraph type is the minimal building block: one formatted text field (`field_text`) rendered through the DROWL Paragraphs for Bootstrap base template. It ships no `.module`, no library, no UI Styles and no template of its own - only the paragraphs_type, field and display config.

It is a presentational, config-only paragraph bundle: no permissions, routes, services or config schema of its own. Enable it alongside its parent `drowl_paragraphs_bs` and the Paragraphs / Layout Paragraphs stack, then add the bundle to a Paragraphs or Layout Paragraphs field. Per-instance styling is driven by UI Styles from the Paragraphs 'Settings'.

---

- Add a block of rich (WYSIWYG) text to a page.
- Use as the default text component inside layout / tabs / card containers.
- Provide editors a plain formatted-text paragraph with no extra styling options.
- Combine multiple text paragraphs to structure long-form content.
- Serve as the fallback content type in a Layout Paragraphs section.
- Enable the submodule to make its paragraph bundle(s) available in Layout Paragraphs / Paragraphs fields.
- Use it as a component inside a `layout` / `layout_slideshow` container built with the layout_paragraphs module.
- Style each instance from the Paragraphs 'Settings' (UI Styles) without writing CSS.
- Override the shipped `paragraph--drowl-paragraphs-bs--<bundle>.html.twig` in your (Bootstrap 5 / Radix / DROWL Base) theme to adjust markup.
- Uninstall the submodule alone if the bundle is not needed, keeping the rest of the DROWL paragraph set.
