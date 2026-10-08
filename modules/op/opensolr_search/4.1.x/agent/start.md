<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Opensolr Search — agent index

**Crawler-based full-text search powered by Opensolr** (external crawler + hosted Solr, AI vector search, facets).
Depends on core `node`. Provides permissions. Version **4.1.0**. Core `^10.1||^11||^12`.

Search/integration — an **external Opensolr service crawls your site + hosts the index** (egress; ensure non-public
content isn't crawlable); **credentials/API key** as secrets (env/Key, HTTPS). Own permissions.
