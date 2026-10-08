<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Provides the 'Countdown' Paragraphs bundle: a target date rendered as an animated FlipDown countdown.

---

A one-bundle submodule of DROWL Paragraphs for Bootstrap. The `countdown` paragraph type stores a target datetime (`field_date`) and renders a `.countdown` div with `data-target-date` (unix timestamp) and `data-countdown-theme`; the shipped JS initialises the third-party FlipDown library against it, hiding a formatted-date no-JS fallback. FlipDown must be installed under `/libraries/flipdown/`; a `hook_requirements()` check flags it when missing.

It is a presentational, config-only paragraph bundle: no permissions, routes, services or config schema of its own. Enable it alongside its parent `drowl_paragraphs_bs` and the Paragraphs / Layout Paragraphs stack, then add the bundle to a Paragraphs or Layout Paragraphs field. Per-instance styling is driven by UI Styles from the Paragraphs 'Settings'.

---

- Count down to a product launch, event start or sale end.
- Show a flip-style animated timer to a target date/time.
- Provide a readable fallback date when JavaScript is unavailable.
- Switch the FlipDown colour theme via the color-scheme field.
- Embed a deadline timer inside a Layout Paragraphs section.
- Enable the submodule to make its paragraph bundle(s) available in Layout Paragraphs / Paragraphs fields.
- Use it as a component inside a `layout` / `layout_slideshow` container built with the layout_paragraphs module.
- Style each instance from the Paragraphs 'Settings' (UI Styles) without writing CSS.
- Override the shipped `paragraph--drowl-paragraphs-bs--<bundle>.html.twig` in your (Bootstrap 5 / Radix / DROWL Base) theme to adjust markup.
- Uninstall the submodule alone if the bundle is not needed, keeping the rest of the DROWL paragraph set.
