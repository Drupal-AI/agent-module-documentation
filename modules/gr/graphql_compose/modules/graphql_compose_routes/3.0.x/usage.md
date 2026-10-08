GraphQL Compose: Routes adds a `route(path:)` query so a decoupled front end can look up any URL and get back the matching entity, a redirect, or an external link — the key primitive for URL-driven routing in a headless site.

---

This submodule lets clients load content **by URL**. It provides SchemaType plugins `Route`, `RouteInternal`, `RouteExternal`, `RouteRedirect`, `RouteUnion` and `RouteEntityUnion`, a `RouteSchemaExtension`, and DataProducers (`RoutePath`, `RouteLanguage`, `RouteEntityExtra`, `UrlOrRedirect`, `RedirectUrl`, `RedirectStatusCode`, `Breadcrumbs`) plus request buffers (`EntityPreviewBuffer`, `SubrequestBuffer`). A per-bundle toggle `routes_enabled` (config key `entity_config.<entity_type>.<bundle>.routes_enabled`, shown only for entity types with a canonical link template) makes that bundle loadable through the `route()` query. Given a path, `route()` resolves to the internal entity, an external URL, or a redirect (integrating with the `redirect` module when present) and can also return breadcrumbs. Incoming paths can be rewritten with `hook_graphql_compose_routes_incoming_alter()`, and custom values mapped into the union with `hook_graphql_compose_routes_union_alter()`. Requires core `path`. Menus build on this submodule to resolve link targets.

---

- Look up any front-end URL and get the matching Drupal entity (`route(path: "/about")`).
- Drive a decoupled app's routing entirely from Drupal paths/aliases.
- Enable "load by URL" for a bundle via `entity_config.<type>.<bundle>.routes_enabled`.
- Follow Drupal redirects (301/302) from the API using the `redirect` module.
- Return a redirect's target URL and status code to the client.
- Resolve external-link routes distinctly from internal ones (`RouteExternal`).
- Return breadcrumbs for a given path.
- Support draft/preview routing through the entity preview buffer.
- Handle path aliases and canonical URLs transparently.
- Rewrite incoming paths (prefixes, corrections) with `hook_graphql_compose_routes_incoming_alter()`.
- Map custom route value types into `RouteUnion` with `hook_graphql_compose_routes_union_alter()`.
- Power a catch-all `[...slug]` page in Next.js/Nuxt from the `route()` query.
- Distinguish entity routes, redirects and external links in one union response.
- Localize routing for a multilingual headless site (`RouteLanguage`).
- Resolve node/taxonomy/media by their published URL.
- Return extra entity data alongside the resolved route (`RouteEntityExtra`).
- Batch multiple route lookups efficiently via subrequest buffering.
- Serve 404 handling by returning null for unknown paths.
- Let menus resolve their link targets (Menus submodule depends on this).
- Build breadcrumb navigation in a decoupled UI from Drupal route data.
