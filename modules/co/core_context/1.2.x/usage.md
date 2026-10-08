Core Context lets you attach ctools-style context values to any entity — either in a hidden `context` field on fieldable entities or in the third-party settings of config entities — and exposes them as runtime contexts (via context providers) at canonical entity routes and in Layout Builder, so context-aware plugins (blocks, layouts, Page Manager variants) can consume them.

---

The module registers a `context` entity handler on every entity type (`hook_entity_type_alter`): fieldable entities get a `FieldContextHandler`, and config entities implementing `ThirdPartySettingsInterface` get a `SettingsContextHandler`. `FieldContextHandler::getContexts()` reads the first field of the module's `context` field type on the entity (a `no_ui`, unlimited-cardinality field storing `id`, `type`, `label`, `description`, and a serialized `value`); `SettingsContextHandler::getContexts()` reads the entity's `core_context`/`contexts` third-party setting (schema `core_context.sequence`, a sequence of `ctools.context` maps). Both hand the stored configurations to `ctools.context_mapper->getContextValues()` to build `\Drupal\Core\Plugin\Context\Context` (or `EntityLazyLoadContext` for `entity:*` types) objects, with cache metadata from the host entity. Those contexts are surfaced through context provider services: a `Generic` provider (service `core_context`, which service-collects everything tagged `core_context.context_provider`), a `CanonicalEntity` provider that extracts contexts when you view an entity's canonical route (a `RouteSubscriber` polyfills `_core_context_entity: node.full` onto `entity.node.canonical` so nodes work), and — when Layout Builder is installed — a `LayoutBuilder` provider plus an event subscriber that injects the entity's contexts into context-aware section components at render time. The result is a low-level, developer-facing plumbing module: it has no admin UI (`configure` is null), no permissions, and no Drush; you attach contexts programmatically or via config and read them back through the entity's `context` handler or the context repository.

---

- Attach an arbitrary context value (string, integer, entity reference, …) to a specific entity.
- Store per-bundle contexts in a content type's third-party settings for Layout Builder to consume.
- Expose an entity's own contexts to blocks placed in its Layout Builder layout.
- Feed contexts into context-aware block plugins so they render differently per entity.
- Provide contexts to Page Manager variants based on the canonical entity being viewed.
- Pair reusable layouts (Layout Library) with layout-specific context values.
- Read all contexts attached to any entity via its `context` entity handler (`getContexts()`).
- Add cache-aware contexts that automatically inherit the host entity's cacheability.
- Supply an `entity:node` context that lazy-loads the referenced node only when used.
- Make the current node available as a context at its canonical `/node/{nid}` route.
- Register a custom context provider by tagging a service `core_context.context_provider`.
- Aggregate several context providers under the single `core_context` provider service.
- Give config entities (view displays, content types, menus) attached contexts via third-party settings.
- Store contexts on a fieldable entity through the hidden `context` field type.
- Build modules that need entity-scoped runtime contexts without wiring up Page Manager fully.
- Pass a computed value from an entity into a context-aware condition plugin.
- Provide contexts to layout sections when editing a default layout vs an entity override.
- Extend an entity's available contexts for downstream context consumers generically.
- Bridge ctools context definitions into core's context provider system.
- Prototype context-driven rendering before adopting a heavier page-building stack.
- Inject a site- or bundle-specific value that many blocks can read as a shared context.
- Keep context configuration in exportable config (third-party settings / field values).
