<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The example schema, dissected

Files under `examples/graphql_example/` (module machine name `graphql_examples`). This is the
reference implementation of the parent module's **SDL-first** pattern (contrast the composable
`graphql_composable`). See the parent's
[build-a-schema](../../../../../5.1.x/agent/extend/build-a-schema.md).

## Plugins

- **Schema** — `src/Plugin/GraphQL/Schema/ExampleSchema.php`: `#[Schema(id: "example")]` extending
  `SdlSchemaPluginBase`. `registerResolvers()` calls `addQueryFields`, `addArticleFields`, and
  `addConnectionFields('ArticleConnection', ...)`.
- **SchemaExtension** — `src/Plugin/GraphQL/SchemaExtension/ExampleSchemaExtension.php`:
  `#[SchemaExtension(id: "example_extension", schema: "example")]` adding the `page` query and `Page`
  field resolvers.
- **DataProducers** — `src/Plugin/GraphQL/DataProducer/`: `QueryArticles` (`query_articles`),
  `ConnectionItems` (`connection_items`), `ConnectionTotals` (`connection_totals`).
- **Wrapper** — `src/Wrappers/QueryConnection.php`: holds an entity query + entity buffer.

## SDL (`graphql/`)

- `example.graphqls` — the base schema: `schema { query: Query }`,
  `Query { article(id: Int!): Article, articles(offset: Int = 0, limit: Int = 10): ArticleConnection! }`,
  `Article { id title author }`, `ArticleConnection { total: Int!, items: [Article!] }`.
- `example_extension.base.graphqls` — `type Page { id title }`.
- `example_extension.extension.graphqls` — `extend type Query { page(id: Int!): Page }`.

## Resolver map

| Type.field | Resolver |
|---|---|
| `Query.article` | `entity_load` (node / bundle `article` / arg `id`) |
| `Query.articles` | `query_articles` (args `offset`, `limit`) → `QueryConnection` |
| `Query.page` (extension) | `entity_load` (node / bundle `page` / arg `id`) |
| `Article.id` / `Page.id` | `entity_id` (from parent) |
| `Article.title` / `Page.title` | compose `entity_label` then `uppercase` |
| `Article.author` | compose `entity_owner` then `entity_label` |
| `ArticleConnection.total` | `connection_total`* (connection from parent) |
| `ArticleConnection.items` | `connection_items` (connection from parent) |

\* The `total` field maps to producer id **`connection_total`**, but the shipped producer id is
**`connection_totals`** (`ConnectionTotals`). Fix the id when copying this example.

## The connection (pagination)

`QueryArticles::resolve(int $offset, int $limit, ...)` throws `GraphQL\Error\UserError` if
`$limit > MAX_LIMIT` (100), builds a node entity query with `->currentRevision()->accessCheck()`
plus an explicit `status = PUBLISHED` condition (access check alone does not exclude unpublished),
filters to bundle `article`, applies `range($offset, $limit)`, attaches the entity type's list cache
tags/contexts, and returns a `QueryConnection`. `QueryConnection::total()` clones the query and
counts; `items()` executes the query then batch-loads via `graphql.buffer.entity`, returning a
`GraphQL\Deferred` so multiple fields resolve in one round trip.

## Run it

```bash
drush en graphql_examples node -y
# create a server with schema example, set endpoint, drush cr
# POST { articles(limit: 5) { total items { id title author } } }
```
