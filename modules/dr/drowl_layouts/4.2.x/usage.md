<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
DROWL Layouts provides a set of ZURB Foundation (XY-Grid) based, configurable section layouts as Layout API plugins for Drupal's Layout Builder and Layout Paragraphs.

---

The module registers its layouts through `drowl_layouts.layouts.yml` (partly backed by PHP plugin classes in `src/Plugin/Layout/`) so they appear alongside core layouts wherever a section layout is chosen. It offers column layouts (1–6 columns, in "stacked" and "unstacked" Foundation-grid variants), page/component layouts (Node Detail Default, Card/Tile, Media Object) and a CSS-grid based Dynamic Content Grid. Configurable layouts add per-section options via a shared settings trait: section width (page vs. viewport), horizontal + vertical cell alignment (Foundation `.align-*` classes), preset column-width ratios, collapsing grid gutters per device size, and a free-text "extra classes" field; the Dynamic Content Grid adds min/max cell width and gutter/behaviour options. All Foundation classes live in the Twig templates (`templates/layouts/`), so the markup can be re-themed for Bootstrap or another framework. It depends on core Layout Discovery + Layout Builder and on Twig Real Content (used to detect genuinely-empty regions so preview markup renders realistically). A single admin permission gates an otherwise-empty settings page; there is no stored module config object. Foundation being end-of-life, the maintainers point new sites to the successor project DROWL Layouts BS (Bootstrap).

---

- Add responsive multi-column sections (1–6 columns) to a node/entity via Layout Builder.
- Choose between "stacked" (each row wrapped with top/bottom regions) and "unstacked" (bare column) variants of a column layout.
- Build two-column sections with 50/50, 66/33 or 33/66 width ratios.
- Build three-column sections with 33/33/33, 50/25/25, 25/25/50 or 25/50/25 ratios.
- Lay out 4-, 5- or 6-column sections with fixed or automatic cell widths.
- Make one column of a two-column section span the full viewport width (first- or last-column viewport width).
- Set a section to page width, viewport width, or viewport-width background only.
- Align a section's cells vertically (top / middle / bottom / stretch).
- Align a section's cells horizontally (left / center / right / justify / spaced).
- Collapse the grid gutter for specific device sizes (small / medium / large).
- Add arbitrary extra CSS classes to a layout section.
- Present content as a "Card" (image above content) or "Tile" (image as background) component layout.
- Present content as a "Media Object" (media on the left, content on the right) layout.
- Use the "Node Detail Default" page layout for full node displays (title, subline, top, main + aside, full-width main, bottom regions).
- Build a fluid, auto-flowing masonry-style grid with the Dynamic Content Grid (min/max cell width in px, gutter size, auto-fit/auto-fill behaviour).
- Use the layouts inside Layout Paragraphs to let editors nest configurable Foundation sections in paragraph fields.
- Attach realistic per-paragraph preview styling by defining a `YOURTHEME/drowl_layouts_layout_paragraphs_additions` library in your default theme (auto-detected and attached).
- Re-theme the layouts for Bootstrap or a custom framework by overriding the Twig templates (all grid classes live there).
- Restrict who may reach the DROWL Layouts settings page with the "Access DROWL Layouts settings" permission.
- Audit which nodes carry per-entity Layout Builder overrides via the bundled (disabled by default) "Layout Builder Overrides" view.
