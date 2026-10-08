<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Opensolr Search provides crawler- and ingestion-based full-text search powered by the Opensolr service.

---

Opensolr Search **provides full-text search via Opensolr** — a hosted Apache Solr service — instead
of running or configuring Solr yourself. It offers two indexing paths: the Opensolr **web crawler**
(which fetches your public pages and hosts the resulting index) and the **Data Ingestion API**
(which pushes content directly from Drupal, with real-time sync on save/delete and bulk cron
ingestion). On top of the index you get hybrid AI search (BM25 keyword + BGE-m3 vector, fused by
Opensolr's `{!hybrid}` parser), AI-generated answers (AI Hints / AI Reader), autocomplete,
spellcheck, faceted and hierarchical drill-down navigation, query elevation, persistent filters,
a privacy-first analytics dashboard, and a per-search Fresh Results Bias. It depends only on core
Node and ships one restrict-access permission (`administer opensolr search`).

Use it for hosted search without managing a Solr server. It is a search/integration feature.
Security/data handling: it relies on an **external Opensolr service** that **stores a copy of your
indexed content** (egress — confirm this is acceptable, and if you use the crawler ensure genuinely
non-public content is not reachable). The module authenticates to a **fixed** Opensolr host over
HTTPS with **Opensolr credentials** (account email + API key) and per-index Solr HTTP-auth, entered
on the Settings tab and saved in the module's configuration; the API key is used server-side only.
As of 4.5.0 the ingestion path only indexes content an **anonymous visitor may view**, checked per
entity and failing closed. All ten admin tabs and every management action (index create / reset /
reconfigure / delete, config-set upload, crawl control, ingestion) are gated by the restrict-access
permission. Everything lives at `/admin/config/search/opensolr`. Configure the Opensolr credentials
first, then choose the crawler and/or ingestion path.

---

- Provide hosted full-text search powered by Opensolr (managed Apache Solr).
- Index via the external web crawler, the Data Ingestion API, or both.
- Serve a search page at `/opensolr-search` (Twig-rendered or an embeddable hosted widget).
- Offer hybrid AI search: BM25 keyword blended with vector/semantic matching.
- Stream AI Hints (RAG answers over your index) and AI Reader (per-document summaries).
- Provide autocomplete, "Did you mean?" spellcheck, and highlighting.
- Provide faceted navigation, including hierarchical drill-down facets from JSON-LD breadcrumbs.
- Provide query elevation — pin or exclude results per query.
- Apply admin-configured persistent Solr `fq` filters to every search.
- Offer a per-search Fresh Results Bias toggle with an admin-set strength.
- Show a privacy-first analytics dashboard (queries, clicks, CTR, no-results; hashed IPs).
- Sync content in real time on entity save/delete and bulk-ingest via cron.
- Index attached documents (PDF, DOCX, XLSX, PPTX, ODT, ODP) as searchable results.
- Support multilingual and cross-lingual matching (each translation is its own Solr doc).
- Support a multi-site shared index across several Drupal sites.
- Depend only on core Node; provide the restrict-access `administer opensolr search` permission.
- Rely on an external Opensolr service that hosts the index (egress; content copied to Opensolr).
- Ensure non-public content is not crawlable when using the crawler.
- Only index content an anonymous visitor may view (4.5.0; entity access check, fails closed).
- Configure the Opensolr credentials and select or create an index.
- Talk to a fixed Opensolr host over HTTPS with verified TLS.
- Manage crawl schedules (start / stop / pause / run now / reindex) from Drupal.
