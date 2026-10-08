<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# GraphQL examples (graphql_examples) — agent index

**Reference/example submodule of [graphql](../../../../5.1.x/agent/start.md).** Part of the GraphQL
project (ships under `examples/graphql_example/`; machine name **`graphql_examples`**). Depends on
`graphql` + `node`. No config, no endpoints of its own — enable it and it registers example plugins
you point a server at.

It is the canonical worked example of the **SDL-first (non-composable) pattern**:
- **Schema** plugin `ExampleSchema` — id **`example`** (extends `SdlSchemaPluginBase`); SDL
  `graphql/example.graphqls` (`article(id)`, `articles(offset, limit)`, `Article`, `ArticleConnection`).
- **SchemaExtension** `ExampleSchemaExtension` — id **`example_extension`**, `schema: example`; adds
  `extend type Query { page(id: Int!): Page }` + a `Page` type.
- **DataProducers**: `query_articles` (published-article query, `MAX_LIMIT = 100`), `connection_items`,
  `connection_totals`; wrapper `QueryConnection` (`total()`/`items()` with the entity buffer + `Deferred`).

Get a live endpoint: create a `graphql_server` with `schema: example`, set `endpoint`, `drush cr`,
POST GraphQL (`{ articles(limit: 5) { total items { id title author } } }`).

- The plugins, SDL, resolver map, and the connection/pagination flow → [extend/example-schema.md](extend/example-schema.md)

For the plugin mechanics and how to write your own, read the parent docs:
[plugin types](../../../../5.1.x/agent/plugins/plugin-types.md) ·
[build a schema](../../../../5.1.x/agent/extend/build-a-schema.md) ·
[the server config entity](../../../../5.1.x/agent/configure/servers.md).
