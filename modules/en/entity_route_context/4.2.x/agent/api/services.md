# Services

Two services, both `public`. Autowired via `entity_route_context.services.yml`.

## `entity_route_context.route_helper` — `EntityRouteContextRouteHelper`

Implements `EntityRouteContextRouteHelperInterface` (type-hint or fetch by that interface). Answers
questions about which entity type / link template owns a route. Builds a map once by iterating every
entity type's `getLinkTemplates()` and matching each template path against every route path from the
route provider; stores it in `cache.discovery` under `entity_route_context:link_template_map`
(permanent, tags `entity_types`, `routes`).

Methods:

- `getAllRouteNames(): array<string,string>` — every entity route name → entity type id.
- `getRouteNames(string $entityTypeId): array<string,string>` — for one entity type, link template
  key → route name (e.g. `['canonical' => 'entity.node.canonical', 'edit-form' => '…']`).
- `getEntityTypeId(string $routeName): ?string` — the entity type id owning `$routeName`, or NULL.
- `getLinkTemplateByRouteMatch(RouteMatchInterface $routeMatch): ?array{0:string,1:string}` —
  `[entityTypeId, linkTemplateKey]` for the matched route, or NULL if it is not an entity template.

Example:

```php
$helper = \Drupal::service('entity_route_context.route_helper');
$type = $helper->getEntityTypeId('entity.node.edit_form');   // 'node'
[$etype, $tpl] = $helper->getLinkTemplateByRouteMatch(\Drupal::routeMatch()) ?? [null, null];
```

## `entity_route_context.entity_route_context` — `ContextProvider\EntityRouteContext`

A core `context_provider` (tagged service). You normally consume its contexts declaratively from a
plugin's `context_definitions`, not by calling it. It provides:

- **`canonical_entity`** — a generic `entity` context labelled "Entity from route". Because its data
  type is the bare `entity`, it satisfies both an `entity` requirement and a specific `entity:{type}`
  requirement (via `ContextDefinition::dataTypeMatches`). Present only when the current route resolves
  to an entity.
- **`canonical_entity:{entity_type_id}`** — one per entity type, labelled "@label from route". Always
  offered (in `getAvailableContexts`), and at runtime carries the route's entity when its type matches,
  otherwise a NULL-valued (optional) context.

Runtime resolution (`getRuntimeContexts`): reads the current `RouteMatchInterface`, uses the route
helper to find the owning entity type id, then returns the first route parameter that is an
`EntityInterface` of that type. All contexts carry the `route` cache context. Consume it from, e.g., a
block plugin:

```php
#[Block(id: 'my_block', ...,
  context_definitions: [
    'entity' => new EntityContextDefinition('entity', required: FALSE),
  ]
)]
```

or target a specific type with `canonical_entity:taxonomy_term`. There is no need to register anything
else — enabling the module makes these contexts available to the context system.
