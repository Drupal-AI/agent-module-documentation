<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Opensolr Search provides hybrid AI (keyword + vector) full-text search powered by the hosted Opensolr service, indexing via web crawler or a direct Data Ingestion API.

---

Opensolr Search **connects Drupal to a hosted Opensolr (Apache Solr) index** and runs hybrid search
over it — BM25 keyword matching fused with 1024-dim vector/semantic search via Opensolr's
`{!hybrid}` parser — so there is no local Solr, no schema editing and no indexing load on Drupal.
Content reaches the index by two interchangeable paths that produce identical documents: the
**Opensolr web crawler** fetches your public pages (from a generated `/opensolr-sitemap.xml`) and
extracts HTML plus PDF/DOCX/XLSX/PPTX/ODT text, and the **Data Ingestion API** pushes documents
directly from Drupal (real-time on save/delete and a cron-batched bulk job, working behind a
firewall). On top of the index it adds a search page at `/opensolr-search` (or an embeddable hosted
widget), autocomplete, spellcheck, highlighting, auto-discovered and hierarchical drill-down facets,
query elevation, a privacy-first analytics dashboard, streamed AI Hints (RAG answers) and AI Reader
(per-document summaries), and — new in 5.0.x — search by uploaded image. It depends only on core
Node, targets Drupal 10.1/11/12 on PHP 8.1, and ships one `restrict access` permission
(`administer opensolr search`) plus its own config schema.

Security and data handling: it relies on an **external Opensolr service that stores a copy of your
content** (egress) and authenticates with an **Opensolr account email + API key** and per-index
**Solr HTTP-auth** credentials, all held in the `opensolr_search.settings` config object — treat that
config as sensitive, restrict the admin permission to trusted roles, and keep the credentials out of
exported/committed config (e.g. override `api_key` from `settings.php`). All outbound calls use HTTPS
with peer verification against the fixed `opensolr.com` / `api.opensolr.com` hosts; ingestion indexes
only content an anonymous user may view, and everything indexed is served to anonymous searchers, so
scope your crawl and content accordingly. Configure the Opensolr credentials, choose your index and
content types, then crawl or ingest.

---

- Add hosted, hybrid AI search (keyword + vector) to a Drupal site without running or configuring Solr.
- Index content with the external Opensolr web crawler — zero indexing load on Drupal.
- Push content directly from Drupal via the Data Ingestion API (real-time sync + cron bulk), even behind a firewall.
- Use the crawler and ingestion together — instant updates plus a crawler safety net.
- Run semantic / cross-lingual search so "CMS hosting" can match "Drupal cloud deployment".
- Let visitors switch a single search between hybrid vector and pure-keyword mode (per-search AI toggle).
- Search by uploading a photo — read to CLIP labels, OCR text or a barcode, then turned into a query.
- Offer streamed AI answers (AI Hints / RAG) above results, grounded in your own indexed content.
- Give each result a full-screen AI summary (AI Reader).
- Provide autocomplete with query suggestions and live Solr results in one dropdown.
- Build faceted navigation auto-discovered from the schema — lists, date ranges, numeric/duration sliders.
- Navigate multi-level taxonomies as hierarchical drill-down facets (breadcrumb-style, from JSON-LD).
- Pin or exclude specific results per query with visual PIN/EXCLUDE elevation buttons.
- Apply admin-configured persistent Solr `fq` filters to every search.
- Tune relevance: field weights, semantic–lexical balance, search modes, minimum-match, vector pool, quality boost.
- Bias results toward recency per search with the Fresh toggle (bookmarkable, off by default).
- Share one index across several Drupal sites ("Use an existing index") without document-ID collisions.
- Index attached documents (PDF, DOCX, XLSX, PPTX, ODT) and Commerce products with price/JSON-LD.
- Read a privacy-first analytics dashboard — queries, clicks, CTR, no-results, top URLs (hashed IPs).
- Emit OG / Twitter / JSON-LD / canonical meta tags for search and crawler pickup, no Metatag module needed.
- Serve results through the module's Twig templates or switch to Opensolr's embeddable hosted widget.
- Start, stop, pause, force-recrawl and monitor crawl schedules from inside Drupal.
- Restrict all configuration and index-management to trusted roles via the `administer opensolr search` permission.
- Keep the index in step automatically as nodes, products and files are created, updated, unpublished or deleted.
