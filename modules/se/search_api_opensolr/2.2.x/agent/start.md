<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Search API opensolr — agent index

Extends `search_api_solr` to use the hosted **opensolr.com** SaaS: Solr Connector plugins plus admin
forms to register/connect an account, autoconfigure a core + Search API server, and upload Solr config.
Depends on `search_api_solr`; optional `key`. Config UI: `search_api_opensolr.opensolr_config_form`.
One permission (`administer search_api_opensolr`); no Drush; no config schema file.

- **Global credentials (email + API key), Key-module integration, test connection** →
  [configure/settings.md](configure/settings.md)
- **The setup flows: Get started (account registration), Autoconfigure, add server, config-zip import** →
  [configure/setup.md](configure/setup.md)
- **The two Solr Connector plugins (`opensolr`, `basic_auth_opensolr`) and how they self-fill settings**
  → [plugins/connectors.md](plugins/connectors.md)
- **The opensolr API service layer (`OpenSolrBase` + Index/ConfigFiles/Account components) for code** →
  [api/api.md](api/api.md)

Submodule:
- `search_api_opensolr_security` (per-core HTTP auth + IP allow-list) →
  [../../modules/search_api_opensolr_security/2.2.x/agent/start.md](../../modules/search_api_opensolr_security/2.2.x/agent/start.md)

Key facts:
- Config object `search_api_opensolr.opensolrconfig` → `opensolr_credentials.{email, api_key, api_key_raw}`
  (ships **empty** — no shipped secret). With Key module the key is an auto-created Key entity.
- All calls hit the hardcoded endpoint `https://opensolr.com/solr_manager/api` (`OpenSolrBase`).
- Admin routes require `administer search_api_opensolr`; config-zip/files import require
  `search_api_server.edit` entity access.
