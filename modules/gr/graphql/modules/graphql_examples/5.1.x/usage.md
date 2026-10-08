GraphQL examples is a reference submodule of GraphQL that demonstrates the SDL-first (non-composable) schema pattern: a Schema plugin whose resolvers map an `article` query, a paged `articles` connection over Drupal nodes, and a schema extension that adds a `page` query.

---

It ships no config or endpoints of its own — enable it and copy the code. Enabling it (`drush en graphql_examples`, depends on `node`) registers: the **Schema** plugin `ExampleSchema` (id `example`, extends `SdlSchemaPluginBase`) with SDL in `graphql/example.graphqls` (`Query { article(id), articles(offset, limit) }`, `Article`, `ArticleConnection { total, items }`); the **SchemaExtension** `ExampleSchemaExtension` (id `example_extension`, `schema: example`) that adds `extend type Query { page(id: Int!): Page }` plus a `Page` type; and three **DataProducers** — `query_articles` (an entity query over published `article` nodes, capped at `MAX_LIMIT = 100` with a `UserError` if exceeded), `connection_items`, and `connection_totals`. A `QueryConnection` wrapper implements `total()` and `items()`, using the parent module's entity buffer and `GraphQL\Deferred` to batch-load results. To see a live endpoint: create a `graphql_server` with `schema: example`, set an `endpoint`, `drush cr`, then POST GraphQL. It complements the `graphql_composable` example by showing an inline SDL schema and cursor-less offset/limit connections.

---

- Learn the SDL-first schema pattern (`SdlSchemaPluginBase` + a colocated `.graphqls` file).
- See a paged list/connection implemented over Drupal entities (`articles(offset, limit)` → `ArticleConnection`).
- Copy `QueryConnection` as a template for `total`/`items` connection wrappers using the entity buffer.
- Study deferred/batched entity loading with `GraphQL\Deferred` and `graphql.buffer.entity`.
- See how a query is capped (`MAX_LIMIT = 100`) and raises a `GraphQL\Error\UserError` when exceeded.
- Learn how to filter to published nodes in a data producer's entity query (`accessCheck()` + `status` condition).
- See an `article(id)` single-entity query wired to the core `entity_load` data producer.
- Model your own SDL schema's `registerResolvers()` on `ExampleSchema`.
- Add fields/queries to an existing SDL schema via a `@SchemaExtension` (`page(id)` example).
- See composed resolvers (`entity_label` then `uppercase`) transforming a field value.
- Reference the `id`/`name`/`schema` attribute values a Schema and SchemaExtension need.
- Provide a smoke-test schema (article / articles / page) for a fresh GraphQL install.
- Bootstrap a headless list+detail demo over Drupal nodes without writing new code.
- Compare the SDL-first pattern here against the composable pattern in `graphql_composable`.
- Test the built-in Explorer (GraphiQL) against a real paged query.
- Understand how cache tags/contexts are attached to a list result (`getListCacheTags`/`getListCacheContexts`).
- Use as the schema in tutorials, demos, or CI checks of the GraphQL module.
- Confirm which module directory (`examples/graphql_example/`) ships this worked example.
- See how `fromArgument()` maps `offset`/`limit` GraphQL args into a data producer's `resolve()`.
