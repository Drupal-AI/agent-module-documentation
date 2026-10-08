<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Search API ElasticSearchKit Proxy — agent index

**Acts as a proxy controller for Elasticsearch search requests**. Depends on `elasticsearch_connector`,
`elasticsearch_search_api`, `search_api`. Version **2.0.0**. Core `^10||^11`.

Search/integration — constrain what the proxy can query (intended indexes/fields), ensure results respect content
access; no access role of its own.
