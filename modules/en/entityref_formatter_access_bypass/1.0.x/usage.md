Entity Reference Formatter Access Bypass adds a rendered-entity formatter that, when the current user cannot view a referenced entity, still renders it using an administrator-chosen fallback view mode instead of hiding it.

---

The module extends Drupal core's "Rendered entity" reference formatter (`EntityReferenceEntityFormatter`). Core normally omits any referenced entity the current user is not permitted to view, leaving a gap in the display. This formatter, "Rendered entity with access bypass fallback", renders accessible referenced entities in the configured view mode and renders the ones the user cannot access in a separate, required `view_mode_fallback` (default `default`). It is selected per view display on Manage display, provides no routes, permissions, services, or config UI of its own, and caps recursive entity rendering at depth 20. Because rendering the otherwise-hidden entity is the whole point of the module, it should be applied deliberately: put in the fallback view mode only the fields you intend every viewer of the reference to see, since that view mode is what limited and anonymous users are shown for entities they cannot access.

---

- Show a stripped-down teaser of otherwise-restricted referenced content
- Render referenced entities the current user cannot view in a minimal view mode
- Keep an entity reference field's layout intact even when access to a target is denied
- Avoid empty gaps where core would omit hidden referenced entities from a display
- Give anonymous users a limited preview built from members-only referenced content
- Display a "restricted" or "log in to view" style stub for gated referenced nodes
- Present a title-only fallback for referenced entities via a titles view mode
- Build catalog or listing rows that always show something for each reference
- Render accessible references normally while showing inaccessible ones as a fallback teaser
- Provide a public summary card for paywalled articles surfaced through a reference field
- Configure a dedicated fallback view mode containing only the fields meant to be public
- Curate a relationship field where partial disclosure of restricted targets is intended
- Replace the core rendered-entity formatter on a specific reference field where a fallback is wanted
- Show a placeholder rendering for unpublished referenced content in a preview context
- Keep grid or teaser components visually complete across mixed-access referenced items
- Drive an editorial "coming soon" style teaser from restricted referenced entities
- Surface non-sensitive metadata of restricted targets through a dedicated view mode
- Maintain consistent counts in a reference listing regardless of per-item access
- Offer a compact fallback rendering for cross-referenced entities in related-content blocks
- Audit which fields appear in the chosen fallback view mode before applying the formatter
