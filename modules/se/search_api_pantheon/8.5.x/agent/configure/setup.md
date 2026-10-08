<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — server, index & Pantheon setup

The module has **no `configure` route**. It manages Search API config entities that you
edit through Search API at `/admin/config/search/search-api`.

## Pantheon-side prerequisites
- Enable **Solr** as an add-on in the Pantheon site dashboard (Settings).
- In `pantheon.yml` set the Solr version:
  ```yaml
  search:
    version: 9   # or 8
  ```
  The file follows your code through environments; each environment gets its own Solr core.

## What enabling the module installs
Enabling `search_api_pantheon` also enables `search_api` and `search_api_solr`, and
installs two config entities from `config/install/`:

- **Server** `search_api.server.pantheon_search` (id `pantheon_search`, name "Pantheon Search")
  - `backend: search_api_solr`, `backend_config.connector: pantheon`
  - key `connector_config`: `scheme: https`, `port: 443`, `path: v1`, `solr_version: '9'`,
    `http_method: AUTO`, `commit_within: 1000`, `skip_schema_check: true`,
    timeouts `timeout: 5` / `index_timeout: 5` / `optimize_timeout: 10` / `finalize_timeout: 30`
  - `disabled_request_handlers` / `disabled_request_dispatchers` prune replication + http-caching handlers.
- **Index** `search_api.index.primary` (id `primary`, name "Primary"), linked to the server.

Only **one** Pantheon-connector server per environment is supported; extra ones all point
at the same Solr core and cause schema conflicts.

## Connection is env-var driven (do not hand-edit host/core)
The `pantheon` connector force-overrides the connection at runtime from Pantheon
environment variables (present only on Pantheon, gated by `PANTHEON_ENVIRONMENT`):

| Env variable | Overrides connector key |
|---|---|
| `PANTHEON_INDEX_SCHEME` (default `https`) | `scheme` |
| `PANTHEON_INDEX_HOST` | `host` |
| `PANTHEON_INDEX_PORT` | `port` |
| `PANTHEON_INDEX_PATH` (prefixed with `/`) | `path` |
| `PANTHEON_INDEX_CORE` (leading slash trimmed) | `core` |

Off Pantheon (no `PANTHEON_ENVIRONMENT`) the overrides are empty and the module is a no-op.
On non-`lando` Pantheon environments the connector also blanks `context` (the Pantheon
endpoint has no `/solr/` path segment).

## Config schema
`config/schema/search_api_pantheon.connector.pantheon.schema.yml` declares
`plugin.plugin_configuration.search_api_solr_connector.pantheon`, inheriting the `standard`
connector schema from Search API Solr — so the connector has no extra stored settings of its own.

## Typical flow
1. Enable module → server + Primary index appear at `/admin/config/search/search-api`.
2. On the index's **Fields** tab, add fields (e.g. Title, Body); Save.
3. Post the schema: `drush search-api-pantheon:postSchema` (see [../drush/commands.md](../drush/commands.md)) — auto-reloads the core.
4. **Index now** (or wait for cron).
5. Build a View of type "Index" with an exposed keywords filter and a `relevance` sort.
6. `drush config:export` to version the server/index YAML for deployment to Test/Live.

Repost the schema after adding Solr field types, upgrading `search_api_solr`, switching Solr
8↔9, or enabling Search API Solr sub-modules (multilingual, autocomplete).
