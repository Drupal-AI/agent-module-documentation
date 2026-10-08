Chaos Tools (CTools) is a developer-focused suite of utility APIs — multi-step form wizards, plugin context/relationships, a serializable tempstore, and improved display/block handling — that other modules build on top of.

---

CTools is a toolkit module rather than an end-user feature: it ships reusable building blocks that site builders rarely see directly but that many contrib modules depend on. Its headline API is the **Form Wizard**, which turns a series of forms into a single multi-step flow (with automatic tempstore-backed state, step navigation, and an entity-form variant). It defines a **Relationship** plugin type for deriving one context from another (e.g. a node's author user), plus helpers — `ContextMapper`, `TypedDataResolver`, `AutomaticContext` — for working with typed-data contexts. A `SerializableTempstore` factory and a `_ctools_access` route access check support wizard-driven UIs. CTools also provides `DisplayVariant` plugins (block-based page variants) that underpin tools like Page Manager, and a param converter that loads objects out of the shared tempstore. Everything is exposed as services and plugins for programmatic use; there is no admin configuration screen in the base module. Three optional submodules add block improvements (`ctools_block`), entity-type masking (`ctools_entity_mask`), and Views block display enhancements (`ctools_views`). It targets Drupal 9.5, 10, and 11.

---

- Build a multi-step configuration wizard from several forms with one flow.
- Persist in-progress wizard data across steps via a serializable tempstore.
- Add previous/next step navigation and a step machine name to a custom UI.
- Wrap entity add/edit forms in a wizard using `EntityFormWizardBase`.
- Provide the plugin backbone that Page Manager and Panels build on.
- Define a Relationship plugin to derive a user context from a node context.
- Map and resolve typed-data contexts with `ContextMapper` / `TypedDataResolver`.
- Load an object from the shared tempstore in a route via the CTools param converter.
- Gate wizard routes with the `_ctools_access` tempstore access check.
- Create block-based page display variants (`BlockDisplayVariant`).
- Reuse CTools condition plugins for context-aware visibility logic.
- Lazy-load an entity as a context with `EntityLazyLoadContext`.
- Give contrib modules a stable helper API instead of reinventing wizards.
- Satisfy a dependency required by Panels, Page Manager, and Views bulk tooling.
- Provide an entity form wizard controller for admin add/edit flows.
- Dispatch wizard lifecycle events to react when steps change or finish.
- Store arbitrary serializable objects keyed per-user with expiry.
- Add an "entity field" block that renders any single field of an entity (via ctools_block).
- Let a custom entity type borrow another type's fields/display (via ctools_entity_mask).
- Expose a Views display as a configurable block with row/offset overrides (via ctools_views).
- Build derivative plugins with the CTools deriver base classes.
- Provide relationship-derived contexts to a layout or variant system.
- Standardize multi-page settings forms in a distribution or install profile.
- Reuse CTools AJAX helpers when building dynamic admin forms.
