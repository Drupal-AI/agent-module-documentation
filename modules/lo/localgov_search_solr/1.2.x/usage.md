<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
LocalGov Search Solr provides a ready-made Apache Solr backend and index configuration for LocalGov Drupal's sitewide search.

---

It is a configuration-only module: it depends on `localgov_search` (which defines the sitewide search framework and its index) and `search_api_solr` (the Search API Solr backend), and on install imports a Solr server, a matching index, field types and processors so a LocalGov site can search against Solr instead of the database. It ships the generated Solr `config-set` field-type definitions (multiple Solr schema versions) under `config/`, including optional conditional config. There is no PHP, no routes, no permissions and no services of its own — it simply wires Search API to a Solr server you provide.

Setup is operational: stand up a Solr core/collection compatible with search_api_solr, point the imported Search API server at its host/port/core, then (re)index content. Because it only carries configuration, the security surface is limited to that of Search API Solr and your Solr deployment (network exposure of the Solr endpoint, credentials in the server config). Keep the Solr endpoint firewalled and the exported server config — which may contain connection details — protected.

---
- Provide a Solr backend for LocalGov Drupal sitewide search.
- Install the default LocalGov Solr index and server config in one step.
- Replace the database search backend with Solr for better relevance/scale.
- Point the imported Search API server at your Solr host, port and core.
- Generate a Solr config-set matching the shipped field types.
- Index LocalGov content into Solr.
- Re-index after content or config changes.
- Use the shipped Solr schema for the appropriate Solr version.
- Apply optional conditional search configuration.
- Tune analysers/field types via the exported Solr field-type config.
- Support faceted sitewide search through Search API.
- Improve full-text relevance over the core DB search.
- Scale search for large LocalGov sites.
- Keep search config in code for deployment across environments.
- Combine with localgov_search facets/blocks for the search UI.
- Verify the Solr connection from the Search API server report.
- Firewall the Solr endpoint referenced by the server config.
- Rotate Solr credentials stored in the Search API server config.
