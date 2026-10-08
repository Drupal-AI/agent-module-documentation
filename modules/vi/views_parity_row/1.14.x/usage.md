<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views Parity Row adds a Views "entity (alternate)" row plugin that renders most rows with one entity view mode but switches to a second view mode on a repeating cadence (e.g. every 3rd row) or on specific row positions.

---

The module provides a derivative-based Views **row plugin** (`views_parity_row_entity:<entity_type>`) generated for every entity type that has Views integration and a view builder. It extends core's Entity row plugin, so a view of nodes (or any entity) can be configured with a primary view mode plus an "alternate" view mode. Two modes of alternation are offered on the row options form: (1) **cadence** — enable "Alternate every X rows", set a `frequency`, optional `start` and `end` row bounds, and an alternate `view_mode`; rows at `start` and every `frequency` rows thereafter render in the alternate view mode. (2) **per-row** — enable "Alternate per row" and pick a specific view mode for each of rows 1–20 individually. The actual rendering happens in a set of language renderers (`RendererBase::preRender()`) that decide, per result row, which view mode to pass to the entity view builder, accounting for the current pager page so the cadence continues across pages. All configuration lives inside the view's display `row` options (config schema `views.row.views_parity_row_entity:*`); there is no admin settings page, permission, or Drush command. Language handling mirrors core (current/default/translation/configurable-language renderers).

---

- Render a grid of teaser cards but make every 3rd card a larger "featured" view mode.
- Build a magazine-style listing where the first row uses a hero view mode and the rest use teasers.
- Alternate between two card designs to create visual rhythm in a long list.
- Highlight every 5th article in a news feed with an expanded view mode.
- Show a promoted layout on row 1 and standard layout on all following rows (start=0, frequency=large).
- Insert a wide "call to action" style row at fixed intervals within an entity listing.
- Give the first N rows a prominent view mode and switch to compact after row N (using start/end bounds).
- Create a zebra/parity effect using two genuinely different view modes rather than just CSS classes.
- Alternate view modes for products in a Commerce catalog to break up a uniform grid.
- Display the top result of a view in a "spotlight" view mode and the rest as list items.
- Assign a distinct view mode to each of the first 20 rows for a curated homepage block.
- Mix a "with image" and "text only" view mode every other row to vary media density.
- Feature editorial picks at rows 1, 4, 7 … via the every-X-rows cadence.
- Continue the alternating cadence correctly across paginated pages (the plugin accounts for the pager offset).
- Apply alternate view modes to users, taxonomy terms, or media — any entity type with a view builder.
- Emphasize sponsored entries periodically in an otherwise uniform feed.
- Produce a "featured + standard" pattern without writing a custom row template or preprocess.
- Vary card size in a masonry layout by switching view modes on a cadence.
- Use per-row mode to hand-pick the exact view mode for each slot of a small, fixed-size list.
- Build an alternating two-column-vs-full-width entity list purely through view modes.
- Prototype different content densities in a listing quickly by toggling the alternate view mode.
- Keep the same view result set but present some rows with more fields via a richer view mode.
