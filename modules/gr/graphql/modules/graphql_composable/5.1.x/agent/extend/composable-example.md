<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The composable example, dissected

Files under `examples/graphql_composable/`. This is the reference implementation of the parent
module's composable pattern (see the parent's
[build-a-schema](../../../../../5.1.x/agent/extend/build-a-schema.md)).

## Plugins

- **Schema** — `src/Plugin/GraphQL/Schema/ComposableSchemaExample.php`:
  `#[Schema(id: "composable_example", name: "Composable Example schema")]`, empty body extending
  `Drupal\graphql\Plugin\GraphQL\Schema\ComposableSchema`. All types come from extensions.
- **SchemaExtension** — `src/Plugin/GraphQL/SchemaExtension/ComposableSchemaExampleExtension.php`:
  `#[SchemaExtension(id: "composable_extension", schema: "composable_example")]` extending
  `SdlSchemaExtensionPluginBase`. Its `registerResolvers()` wires every field (below).
- **DataProducers** — `src/Plugin/GraphQL/DataProducer/`: `CreateArticle` (`create_article`),
  `ArticleResponseArticle` (`article_response_article`), `ResponseViolations` (`response_violations`).
- **Wrapper** — `src/Wrappers/Response/ArticleResponse.php` (and `src/GraphQL/Response/ArticleResponse.php`):
  a `ResponseInterface` object carrying the created node + violations.

## SDL (`graphql/`)

- `composable_extension.base.graphqls` declares `type Mutation`, `scalar Violation`,
  `type Article { id title author }`, `interface Response { errors }`,
  `type ArticleResponse implements Response { errors article }`, and
  `input ArticleInput { title description }`.
- `composable_extension.extension.graphqls` adds `extend type Query { article(id: Int!): Article }`
  and `extend type Mutation { createArticle(data: ArticleInput): ArticleResponse }`.

## Resolver map (`registerResolvers()`)

| Type.field | Resolver |
|---|---|
| `Query.article` | `entity_load` (type `node`, bundles `[article]`, id from arg `id`) |
| `Mutation.createArticle` | `create_article` (data from arg `data`) |
| `ArticleResponse.article` | `article_response_article` (response from parent) |
| `ArticleResponse.errors` | `response_violations` (response from parent) |
| `Article.id` | `entity_id` (entity from parent) |
| `Article.title` | compose `entity_label` (entity from parent) |
| `Article.author` | compose `entity_owner` then `entity_label` |

A **type resolver** for the `Response` interface (`resolveResponse`) maps an `ArticleResponse` PHP
object to the `ArticleResponse` GraphQL type (throws on anything else).

## The mutation (`CreateArticle::resolve()`)

Builds an `ArticleResponse`. **If** the current user has `create article content`, it creates and
saves an `article` node (`title` = `$data['title']`, `body` = `$data['description']`) and sets it on
the response; otherwise it adds a "You do not have permissions to create articles." violation. This
is the model for permission-gating a write producer.

## Run it

```bash
drush en graphql_composable node -y
# create a server with schema composable_example, enable composable_extension, set endpoint, drush cr
# POST { article(id: 1) { title author } }  or  mutation { createArticle(data:{title:"Hi"}) { article { id } errors } }
```
