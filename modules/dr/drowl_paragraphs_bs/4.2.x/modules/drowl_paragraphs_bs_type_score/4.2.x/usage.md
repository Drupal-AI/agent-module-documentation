<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Provides the 'Score' Paragraphs bundle: numeric values rendered as an animated line / circle / semicircle gauge via progressbar.js.

---

A one-bundle submodule of DROWL Paragraphs for Bootstrap. The `score` paragraph type stores start / end / max decimals plus prefix/suffix labels and an optional Micon icon, and renders them as an animated progressbar.js gauge (line, circle or semicircle). The preprocess writes the numeric values and labels to `data-score-*` attributes and translates UI-Styles colour classes into CSS custom properties; the JS animates the bar when it scrolls into view. progressbar.js must be installed under `/libraries/progressbar.js/`.

It is a presentational, config-only paragraph bundle: no permissions, routes, services or config schema of its own. Enable it alongside its parent `drowl_paragraphs_bs` and the Paragraphs / Layout Paragraphs stack, then add the bundle to a Paragraphs or Layout Paragraphs field. Per-instance styling is driven by UI Styles from the Paragraphs 'Settings'.

---

- Show a statistic as an animated percentage gauge.
- Render a line bar, full circle or semicircle score.
- Count up from a start value to a target value on scroll.
- Add prefix/suffix labels (e.g. %, +, currency) to the value.
- Colour the bar with Bootstrap theme colours, optionally transitioning start->end colour.
- Enable the submodule to make its paragraph bundle(s) available in Layout Paragraphs / Paragraphs fields.
- Use it as a component inside a `layout` / `layout_slideshow` container built with the layout_paragraphs module.
- Style each instance from the Paragraphs 'Settings' (UI Styles) without writing CSS.
- Override the shipped `paragraph--drowl-paragraphs-bs--<bundle>.html.twig` in your (Bootstrap 5 / Radix / DROWL Base) theme to adjust markup.
- Uninstall the submodule alone if the bundle is not needed, keeping the rest of the DROWL paragraph set.
