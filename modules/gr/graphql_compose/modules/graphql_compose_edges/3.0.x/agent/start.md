# GraphQL Compose: Edges — agent index

Adds Relay-style **Connection** queries (edges/nodes/cursors/pageInfo) with cursor pagination
for enabled entity bundles. Depends on `graphql_compose`. Other submodules (Comments) build on it.

- **Enable the edge/connection query for a bundle, the max-limit setting, filters, alter hook** →
  [configure/edges.md](configure/edges.md)

Key facts:
- Enable per bundle: `entity_config.<entity_type>.<bundle>.edges_enabled: true`
  (e.g. `entity_config.node.article.edges_enabled`).
- Global page cap: `settings.edge_max_limit` (integer) in `graphql_compose.settings.graphql_compose_server`.
- SchemaTypes: `ConnectionType`, `EdgeType`, `EdgeNode`, `ConnectionPageInfo`, `ConnectionSortKeys`, `CursorType`.
- Built-in filters: published, language. Extend with `hook_graphql_compose_edges_alter($producer, $connection, $context)`.
