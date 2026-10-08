<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
GraphQL composable example is a reference submodule of GraphQL that demonstrates the **composable schema** pattern end to end: a Schema plugin, a SchemaExtension that pairs SDL with resolvers, and DataProducers implementing an `article` query and a `createArticle` mutation over Drupal nodes.

---

It ships no config or endpoints of its own — it is meant to be enabled and copied. Enabling it (`drush en graphql_composable`, depends on `node`) registers three plugins with the parent module: the **Schema** plugin `ComposableSchemaExample` (id `composable_example`, a thin subclass of the core `ComposableSchema`); the **SchemaExtension** `ComposableSchemaExampleExtension` (id `composable_extension`, `schema: composable_example`) whose `.graphqls` files add `extend type Query { article(id: Int!): Article }` and `extend type Mutation { createArticle(data: ArticleInput): ArticleResponse }`, wired to resolvers via the `ResolverBuilder`; and three **DataProducer** plugins (`create_article`, `article_response_article`, `response_violations`). To see a live endpoint: create a `graphql_server` config entity with `schema: composable_example`, enable `composable_extension` under `schema_configuration.composable.extensions`, set an `endpoint`, `drush cr`, then POST GraphQL to that path. It is the fastest way to understand how SDL, resolvers, and data producers fit together in the parent module.

---

- Learn the composable schema pattern (Schema + SchemaExtension + DataProducer) from working code.
- Get a live GraphQL endpoint quickly by pointing a `graphql_server` at schema `composable_example`.
- Study how a resolver is wired to a DataProducer with the `ResolverBuilder` (`article` query).
- See a full GraphQL **mutation** implemented (`createArticle` creating a node and returning a typed response).
- Copy the `create_article` DataProducer as a template for your own write/mutation producers.
- See how a typed response object (`ArticleResponse` with `article` + `errors`) is returned from a mutation.
- Understand how SDL `.base.graphqls` vs `.extension.graphqls` files are used by an extension.
- Model your own SchemaExtension's `registerResolvers()` on `ComposableSchemaExampleExtension`.
- Demonstrate GraphQL over Drupal core `node` entities without writing any new code.
- Provide a smoke-test schema when validating a fresh GraphQL install.
- Reference the `id`/`name`/`schema` attribute values a Schema and SchemaExtension plugin need.
- Use as the schema in tutorials, demos, or CI checks of the GraphQL module.
- See how `entity_load` / `entity_id` / `entity_label` core DataProducers are consumed in a resolver.
- Understand how `fromArgument()`, `fromParent()`, and `fromValue()` map inputs into a DataProducer.
- Test the built-in Explorer (GraphiQL) against a real query and mutation without writing code.
- Bootstrap a headless demo (article read + create) over Drupal nodes in minutes.
- Model a `ResponseInterface`/violations pattern for returning validation errors from mutations.
- Compare a thin Schema subclass (`ComposableSchemaExample`) against writing an SDL schema from scratch.
- Confirm which module directory (`examples/`) GraphQL ships its worked examples in.
