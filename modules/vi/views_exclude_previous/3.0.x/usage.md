<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views exclude previous prevents the same entity from appearing twice on a page: it tracks every entity rendered during a page request and provides a Views contextual-filter default that excludes those already-rendered entities from subsequent view results.

---

The module keeps an in-request registry via the `views_exclude_previous.render_history` service (`EntityRenderHistory`), an in-memory map of rendered entity ids keyed by entity type. It records entities by implementing `hook_entity_build_defaults_alter()` — chosen deliberately because that hook fires even when an entity comes from the render cache — calling `$render_history->add($entity)` for each built entity. It then supplies a Views **argument default** plugin `views_exclude_default_render_history` ("Previously rendered entities") that, in `getArgument()`, returns the `+`-joined list of ids already rendered for a configured entity type (or the literal `all` when none, effectively a no-op). You wire it up on a contextual filter for the entity id, set it to "Provide default value → Previously rendered entities", pick the entity type to track, and — the easily-missed step — tick the **Exclude** checkbox under "More" so the argument subtracts rather than includes those ids. There is no admin settings page, no permissions, and no config of its own; everything is configured on the view. A reusable `EntityRenderHistoryTrait` gives other code setter-injection access to the service. Version 3.x is a complete rewrite with no upgrade path from 2.x.

---

- Stop a "related articles" block from re-showing the article already displayed on the page.
- Prevent a featured/promoted view and a main listing on the same page from duplicating nodes.
- Exclude the current node being viewed from an "in this section" sidebar view.
- De-duplicate entities across multiple views rendered on one page.
- Hide items already shown in a hero/slider from the grid below it.
- Keep a "you might also like" view from repeating cards shown earlier on the page.
- Exclude already-rendered media/taxonomy/user entities (any entity type) from a later view.
- Ensure paginated or stacked views on a landing page never repeat the same content.
- Track the current page's entity and exclude it via the "Content" entity type option.
- Build magazine-style pages where each section shows fresh, non-overlapping content.
- Avoid showing a node in a "more from this author" list when it's the node being read.
- Deduplicate across a Layout Builder page composed of several content-listing blocks.
- Use the render-history service programmatically to record entities you rendered manually.
- Read the list of already-rendered entity ids for an entity type in custom code.
- Exclude previously rendered entities even when they were served from render cache.
- Combine with contextual-filter relationships to check the current page's entity.
- Keep promoted content unique across a homepage's multiple curated views.
