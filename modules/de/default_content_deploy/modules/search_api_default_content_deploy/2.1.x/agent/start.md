<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Search API Default Content Deploy (search_api_default_content_deploy) — agent index

Submodule of **default_content_deploy** (see the parent for export/import mechanics,
services, Drush, and events). It plugs the DCD exporter into the **Search API**
change-tracking pipeline so content is exported **incrementally**: create/update/delete
of tracked entities re-exports only the affected JSON files instead of everything.

Version **2.1.4**, core `^10.3 || ^11.0`. Depends on `search_api:search_api`. No
permissions, no Drush, no settings page of its own — configuration lives in the
per-index "Default Content Deploy specific index options" on the Search API index form.

- **Configure the DCD export stream on a Search API index** → [configure/settings.md](configure/settings.md)
- **The Search API backend + datasource plugins it provides** → [api/plugins.md](api/plugins.md)

Parent module: [`default_content_deploy`](../../../../2.1.x/agent/start.md).

## Key facts

- Search API **backend** plugin id: `search_api_default_content_deploy`
  (`DefaultContentDeployBackend`) — a write-only backend that exports items to files.
- Search API **datasource** plugin base id: `dcd_entity`
  (`DefaultContentDeployContentEntity`, derived per content entity type).
- Services: `search_api_default_content_deploy.default_content_deploy_event_subscriber`,
  `search_api_default_content_deploy.dcd_entity_datasource.tracking_manager`.
- Per-index third-party settings namespace: `search_api_default_content_deploy`
  (schema `search_api.index.*.third_party.search_api_default_content_deploy`).
- Implements `hook_entity_insert/update/delete`, `hook_search_api_index_update`,
  and `hook_form_search_api_index_form_alter`.
- Subscribes to DCD `PRE_SERIALIZE` / `POST_SERIALIZE` and Search API `INDEXING_ITEMS`.
