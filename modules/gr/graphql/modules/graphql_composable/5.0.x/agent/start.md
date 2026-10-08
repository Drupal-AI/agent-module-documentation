<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# graphql_composable — agent start

**Reference/example submodule of [graphql](../../../../5.0.x/agent/start.md).** Part of the GraphQL
project (ships under `examples/`). Depends on `graphql` + `node`. No config, no endpoints of its
own — enable it and it registers example plugins you point a server at.

It is the canonical worked example of the **composable pattern**:
- **Schema** plugin `ComposableSchemaExample` — id **`composable_example`** (subclass of core `ComposableSchema`).
- **SchemaExtension** `ComposableSchemaExampleExtension` — id **`composable_extension`**, `schema: composable_example`;
  SDL (`graphql/composable_extension.{base,extension}.graphqls`) + resolvers add
  `article(id: Int!): Article` (Query) and `createArticle(data: ArticleInput): ArticleResponse` (Mutation).
- **DataProducers**: `create_article`, `article_response_article`, `response_violations`.

Get a live endpoint: create a `graphql_server` with `schema: composable_example`, enable
`composable_extension` under `schema_configuration.composable.extensions`, set `endpoint`, `drush cr`,
POST GraphQL. For the plugin mechanics and how to write your own, read the parent docs:
[plugin types](../../../../5.0.x/agent/plugins/plugin-types.md) ·
[build a schema](../../../../5.0.x/agent/extend/build-a-schema.md) ·
[the server config entity](../../../../5.0.x/agent/configure/servers.md).
