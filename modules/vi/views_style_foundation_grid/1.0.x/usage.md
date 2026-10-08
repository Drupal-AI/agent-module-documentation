<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Foundation Grid Views Style

A Views **style plugin** (`id: views_style_foundation_grid`) that lays out view rows in a
[ZURB Foundation](https://get.foundation/) XY grid. You control the number of grid columns a
cell spans at small / medium / large breakpoints, gutter type (margin or padding) and
direction, orientation, grouping-title markup, and custom grid/cell classes. Depends on the
`foundation_sites` module (which supplies the Foundation CSS framework).

---

## Summary

`FoundationGrid` extends `StylePluginBase` with `usesRowPlugin = TRUE`. `defineOptions()`
declares settings for grouping title type/classes, orientation, horizontal/vertical gutters,
gutter type, custom grid classes, and per-breakpoint cell columns (`cells_small` default 12,
`cells_medium` 6, `cells_large` 4) plus custom cell classes. `buildOptionsForm()` renders
selects/checkboxes/textfields for all of these. `getCustomCellClass()` tokenizes the custom
cell class string (via `tokenizeValue`), strips tags, and runs each class through
`Html::cleanCssIdentifier()` before output, so per-row field tokens can drive cell classes
safely. The `template_preprocess_views_view_foundation_grid()` preprocess builds Attribute
objects for the grid and each row and merges in row + tokenized cell classes; the
`views-view-foundation-grid.html.twig` template emits the markup. Config schema is provided.

Configure entirely per view: set **Format → Foundation Grid** and adjust the settings.

---

## Use cases

- Render a card grid that reflows to 1 / 2 / 3 columns across small, medium, large screens.
- Build a responsive image or teaser gallery using Foundation's XY grid classes.
- Lay out a product or portfolio listing without hand-writing grid markup.
- Choose margin vs padding gutters to match a Foundation-based theme's spacing.
- Turn gutters on or off horizontally and/or vertically per view.
- Switch orientation between horizontal (row-major) and vertical placement of items.
- Add `grid-frame` or other Foundation container classes via the custom grid classes field.
- Drive per-row cell classes from field values using replacement-pattern tokens.
- Set grouping title markup (h1–h6, span, div, strong, em) with extra custom classes.
- Use "Auto" cells so items share remaining space equally on a breakpoint.
- Use "None" cells to inherit sizing from a smaller breakpoint.
- Create a responsive dashboard of blocks/views arranged on the Foundation grid.
- Combine with view grouping to render titled sections each in their own grid.
- Theme output by overriding `views-view-foundation-grid.html.twig`.
- Keep markup consistent with an existing Foundation front-end design system.
