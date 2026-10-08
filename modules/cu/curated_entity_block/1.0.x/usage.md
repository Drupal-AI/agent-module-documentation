Blocks where an editor hand-picks and orders existing content entities and renders them in one chosen view mode, with the selectable pool and allowed view modes defined by a View.

---

Curated entity block turns a View into a placeable block whose contents an editor curates by hand. A site builder adds a **Curated entity block** display (a variant of the core Entity Reference display) to a View; that display's filters, sort and access define which entities are selectable, its Search fields drive the editor's autocomplete, and extra options limit the allowed view modes, bound how many entities may be picked (minimum / maximum / step), and choose how each entity is rendered. A block deriver then exposes one block per such display (mirroring core's views_block), so the same display becomes both the selection pool and a placeable block. In the block's configuration form the editor picks entities via entity autocomplete, orders them with a tabledrag table, and chooses one view mode for the whole block. At render time each picked entity's `view` access is re-checked and only allowed ones are shown. When nothing has been picked yet the block falls back to the view's own first results, so a freshly placed block (for example in Drupal Canvas) shows content immediately. With the optional custom_elements module installed, a display can render each entity as a Custom Element instead of standard HTML, which suits a Lupus Decoupled frontend. The blocks are fully schema-validatable so they qualify as Drupal Canvas components. An example View, `curated_entities_example` (published nodes, newest first), ships on install and may be altered or removed.

---

- Build a "Featured articles" block where an editor hand-picks and orders the articles shown.
- Create an "Editor's picks" spotlight rendered in a teaser view mode.
- Curate a hand-sorted list of promoted products, events or people on a landing page.
- Reuse one block type for many curation scenarios by defining multiple Views, one per scenario.
- Restrict which view modes an editor may choose (e.g. only your teaser variants) via the display's Allowed view modes option.
- Enforce a fixed count of picks, such as exactly three cards, using the entity-count minimum and maximum.
- Constrain picks to multiples of a step (e.g. 3, 6 or 9) for grid layouts, using minimum plus step.
- Let editors reorder picks by dragging rows in the block configuration form (tabledrag).
- Drive the editor's autocomplete pool from a View's filters, so only publishable/relevant entities are selectable.
- Curate any content entity type (nodes, media, taxonomy terms, users, custom entities) by basing the View on that type.
- Place a curated block per page in the Drupal Canvas page builder as a component.
- Place the same block through Block Layout / the block library like any other block.
- Show sensible default content (the view's newest results) before an editor has curated anything.
- Emit each curated entity as a Custom Element for a decoupled Nuxt frontend via Lupus Decoupled (custom_elements installed).
- Serve a curated, ordered selection as JSON components through the Lupus CE renderer in a decoupled setup.
- Keep block output cache-correct: the block adds the picked entities' and the fallback view's cache metadata.
- Start from the shipped `curated_entities_example` View and adapt its filters/sort to your needs.
- Offer editors a bounded curation UI without writing custom code, purely through Views configuration.
- Present a "most important first" ordering that is independent of the entity's own created/changed dates.
- Swap the rendered view mode for a whole block (e.g. from teaser to a card variant) without re-picking entities.
- Combine a curated block with a View's access settings so unpublished or restricted entities never leak into the pool.
