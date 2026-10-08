Entity Reference Ajax Formatter adds a configurable field formatter that renders referenced entities in a chosen view mode and can lazy-load additional items through an AJAX "Load More" link.

---

The module ships one field formatter plugin, `entity_reference_ajax_entity_view` ("Rendered Entity Ajax Formatter"), that extends core's `EntityReferenceEntityFormatter`. On top of the standard "rendered entity" behaviour it adds four settings — an initial item count (`number`), a display-only sort order (`sort`: default / random / changed asc-desc / created asc-desc), an optional AJAX "Load More" link (`load_more`), and a hard cap on how many items can be loaded (`max`). When Load More is enabled and there are more references than currently shown, the formatter appends a `use-ajax` link to a route (`/ajax_field/...`) whose controller (`EntityReferenceAjaxController::viewField`) re-renders the field from the next offset and swaps it into the page with a `ReplaceCommand`. It applies to `entity_reference` and `entity_reference_revisions` fields, is selected per view-display in *Manage display*, needs no dependencies beyond Drupal core, and provides config schema for its formatter settings.

---

- Show only the first N referenced entities on a node and let visitors click "Load More" to reveal the rest inline, without a full page reload.
- Paginate a large "Related articles" entity-reference field so the initial page render stays light.
- Lazy-load referenced media/paragraph tiles below the fold to improve perceived performance.
- Render referenced entities in a specific view mode (e.g. "Teaser" or a custom "Card" mode) while keeping AJAX incremental loading.
- Display a randomised subset of referenced entities on each page load (Sort = Random), useful for rotating promos or testimonials.
- Order referenced entities for display by most-recently-changed without changing the stored field order.
- Order referenced entities for display by creation date (newest or oldest first) for a feed-like listing.
- Cap the total number of referenceable entities a visitor can pull via Load More (Max) to bound render cost.
- Load all references incrementally by setting Max = 0 (unlimited) with a small initial `number`.
- Build an "infinite-scroll-style" reveal of referenced content using the core AJAX Load More link.
- Replace a long inline list of referenced paragraphs with a compact initial set plus on-demand expansion.
- Use it on `entity_reference_revisions` (Paragraphs) fields to progressively render heavy paragraph stacks.
- Present a curated gallery of referenced image/media entities that expands on demand.
- Keep a reference-heavy landing page fast by rendering 3 items first and deferring the remainder to AJAX.
- Offer editors the familiar "rendered entity" formatter but with per-display item limiting and sorting.
- Show referenced products/cards in a chosen view mode with a "See more" affordance.
- Configure different initial counts and sorts per view mode (default vs. teaser) for the same field.
- Provide a load-more experience without writing custom JavaScript — the module attaches `core/drupal.ajax`.
- Randomised display that avoids duplicating already-shown items across successive Load More clicks (the `printed` tracking).
- Export the formatter configuration in a view-display config entity for deployment across environments.
