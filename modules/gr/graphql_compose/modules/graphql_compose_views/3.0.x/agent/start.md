# GraphQL Compose: Views — agent index

Exposes configured Drupal Views as GraphQL queries via a **GraphQL** views display plugin.
Depends on `graphql_compose` + core `views` (and `user`). Based on graphql_views 3.x.

- **Add a GraphQL display to a view, exposed filters, the schema types/producers, viewfield/search_api** →
  [configure/views.md](configure/views.md)

Key facts:
- Expose a view by adding a **GraphQL** display to it (Views UI or config). Not a per-bundle toggle.
- SchemaTypes: `View`, `ViewFilter`, `ViewPageInfo`, `ViewReference`, `BetweenFloatInput`, `BetweenStringInput`.
- Provides Views plugins: display (GraphQL), style, rows `GraphQLEntityRow`/`GraphQLFieldRow`, exposed_form; declared via `GraphQLViewsDisplay` attribute.
- `viewfield` support: `field_config.<type>.<bundle>.<field>.viewfield_query`.
- Enabling the submodule registers it as a provider: `schema_configuration.graphql_compose.providers.graphql_compose_views`.
- Ships its own config schema; clears GraphQL caches on `hook_views_invalidate_cache`.
