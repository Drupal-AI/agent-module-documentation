# GraphQL Compose: Routes — agent index

Adds a `route(path:)` query to load content **by URL** — resolving to an entity, a redirect, or
an external link. Depends on `graphql_compose` + core `path`. Menus build on it.

- **Enable load-by-URL for a bundle, the route union types, redirects/breadcrumbs, alter hooks** →
  [configure/routes.md](configure/routes.md)

Key facts:
- Enable per bundle (needs a canonical link template): `entity_config.<type>.<bundle>.routes_enabled: true`
  (e.g. `entity_config.node.article.routes_enabled`).
- SchemaTypes: `Route`, `RouteInternal`, `RouteExternal`, `RouteRedirect`, `RouteUnion`, `RouteEntityUnion`.
- DataProducers: `RoutePath`, `RouteLanguage`, `UrlOrRedirect`, `RedirectUrl`, `RedirectStatusCode`, `Breadcrumbs`.
- Alter hooks: `hook_graphql_compose_routes_incoming_alter(&$path, $context)`,
  `hook_graphql_compose_routes_union_alter($value, ?string &$type)`.
