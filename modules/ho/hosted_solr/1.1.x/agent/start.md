<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Hosted Solr — agent index

**Search API Solr** connector for the **Hosted Solr** SaaS. Version **1.1.0**. Core `^9 || ^10`.

- Plugin: `HostedSolrConnector` (`src/Plugin/SolrConnector/`), extends `SolrConnectorPluginBase`, uses `BasicAuthTrait`.
- Forces `scheme=https`, `port=443`; path derived from username. Configured via the Search API server form (no own routes/permissions).
- Depends on `search_api_solr`. Security: TLS pinned on (no disable option); credentials in server config entity.
