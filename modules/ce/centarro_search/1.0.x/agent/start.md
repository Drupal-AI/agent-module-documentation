<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Centarro Search (centarro_search) — agent index

Search API backend that indexes and queries content through **Elastic Enterprise Search 8.x (Elastic App Search)**,
using the official `elastic/enterprise-search` PHP client. From Centarro (Drupal Commerce).

- **Version dir:** 1.0.x (installed 1.0.0-beta4). Core `^8.9 || ^9.2 || ^10 || ^11`. License GPL-2.0-or-later.
- **Requires:** `search_api` (Drupal) and the `elastic/enterprise-search:^8` Composer library. Suggests `drupal/facets`.
- **No** routes, permissions, services, config schema, install hooks, or Drush commands of its own. No submodules.

## What it provides

- **One plugin:** Search API backend `centarro_search_ees` —
  `src/Plugin/search_api/backend/ElasticEnterpriseSearchBackend.php`
  (`ElasticEnterpriseSearchBackend extends BackendPluginBase implements PluginFormInterface`).
- **Backend config** (`defaultConfiguration`): `app_search_host`, `app_search_api_key` (stored on the
  `search_api_server` config entity).
- **Per-index setting:** `engine` — Elastic App Search engine name, stored as `search_api` third-party settings on
  the index, added by `hook_form_search_api_index_form_alter` in `centarro_search.module`.
- **Supported features:** `search_api_facets`, `search_api_facets_operator_or`.

## Docs

- Configuration (server + index, credentials): [agent/config/settings.md](config/settings.md)
- Backend plugin internals (indexing, search, filters, facets, schema): [agent/plugins/backend.md](plugins/backend.md)
