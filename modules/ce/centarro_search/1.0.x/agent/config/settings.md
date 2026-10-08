<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration — Centarro Search

No dedicated settings route. Configuration lives on Search API entities (`/admin/config/search/search-api`).

## Install / enable

- `composer require drupal/centarro_search` (pulls `elastic/enterprise-search:^8` and `drupal/search_api:~1.17`).
- `drush en centarro_search`. No install hooks, no default config.
- Have an Elastic Enterprise Search 8.x deployment with an **App Search** engine (self-hosted or Elastic Cloud).

## Server configuration (backend)

Create a Search API server whose backend is **"Elastic Enterprise Search (Centarro Search)"**
(plugin id `centarro_search_ees`). Form built by `ElasticEnterpriseSearchBackend::buildConfigurationForm()`:

- `app_search_host` — App Search endpoint / host URL (from Elastic App Search credentials). Required.
- `app_search_api_key` — App Search private API key (from Elastic App Search credentials). Required.

Both keys come from `defaultConfiguration()` and are persisted in the `search_api_server` config entity.
`validateConfigurationForm()` is empty; `submitConfigurationForm()` just delegates to `PluginFormTrait`.
The client is built lazily in `getEnterpriseClient()` as
`new \Elastic\EnterpriseSearch\Client(['host' => ..., 'app-search' => ['apiKey' => ...]])`.

## Index configuration (engine)

`centarro_search.module` adds a per-index setting via `hook_form_search_api_index_form_alter`
(guarded to form ids `search_api_index_form` / `search_api_index_edit_form`):

- Fieldset **"Elastic APP search specific index options"** with one field, `engine`, stored under the index's
  `centarro_search` third-party settings. It is `#states`-visible only when the selected server uses this backend
  (`_centarro_search_index_settings_visibility()` enumerates matching servers via `centarro_search_get_servers(FALSE)`).
- A validate handler, `centarro_search_form_search_api_index_form_validate_server()`, requires `engine` to be
  non-empty when the index's server uses this backend.
- If `engine` is unset, `getEngineName()` falls back to the index id with `_` replaced by `-` (marked `@todo remove`).

App Search engine must be an Elasticsearch index-based engine. For Views fulltext exposed filters, use **Direct query**
parse mode. After changing synonyms/curations/relevance in the Elastic UI, clear Drupal caches.

## Notes for operators

- No `config/schema/*` ships with this module, so the backend/third-party settings have no explicit schema
  definition here; treat exported server config as containing the App Search credentials.
- The App Search host and key are administrator-supplied; they are not derived from any incoming request.
