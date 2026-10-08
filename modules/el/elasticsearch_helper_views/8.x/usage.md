<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Elasticsearch Helper Views provides tools to integrate Elasticsearch with the Drupal Views module.

---

Elasticsearch Helper Views bridges **Elasticsearch Helper** and **Views** — so a View can query an
Elasticsearch index (using the Elasticsearch Helper connection) and render Elasticsearch results with Views'
fields/filters/formatting. It depends on the Elasticsearch Helper module, in the Elasticsearch Helper package.

Use it to build Views over Elasticsearch data. It is a search/integration feature. Note that querying an
external Elasticsearch index means results **come from Elasticsearch, not Drupal's entity access system** — so
be careful what you index and expose (a Views listing over ES can surface documents without Drupal's
node/entity access unless you index/filter for it). It has no access-control role of its own. Configure the
Elasticsearch View.

---

- Query Elasticsearch from Views.
- Render ES results with Views.
- Use the Elasticsearch Helper connection.
- Depend on Elasticsearch Helper.
- Build Views over ES data.
- Use Views fields/filters on ES.
- KNOW results come from ES, not Drupal entity access.
- Be careful what you index/expose.
- Index/filter for access if needed.
- Have no access-control role of its own.
- Configure the Elasticsearch View.
- Handle ES Views.
- Query the index.
- Configure the View.
- Search Elasticsearch.
- Handle the integration.
- Render ES data.
- Build ES listings.
- Configure indexing.
- Provide ES Views.
