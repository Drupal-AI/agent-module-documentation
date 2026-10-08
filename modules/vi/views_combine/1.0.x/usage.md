<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views Combine joins several Views into a single listing by building one SQL `UNION` from their compiled queries, so a display can draw rows from views that have nothing structurally in common.

---

The mechanism is a genuine database `UNION`, not a PHP-level result merge: in `hook_views_post_build()`, `ViewsCombiner::combine()` takes the base view's `Select` query and each combined view's `Select` (chosen by the "Global: Views combine" field's `view_id` option), normalizes them so their column sets and positions line up — padding absent columns with `NULL`, re-aliasing every sort column to `_order_#`, and tagging each row with a bound `_view_id` placeholder — and then `$base_query->union($query)` fuses them into a single statement that replaces `build_info['query']`. This is what distinguishes it from `views_display_union`: that module unions views that already share a column shape, whereas this one does the column normalization for you, so heterogeneous views (users + comments, media + nodes, different base tables) can be merged. The trade-off is fragility — the README bills it as "for advanced site builders" with "very limited configuration validation," and only the `default` (Unformatted list) and `views_bootstrap_grid` display styles are supported out of the box (others need a subclass mixing in `CombineStyleTrait`). Exposed filters and the requested sort are captured from the base view and pushed down to every combined view, provided their exposed identifiers match (or are remapped via the field's `filter_map`/`sort_map`). Set the display cache to "Tag based (views combine)" so config and entity-list cache tags of the combined views are merged in. Depends only on core `views`; newest release is `1.0.0-alpha5` (no stable on the `1.0.x` branch).

---

- Merge two unrelated views into one listing.
- Combine content and users in one display.
- Build an activity feed from several sources.
- Union views with different base tables.
- Reuse existing views as inputs without rewriting them.
- Show mixed entity types (media + nodes) on one page.
- Present a unified dashboard listing from several views.
- Combine a curated list with a dynamic one.
- Show recent items across entity types in one feed.
- Merge results produced by different filters.
- Let a viewer include/exclude combined views via an exposed filter.
- Group combined rows by source view using the combine sort.
- Remap an exposed filter identifier between base and combined views.
- Push a base view's exposed sort down to heterogeneous combined queries.
- Add a third and fourth view to an existing combined display.
- Build a cross-section listing spanning multiple content types.
- Combine views configured by different teams into one output.
- Render each source view's own fields with the Rendered entity field.
- Keep tag-based cache invalidation across combined views.
- Aggregate several sources into a single paged listing.
