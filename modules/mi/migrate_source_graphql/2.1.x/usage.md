<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Migrate Source GraphQL adds a Migrate source plugin (`plugin: graphql`) that runs one configured query against a GraphQL endpoint and yields the returned nodes as migration source rows.

---

The module registers a single migrate source plugin, `graphql`, provided by `SourcePluginBase`. You configure it entirely from the migration YAML's `source:` section: a mandatory `endpoint` URL, a mandatory `query` (query name, optional `arguments`, and a `fields` list), an optional `auth_scheme` + `auth_parameters` pair that becomes an `Authorization` header, an optional `data_key` giving the property path to the row array inside the response, and an optional `ids` map (defaulting to `id` of type `string`). At run time `initializeIterator()` builds a `GraphQL\Query` from the nested `query` array via a small recursive builder, hands it to the bundled `gmostafa/php-graphql-client` client, and sends a **single** HTTP POST (`Content-Type: application/json`) to the endpoint. The JSON response is walked down the `data_key` path — segments split on `/` (Drupal's `Row::PROPERTY_SEPARATOR`), with a `%` token that maps over an indexed array and pulls out a named sub-field — then a `ResultsEvent` is dispatched so other modules may inspect or replace the result set, and finally each result is `json_decode(json_encode($result), TRUE)`'d into an associative array and `yield`ed as a source row. This is a thin request-and-yield source: there is **no built-in pagination, cursor-following, retry, or rate-limit handling**. Any paging (page/limit, cursors, filters) must be written into the query `arguments` yourself; the plugin fetches exactly one page per run. Because the endpoint, query, and auth token all come from migration configuration, this is a developer/admin-defined surface run from the CLI or the Migrate UI — not request input. A note on a real doc trap: the plugin reads `auth_parameters` (plural), while some README examples show `auth_parameter` (singular); use the plural key or the Authorization value comes out empty. On a `QueryError` the plugin catches the exception and adds it as a Drupal messenger error rather than failing the migration hard.

---

- Migrate content from a headless CMS that exposes a GraphQL API into Drupal entities.
- Import "posts" from a GraphQL endpoint into Drupal article nodes (the canonical README example).
- Pull rows from another Drupal site running the GraphQL module.
- Read migration source rows from any GraphQL service instead of hand-fetching JSON.
- Import only the fields a migration needs by declaring them in the query's `fields` list.
- Fetch nested related objects in a single query and flatten them into a source row.
- Send a Bearer token to a protected GraphQL API via `auth_scheme: Bearer` + `auth_parameters`.
- Send HTTP Basic or Digest credentials to an authenticated endpoint via `auth_scheme`.
- Point the plugin at a response whose row array is not under `data` by setting `data_key`.
- Reach into a nested response path such as `data/%/user` using the `/` separator and `%` index-map token.
- Filter or search the source set by passing GraphQL `arguments` (e.g. a search query string).
- Page a source by encoding `page`/`limit` (or cursor args) into the query `arguments` yourself.
- Set the migration's unique source key(s) and types via the `ids` map.
- Subscribe to `ResultsEvent` in a custom module to reshape or filter results before they become rows.
- Run the resulting migration with the standard `drush migrate:import` / Migrate UI workflow.
- Combine with process plugins to map GraphQL fields onto Drupal entity fields.
- Prototype an API-sourced migration quickly against a public test endpoint (e.g. GraphQLZero).
- Sync taxonomy, users, or media references from an external GraphQL source into Drupal.
- Seed a new Drupal site from a partner's GraphQL API during a platform migration.
- Import a bounded per-run batch of records by pairing query arguments with repeated migration runs.
