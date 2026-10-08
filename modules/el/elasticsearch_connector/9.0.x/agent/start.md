<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Elasticsearch Connector — agent index

Adds a Search API **backend** plugin, `elasticsearch`, so a `search_api.server` config
entity can index/query a real Elasticsearch (8/9) cluster. It has **no configure route**
(`configure: null` — Search API's own server UI/config handles that), no permissions, no
Drush commands. Its only persistent state is Search API's own config entities
(`search_api.server.*`, `search_api.index.*`); this module only supplies the `elasticsearch`
backend plugin id, a family of "connector" plugins that build the actual HTTP client, and two
optional processor plugins.

**Requires a live Elasticsearch cluster.** There is no bundled search engine — you must have a
reachable Elasticsearch 8/9 endpoint plus the Composer libraries
`elasticsearch/elasticsearch:^9.0.0` and `makinacorpus/php-lucene:^1.1`. None of this module's
docs, and none of the eval cases below, attempt to actually index or query — they are grounded
entirely in the Search API **config entity** the module produces/consumes, which is fully
inspectable without a live cluster.

- **Create/inspect a Search API server that uses this backend** (which connector, which URL,
  advanced settings) → [configure/server.md](configure/server.md)
- **The `elasticsearch_connector` plugin type** — the manager, the annotation, the four shipped
  connectors (`standard`, `basicauth`, `elastic_cloud_id`, `elastic_cloud_endpoint`), and how to
  add a new one → [plugins/connector.md](plugins/connector.md)

Key fact: a server's config shape is always
`search_api.server.<id>` → `backend: elasticsearch`, `backend_config: {connector, connector_config, advanced}`
— see [configure/server.md](configure/server.md) for the exact keys.
