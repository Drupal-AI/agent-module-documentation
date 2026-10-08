<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Search API Fusion (search_api_fusion) — agent index

Makes a Search API Solr server talk to **Lucidworks Fusion** instead of plain Solr, and feeds Fusion's
behavioural-ranking pipeline with **request** and **click** signals. Not a standalone backend — it plugs a
`fusion` Solr connector into `search_api_solr`, so existing Search API indexes keep working. Depends on
`search_api_solr` (which pulls in `search_api`). Core `^10` (per the rc3 `.info.yml`).

No settings page of its own (`configure` null) — you configure it on the Search API server edit form by
picking backend **Solr** + Solr connector **Fusion**. Defines one permission, no Drush. Provides plugin
*implementations* (a Solr connector, a Search API processor, an autocomplete suggester, Views handlers) but
declares no new plugin types.

- **Connector settings (host/port/app, search query profile, click-signals toggle) + config keys** → [configure/connector.md](configure/connector.md)
- **The permission** → [permissions/permissions.md](permissions/permissions.md)
- **The plugins it provides and how to enable each** → [plugins/plugins.md](plugins/plugins.md)
- **Signals machinery (route, controller, connector methods, event subscriber)** → [api/signals.md](api/signals.md)
- **Views spellcheck / landing-pages areas + the ping field handler** → [views/views.md](views/views.md)

Key facts:
- Solr connector plugin id `fusion` → `Drupal\search_api_fusion\Plugin\SolrConnector\FusionConnector` (extends `BasicAuthSolrCloudConnector`). Default `port` `8764`, `context` `/api/solr`.
- Connector config keys: `context`, `fusion_qprofile_search`, `fusion_qprofile_autocomplete`, `fusion_click_signals` (schema type `plugin.plugin_configuration.search_api_solr_connector.fusion`).
- Search API processor id `fusion_request_signal`; autocomplete suggester id `fusion`.
- Route `search_api_fusion.signal.click` → `search_api_fusion/signals/click/{search_api_server}`, permission `send signals to any fusion server`.
- Service `search_api_fusion.search_api_fusion_subscriber` (listens on `SearchApiSolrEvents::POST_EXTRACT_RESULTS`); logger channel `logger.channel.search_api_fusion`.
- Views areas `search_api_fusion_spellcheck`, `search_api_fusion_landing_pages`; theme hooks of the same names.
