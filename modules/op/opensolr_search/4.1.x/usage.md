<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Opensolr Search provides crawler-based full-text search powered by the Opensolr service.

---

Opensolr Search **provides crawler-based full-text search via Opensolr** — instead of indexing from Drupal, it
uses the Opensolr web crawler and hosted Solr (with AI vector search, facets, autocomplete and analytics), so there
is no local indexing load. It depends on core Node and provides its own permissions.

Use it for hosted crawler-based search. It is a search/integration feature. Security/data handling: it relies on an
**external Opensolr service** that **crawls your site and hosts the index** (your content is stored on Opensolr —
egress; confirm acceptable, especially if any crawled pages aren't fully public) and authenticates with **Opensolr
credentials/API key** (store as secrets — env/Key — over HTTPS). Because it's crawler-based, exposed search results
reflect what the crawler can reach — ensure non-public content isn't crawlable. It has its own permissions.
Configure the Opensolr credentials.

---

- Provide crawler-based search.
- Use hosted Opensolr Solr.
- Offer AI/vector search + facets.
- Depend on core Node.
- Provide its own permissions.
- Serve search integration.
- Rely on an external Opensolr service that crawls + hosts the index (egress).
- Ensure non-public content isn't crawlable.
- Store Opensolr credentials/API key as secrets (env/Key, HTTPS).
- Confirm content-on-Opensolr is acceptable.
- Configure the Opensolr credentials.
- Handle Opensolr search.
- Search content.
- Configure the client.
- Crawl the site.
- Handle the integration.
- Serve results.
- Index externally.
- Secure the key.
- Provide Opensolr search.
