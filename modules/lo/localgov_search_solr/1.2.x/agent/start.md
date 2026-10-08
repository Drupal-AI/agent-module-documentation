<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# LocalGov Search Solr (localgov_search_solr) — agent index

**Config-only module: a default Solr server + index for LocalGov Drupal sitewide search.**

- **Version:** 1.2.x
- **Core:** ^10 || ^11
- **Depends on:** localgov_search, search_api_solr
- **Provides:** Search API Solr server + index config, Solr config-set field types/processors under `config/` (incl. `config/optional` and `config/conditional`)
- **No** PHP classes, routes, permissions or services of its own.
- **Setup:** stand up a compatible Solr core, point the imported Search API server at it, then index content.
- **Security:** no code surface; risk is inherited from Search API Solr and the Solr deployment (protect the Solr endpoint and connection credentials in the server config). No security findings.
