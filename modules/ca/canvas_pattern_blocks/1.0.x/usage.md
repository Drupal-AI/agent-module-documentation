Exposes a Drupal Canvas (Experience Builder) pattern as a placeable block that renders the pattern live, so the pattern stays centrally managed instead of being forked into the page when placed.

---

In Drupal Canvas, placing a pattern through the editor forks it: the pattern's component tree is copied into the host page, and later edits to the source pattern no longer propagate. Canvas Pattern Blocks solves this with a small `canvas_pattern_block` config entity — a named handle that points at one pattern. Each handle is exposed as a block plugin derivative (`canvas_pattern_block:<id>`) that appears in Canvas's "Pattern blocks" component folder. When the block is placed, it renders the referenced pattern's component tree at request time (via `Pattern::getComponentTree()->toRenderable()`), so the pattern config remains the single source of truth: edit the pattern (or re-point the handle at a different pattern) and every page that placed the block reflects the change. The block carries both the pattern's and the config entity's cache tags, so central edits and re-pointing correctly invalidate cached renders. Handles are managed at Administration › Structure › Pattern blocks (`/admin/structure/canvas-pattern-block`), gated by the "Manage pattern blocks" permission. The module ships no block-specific settings, no custom routes beyond the entity's admin routes, and no external integrations — it is a thin bridge between Canvas patterns and the block system.

---

- Reuse a single "hero" or "call-to-action" pattern across many Canvas pages without copying it into each page.
- Keep a marketing banner pattern centrally managed so one edit updates every page that placed it.
- Maintain a standard footer or promo section as a pattern and expose it as a block editors can drop in.
- Avoid pattern forking: get live-rendered patterns instead of Canvas's default copy-on-place behavior.
- Give a pattern (which has no editing UI of its own) a stable, labeled, placeable identity in the component library.
- Re-point a placed block from an old seasonal pattern to a new one in a single config edit, updating all pages at once.
- Build a small library of named "pattern blocks" (e.g. "Homepage hero", "Article CTA", "Newsletter signup") for editors to choose from.
- Let content editors place approved, design-team-owned patterns without being able to alter the underlying markup.
- Swap the entire look of a shared section site-wide by editing the referenced pattern centrally.
- A/B a section by cloning the managed pattern, adjusting it, and re-pointing the pattern block at the variant.
- Ship a set of pattern blocks as configuration so they deploy consistently across dev/stage/prod.
- Use the config dependency chain so that deleting a pattern also removes the block that referenced it (no dangling placements).
- Manage pattern blocks from Structure › Pattern blocks with a simple add/edit/delete list-builder UI.
- Restrict who can create or change pattern blocks via the "Manage pattern blocks" permission.
- Provide decoupled/headless front ends with pattern content: on decoupled sites the custom_elements converter surfaces each component of the tree as its own custom element automatically.
- Ensure page caches invalidate correctly when a shared pattern is edited, because the block merges the pattern's cache tags and contexts.
- Standardize repeated page furniture (breadcrumbable intros, disclaimers, promos) as reusable, centrally-editable blocks.
- Reduce editor error by exposing curated patterns as named blocks instead of asking editors to rebuild sections by hand.
- Give a design system's SDC-based patterns a governance layer: patterns owned centrally, placed as blocks everywhere.
