<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
EBT Columns / Container adds an "EBT Columns / Container" block_content type that lays its child blocks out in a 1-6 column CSS grid, with the shared EBT design settings applied.

---

Part of the Extra Block Types (EBT) family, this module ships a single `block_content` bundle,
`ebt_columns`, whose main field `field_ebt_columns_blocks` is a multi-value Block Field: each value
is any Drupal block plugin, and they are rendered side by side in a CSS-grid container. A custom
field widget (`ebt_settings_columns`, extending ebt_core's default settings widget) adds a layout
selector (one to six columns) and per-layout column-width presets (e.g. 50/50, 33/67, 25/50/25,
40/20/20/20); those choices become `column-N` / `columns-X-Y` classes that the module's stylesheet
turns into `grid-template-columns`. The bundle also carries a `body` text field and the shared
`field_ebt_settings` (from ebt_core) that provides the design layer — margins, padding, borders,
background colour/image/video, edge-to-edge and container width. There is no module settings form,
no permissions, no services and no Drush; everything is configured per block instance. Blocks can
be placed in any region or through Layout Builder, and the container is equally useful for arranging
ordinary core blocks (menus in a footer, for example) into columns.

---

- Add a "Columns / Container" custom block that arranges nested blocks in a grid.
- Build a two-column section with a 50/50, 33/67, 67/33, 25/75 or 75/25 split.
- Build a three-column section (25/50/25, 33/34/33, 25/25/50 or 50/25/25).
- Build a four-column section (25/25/25/25, 40/20/20/20 or 20/20/20/40).
- Build a five- or six-column grid of equal-width columns.
- Use the "One column (Container)" layout as a styled wrapper around a single block.
- Nest any block plugin (menus, views, custom content blocks, forms, etc.) inside a column.
- Lay out a site footer with several menu blocks side by side.
- Place the columns block directly in a theme region via Block layout.
- Add the columns block as an inline block in Layout Builder.
- Apply EBT design options (margin, padding, border, border colour/style/radius) to the container.
- Set a background colour, image (with cover/parallax) or YouTube video on the container.
- Make the container edge-to-edge or cap it at a chosen max container width.
- Give each column a consistent 15px row/column gap without writing CSS.
- Reorder or reweight the blocks inside a column from the block edit form.
- Add an optional body text field above the nested blocks.
- Compose reusable, revisionable page sections as content blocks.
- Combine several EBT block types (e.g. a hero over a two-column grid) on one page.
- Keep column markup responsive by relying on the module's grid CSS.
- Standardise multi-column layouts across a site without a page builder license.
- Let editors pick column counts and widths from a form instead of hand-editing classes.
