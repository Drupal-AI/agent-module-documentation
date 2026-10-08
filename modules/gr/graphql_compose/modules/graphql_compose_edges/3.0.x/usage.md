GraphQL Compose: Edges adds Relay-style **Connection** queries (edges, nodes, cursors and pageInfo) so a client can load many entities of a bundle at once with cursor-based pagination.

---

This submodule turns an enabled entity bundle into a cursor-paginated GraphQL connection. Ticking **Enable edge query** on a bundle (config key `entity_config.<entity_type>.<bundle>.edges_enabled`) adds a plural connection query for that bundle, derived via `EntityTypePluginEdgeDeriver`. It provides SchemaType plugins (`ConnectionType`, `EdgeType`, `EdgeNode`, `ConnectionPageInfo`, `ConnectionSortKeys`, `CursorType`), an `EdgesSchemaExtension`, DataProducers (`ConnectionEdges`, `ConnectionNodes`, `ConnectionPageInfo`, `EdgeCursor`, `EdgeNode`, `EntityTypePluginEdge`) and an `EntityConnection`/`EntityConnectionQueryHelper` implementation, plus pluggable edge filters (`EntityFilterPublished`, `EntityFilterLanguage`). A global `settings.edge_max_limit` caps how many items one connection query may return (default from `EntityConnection::MAX_LIMIT`). You can extend a connection (add custom filters/cache tags) with `hook_graphql_compose_edges_alter()`. The connection code is based on the Open Social distribution. Several other submodules (e.g. Comments) rely on Edges for their list types.

---

- Load a paginated list of Articles with `first`/`after` cursor arguments.
- Return `edges { node { … } cursor }` plus `pageInfo { hasNextPage endCursor }` for a bundle.
- Enable connection queries per bundle via `entity_config.<type>.<bundle>.edges_enabled`.
- Implement infinite scroll / "load more" in a decoupled front end.
- Cap the maximum page size site-wide with `settings.edge_max_limit`.
- Filter a connection to only published entities (built-in published filter).
- Filter a connection by language (built-in language filter).
- Sort a connection using the generated `ConnectionSortKeys`.
- Provide stable cursors so clients can resume pagination.
- Build a news/blog listing page backed by a connection query.
- Add a custom filter to a specific bundle's connection via `hook_graphql_compose_edges_alter()`.
- Attach extra cache tags to a connection for correct invalidation.
- Power comment threads and other list types that depend on Edges.
- Expose count/pageInfo without fetching all nodes.
- Query the first N most-recent items of a content type.
- Return typed `Edge`/`Connection` wrappers instead of plain arrays.
- Support Relay-compatible GraphQL clients (Apollo, Relay, urql).
- Paginate taxonomy terms, media, or any enabled content entity bundle.
- Keep large result sets performant by limiting page size.
- Combine connection pagination with per-bundle field selection.
