<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
DROWL Layouts for Bootstrap provides DROWL's default set of responsive Bootstrap-5-grid section layouts as Layout Discovery plugins for Layout Builder and Layout Paragraphs.

---

The module registers a family of layout plugins in `drowl_layouts_bs.layouts.yml`: one- to six-column layouts (plain and "stacked" variants with `top`/`bottom` regions), two component layouts (Card and Media object), a `Node detail default` page layout, a multi-row `ROW Layout`, and a CSS-grid `Dynamic Content Grid`. Most layouts use `\Drupal\layout_options\Plugin\Layout\LayoutOptions` as their plugin class, so their per-section option forms come from the Layout Options module and the option catalog defined in `drowl_layouts_bs.layout_options.yml` (Bootstrap container width, `g-*`/`gx-*`/`gy-*` gutters, flex alignment/justification, `row-cols-*`, per-region `col-*`/`col-sm-*`…`col-xxl-*` widths, and free-text custom classes). All markup is Twig-only, built on a shared base template `drowl-layout-grid.html.twig`; there are no PHP classes, routes or services. Bootstrap CSS classes are emitted through Drupal's `Attribute` object (`addClass`), and Twig Real Content (`is real_content`) is used so empty regions are not rendered while still forcing empty regions to show inside the Layout Paragraphs builder. It depends on core Layout Discovery, Twig Real Content and Layout Options, and is intended to run under a Bootstrap 5 theme such as Radix.

---

- Build responsive multi-column page sections in Layout Builder using the `[DROWL] Columns: 1`–`6` layouts.
- Choose between equal-height columns that share one row (`Two/Three/… column`) or stacked variants that add dedicated `top` and `bottom` full-width regions.
- Lay out fields or blocks in Layout Paragraphs sections using the same Bootstrap grid layouts (the module adds admin CSS to the Layout Paragraphs builder UI).
- Create card teasers with the `Card (image above content)` component layout, switching between "Card" and "Tile" (content overlays the image) via the `card_style` option.
- Build "media on the left, text on the right" blocks with the `Media object` component layout, optionally stacking it vertically on small screens.
- Apply a ready-made node page layout (title, subline, top, main + aside, full-width main, bottom regions) with the `Node detail default` layout.
- Set each column's responsive width per breakpoint using the `col_xs`…`col_xxl` region options (`col-12`, `col-md-6`, etc.).
- Control the gap between columns with Bootstrap gutter classes (`gutters`, `gutters_horizontal`, `gutters_vertical` → `g-*`/`gx-*`/`gy-*`).
- Vertically align columns within a row with `flex_align_items` / per-region `flex_align_self`, or distribute them with `flex_justify_content`.
- Constrain a section to page width, run it full-viewport, or keep a full-width background with limited-width content using the `container_width` option (`page-width` / `viewport-width` / `viewport-width-cp`).
- Narrow or widen a limited-width container with `container_max_width` (`container--width-narrow` / `container--width-wide`).
- Produce many equal columns that wrap across multiple rows without extra sections using the `ROW Layout` and its responsive `row-cols-*` options.
- Render a card/tile grid that auto-fills available width with the `Dynamic Content Grid` layout (CSS Grid, loads the `dynamic_grid` library).
- Add arbitrary CSS classes to any layout or region with the `Custom classes` option for theme-specific styling.
- Pair with Layout Paragraphs and DROWL Paragraphs for Bootstrap to give editors a component-based page builder.
- Extend the Layout Paragraphs builder styling from your theme by declaring a `THEME/drowl_layouts_bs_layout_paragraphs_additions` library (auto-attached via `hook_library_info_alter`).
- Review which nodes have per-entity Layout Builder overrides via the optional (disabled by default) `drowl_layout_builder_overrides` view at `/admin/content/layout-builder-overrides`.
- Migrate a site from the Foundation-based DROWL Layouts to Bootstrap layouts while keeping the same DROWL region/authoring conventions.
- Restrict who may reach DROWL Layouts settings via the `access drowl_layouts_bs settings` permission (declared for use by companion tooling).
