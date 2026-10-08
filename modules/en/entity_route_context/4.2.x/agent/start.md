# Entity Route Context — agent index

A developer-only utility: a plugin **context provider** for "the entity that owns the current route"
(any entity type, or a specific one) plus a route↔entity-type helper service. No UI, no config
(`configure` null), no permissions, no entities, no Drush. Requires PHP 8.3+, Drupal ≥ 11.1.

- **The two services — the context provider (`canonical_entity` / `canonical_entity:{type}` contexts)
  and the route helper (route → entity type / link template map) — with their public methods** →
  [api/services.md](api/services.md)

Key facts:
- `context_provider` service `entity_route_context.entity_route_context`
  (`ContextProvider\EntityRouteContext`) — supplies contexts to blocks, Layout Builder, DS, conditions.
- `entity_route_context.route_helper` (`EntityRouteContextRouteHelper`, public) — implements
  `EntityRouteContextRouteHelperInterface`.
- Route→entity map is built from entity link templates vs registered routes, cached permanently, tag
  `entity_types` + `routes`.
