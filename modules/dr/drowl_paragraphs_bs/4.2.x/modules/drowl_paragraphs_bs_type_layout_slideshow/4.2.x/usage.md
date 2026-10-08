<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Provides the 'Layout: Slideshow' Paragraphs container and Slick-based 1-6 column / custom slideshow layouts.

---

A submodule of DROWL Paragraphs for Bootstrap. The `layout_slideshow` paragraph type is a layout_paragraphs container whose child paragraphs are presented as a responsive Slick carousel. It ships seven layout plugins (1-6 columns plus a custom one) via the layout_options module, and the preprocess builds Slick settings (autoplay, arrows, dots, infinite, center mode, slides-per-breakpoint) as a `data-slick` JSON attribute using the global DROWL Paragraphs breakpoint config.

It is a presentational, config-only paragraph bundle: no permissions, routes, services or config schema of its own. Enable it alongside its parent `drowl_paragraphs_bs` and the Paragraphs / Layout Paragraphs stack, then add the bundle to a Paragraphs or Layout Paragraphs field. Per-instance styling is driven by UI Styles from the Paragraphs 'Settings'.

---

- Turn a Layout Paragraphs section's children into a carousel.
- Choose how many slides show on small / medium / large screens (1-6 or custom).
- Toggle autoplay, arrows, dots, infinite loop and center mode per slideshow.
- Reuse the site's DROWL breakpoint configuration for responsive slide counts.
- Show a product / testimonial / logo carousel built from paragraphs.
- Enable the submodule to make its paragraph bundle(s) available in Layout Paragraphs / Paragraphs fields.
- Use it as a component inside a `layout` / `layout_slideshow` container built with the layout_paragraphs module.
- Style each instance from the Paragraphs 'Settings' (UI Styles) without writing CSS.
- Override the shipped `paragraph--drowl-paragraphs-bs--<bundle>.html.twig` in your (Bootstrap 5 / Radix / DROWL Base) theme to adjust markup.
- Uninstall the submodule alone if the bundle is not needed, keeping the rest of the DROWL paragraph set.
