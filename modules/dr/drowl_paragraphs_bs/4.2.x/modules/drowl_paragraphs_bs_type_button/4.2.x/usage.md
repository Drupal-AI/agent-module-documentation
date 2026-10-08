<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Provides the 'Button' Paragraphs bundle: a single link rendered as a Bootstrap call-to-action button.

---

A one-bundle submodule of DROWL Paragraphs for Bootstrap. The `button` paragraph type wraps one link field (`field_link`) and renders it as an `<a class="btn ...">`. The Micon link formatter supplies an optional icon whose position (before / after / icon only) comes from a `data-icon-position` link attribute. UI-Styles `btn-*`/`text-*` classes (and `btn__`-prefixed extras) are moved onto the button element instead of the paragraph wrapper.

It is a presentational, config-only paragraph bundle: no permissions, routes, services or config schema of its own. Enable it alongside its parent `drowl_paragraphs_bs` and the Paragraphs / Layout Paragraphs stack, then add the bundle to a Paragraphs or Layout Paragraphs field. Per-instance styling is driven by UI Styles from the Paragraphs 'Settings'.

---

- Add a primary/secondary CTA button that links to internal or external content.
- Render a link with a leading or trailing Micon icon, or an icon-only button.
- Apply Bootstrap button colours/outlines through `btn-*` UI Styles.
- Attach extra classes to the button element with the `btn__` prefix.
- Set link attributes (target, rel, data-*) via the link_attributes / Micon widgets.
- Enable the submodule to make its paragraph bundle(s) available in Layout Paragraphs / Paragraphs fields.
- Use it as a component inside a `layout` / `layout_slideshow` container built with the layout_paragraphs module.
- Style each instance from the Paragraphs 'Settings' (UI Styles) without writing CSS.
- Override the shipped `paragraph--drowl-paragraphs-bs--<bundle>.html.twig` in your (Bootstrap 5 / Radix / DROWL Base) theme to adjust markup.
- Uninstall the submodule alone if the bundle is not needed, keeping the rest of the DROWL paragraph set.
