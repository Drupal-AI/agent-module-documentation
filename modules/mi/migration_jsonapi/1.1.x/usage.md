<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Migration JsonAPI extends migrate_plus's JSON data parser (`data_parser_plugin: jsonapi`) so a migration can pull from a remote Drupal **JSON:API**, auto-generating and paginating the request URLs instead of listing them by hand.
---
The parser assembles each URL from source configuration keys — `jsonapi_host`, `jsonapi_prefix` (e.g. `/jsonapi`), `jsonapi_endpoint` (e.g. `/node/article`) and optional nested `jsonapi_query_params` — and walks the collection using `page[offset]`/`page[limit]` (default limit 50). With `jsonapi_langcodes` it iterates languages, prepending the langcode to the path and adding a `filter[langcode]` parameter; parameter names are overridable via `jsonapi_query_param_keys`. It requires an empty `urls: []` in the source since URLs are generated at runtime, and it logs each queried URL to the `jsonapi` logger channel.

It is a pure developer/CLI migration tool (no routes, permissions or UI) and requires `migrate_plus`; PHP 8.1+. The generated requests hit the remote host over HTTP using migrate_plus's HTTP data fetcher (standard TLS). Setup: define a `url`/`http`/`jsonapi` source with the host/prefix/endpoint keys and run with Migrate Tools/Drush.
---
- Migrate nodes from a remote Drupal site's JSON:API.
- Auto-paginate JSON:API results with `page[offset]`/`page[limit]`.
- Set the batch size via a `page[limit]` query param.
- Point a migration at `/jsonapi/node/article` on a source host.
- Add JSON:API filters via nested `jsonapi_query_params`.
- Import multiple languages using `jsonapi_langcodes`.
- Include the default language with the `und` langcode.
- Prepend the langcode to the endpoint path for translations.
- Override the `filter[langcode]` parameter name.
- Override the offset/limit parameter names for custom endpoints.
- Migrate taxonomy terms exposed over JSON:API.
- Consume a decoupled/remote Drupal content source.
- Log each generated JSON:API URL for debugging.
- Combine with migrate_plus process plugins to map JSON:API fields.
- Import only default-langcode content with a `filter[default_langcode]` param.
- Run the migration with `drush migrate:import`.
