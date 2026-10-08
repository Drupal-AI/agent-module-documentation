<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
GraphQL is a **framework for building GraphQL servers on Drupal**: it exposes your Drupal data model through one or more GraphQL schemas, each bound to its own HTTP endpoint. You define schemas in code (SDL + resolvers) and configure the running servers as `graphql_server` config entities from the admin UI or config.

---

The unit of configuration is the **`graphql_server` config entity** (config prefix `graphql_servers`): each server names a **Schema plugin**, stores that schema's `schema_configuration`, and declares an **`endpoint`** path. On save, the module's `RouteProvider` mints a JSON route `graphql.query.<server_id>` at that path (handled by `RequestController::handleRequest`), so every server is a live GraphQL endpoint. Schemas are built in code as **`@Schema` plugins** under `Plugin/GraphQL/Schema`; the common pattern is to extend `SdlSchemaPluginBase` (pair a `.graphqls` SDL type file with resolvers wired through the `ResolverBuilder`/`ResolverRegistry`) or to use the built-in **`ComposableSchema`** and attach one or more **`@SchemaExtension` plugins**, each adding SDL fragments + resolvers so a schema can be assembled from independent modules. Individual fields resolve their data through **`@DataProducer` plugins** — small, reusable, cacheable resolution steps (e.g. "load entity", "get property", "create article") that the resolver registry chains together. The bundled `webonyx/graphql-php` library executes queries; the module layers Drupal cache metadata, access checking (`_graphql_query_access`), language, batching, query depth/complexity limits, and optional introspection-disabling on top. An in-browser **Explorer** (GraphiQL) and **Voyager** are available per server at `/admin/config/graphql`. A bare install ships the plugin types and the server config entity but **no servers and no usable schema** — you write a Schema/SchemaExtension yourself, or enable the `graphql_composable` example submodule (schema id `composable_example`) for a working end-to-end endpoint. **Persisted queries** (`@PersistedQuery` plugins) let clients send a query id instead of the full query string.

---

- Expose Drupal content to a decoupled/headless front end (React, Vue, Next.js) through a single typed GraphQL endpoint.
- Stand up multiple GraphQL servers on one site, each with its own schema and endpoint path (e.g. `/graphql` public, `/graphql-admin` internal).
- Build a schema in SDL by extending `SdlSchemaPluginBase` and wiring resolvers with the `ResolverBuilder`.
- Assemble a schema from independent modules using `ComposableSchema` + several `@SchemaExtension` plugins.
- Write a reusable `@DataProducer` to load an entity, read a field, or perform a computed lookup and share it across many fields.
- Add a GraphQL mutation (e.g. create an article, submit a form) via a data producer that writes and returns a response type.
- Serve aggregated or shaped payloads a REST/JSON:API route cannot express in one request.
- Enforce per-server access with the `bypass graphql access` permission and route access checks.
- Limit abuse with per-server **query depth** and **query complexity** caps.
- Disable schema **introspection** in production while keeping it on in dev.
- Enable **query batching** so a client can send several operations in one HTTP request.
- Explore and debug a schema in-browser with the built-in **Explorer** (GraphiQL) and **Voyager** graph.
- Register **persisted queries** so clients send a short query id instead of the full query text (smaller requests, allow-listing).
- Cache GraphQL responses with Drupal cache tags/contexts for fast, invalidation-aware delivery.
- Validate a server's schema and inspect errors via the per-server **Validate** report.
- Configure servers as exportable YAML config (`graphql.graphql_servers.*`) so endpoints move through dev → prod with the config system.
- Support authenticated GraphQL requests across all site auth providers (cookie, OAuth, basic auth).
- Add file-upload validation to GraphQL mutations using the `graphql_file_validate` submodule.
- Learn the architecture end-to-end from the `graphql_composable` example (schema `composable_example` with a `createArticle` mutation).
- Return typed error/violation payloads from mutations (e.g. an `ArticleResponse` with `errors`).
- Provide a stable, versionable API contract to mobile apps decoupled from the Drupal theme layer.
- Set per-field cache max-age (e.g. force uncached) from within resolvers/data producers.
- Toggle response caching per server for schemas whose data must always be fresh.
