<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Search API ElasticSearchKit Proxy acts as a proxy controller for Elasticsearch search requests.

---

Search API ElasticSearchKit Proxy **proxies Elasticsearch search requests** — a controller that mediates
search queries to an Elasticsearch backend (via Elasticsearch Connector), so front ends can query search through
Drupal. It depends on Elasticsearch Connector, Elasticsearch Search API and Search API.

Use it to proxy Elasticsearch queries. It is a search/integration feature. Security note: a search proxy forwards
queries to Elasticsearch — ensure the proxy **constrains what can be queried** (only intended indexes/fields) and
that results respect content access, so it can't be abused to query beyond the intended search scope. It has no
access-control role of its own. Configure the proxy and Elasticsearch connection.

---

- Proxy Elasticsearch search requests.
- Mediate queries to Elasticsearch.
- Serve front-end search.
- Depend on Elasticsearch Connector + Search API.
- Serve search/integration.
- Forward search queries.
- CONSTRAIN what can be queried (only intended indexes/fields).
- Ensure results respect content access.
- Not be abusable beyond the intended search scope.
- Have no access-control role of its own.
- Configure the proxy + connection.
- Handle the search proxy.
- Proxy queries.
- Configure the proxy.
- Forward queries.
- Handle Elasticsearch.
- Serve search.
- Mediate search.
- Constrain the scope.
- Provide an Elasticsearch proxy.
