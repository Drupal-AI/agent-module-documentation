A developer utility that provides a plugin **context** for the entity whose link template owns the current route, plus a service for mapping routes to entity types by link template — a generic, entity-type-agnostic equivalent of core's `node.node_route_context`.

---

The module exposes two things and nothing else — no UI, no config, no permissions, no entities. First, a `context_provider` service (`EntityRouteContext`) offers contexts to plugins (blocks, Layout Builder, Data Set / DS fields, conditions): a generic `canonical_entity` context ("Entity from route", which matches any entity type) and one `canonical_entity:{entity_type_id}` context per entity type ("@label from route"). At runtime it inspects the current route match, and if the route is an entity link template (canonical, edit-form, delete-form, etc.), it resolves the entity parameter of the matching type and hands it to the plugin as context (with a `route` cache context). Second, the `entity_route_context.route_helper` service (`EntityRouteContextRouteHelper`) builds and permanently caches a map of route name → `[entityTypeId, linkTemplateKey]` by walking every entity type's link templates and matching their paths against all registered routes; it answers "which entity type owns this route?", "what routes does this entity type have?", and "what is the entity type + link template for this route match?". The cache is tagged `entity_types` and `routes` so it rebuilds when either changes. Requires PHP 8.3+ and Drupal ≥ 11.1. Use it when you want a block or field that reacts to "the entity on this page" without hard-coding node, or that should only respond to a specific entity type you pick as a site builder.

---

- Place a block that renders data from whatever entity's page you are on, for any entity type.
- Restrict a block to appear only on a specific entity type's routes (e.g. only `taxonomy_term`).
- Build a Layout Builder / DS field that consumes the "entity from route" context generically.
- Get the current entity in a plugin without writing an entity-type-specific route context.
- React to canonical, edit-form, or delete-form routes of an entity uniformly.
- Determine which entity type "owns" an arbitrary route name in custom code.
- List all route names for a given entity type keyed by link template.
- Map a route match back to its entity type and link template key.
- Provide a `canonical_entity` context that matches both `entity` and `entity:{type}` requirements.
- Add a contextual block on media, user, or custom-entity pages the same way you would on nodes.
- Avoid duplicating `node_route_context` logic for every custom entity type.
- Drive conditions/visibility plugins from the route's entity type.
- Cache the route→entity-type map site-wide (permanent, invalidated on entity type or route changes).
- Let a site builder choose a specific entity type for a plugin that otherwise takes any entity.
- Support decoupled/utility modules that need "the current entity" abstractly.
- Feed the current route entity into tokens, breadcrumbs, or metatag logic in custom code.
- Detect whether the current page is an entity link-template route at all.
- Resolve the first route parameter cast to the expected entity type for the current route.
