<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Opensolr Search — agent index

**Crawler- and ingestion-based full-text search powered by Opensolr** (external web crawler +
Data Ingestion API, hosted Apache Solr, AI vector/hybrid search, facets, AI answers, analytics).
Depends on core `node`. Provides one restrict-access permission. Version **4.5.0**.
Core `^10.1||^11||^12`, PHP `8.1`. Configure at `/admin/config/search/opensolr`.

Search/integration — an **external Opensolr service (opensolr.com) hosts the Solr index** and
either **crawls your public pages** or receives content **pushed from Drupal via the Data
Ingestion API** (egress; a copy of indexed content lives on Opensolr). The module talks to a
**fixed** Opensolr host over HTTPS (TLS verified); the base host is not config-overridable. Its
own **`administer opensolr search`** permission (restrict access) gates every management action —
credentials, index create/reset/reconfigure/delete, config-set upload, crawl start/stop, and
data ingestion. Public search/autocomplete/AI/sitemap routes serve only the already-public index.

## What it does
- Full-text search page at `/opensolr-search` (Twig-rendered, or an embeddable hosted widget).
- Hybrid ranking: BM25 keyword + BGE-m3 vector search fused by Opensolr's `{!hybrid}` parser;
  search modes (Union / Keywords Required / Meaning Required / Intersection).
- AI Hints (streaming RAG answer over the index) and AI Reader (per-document summary).
- Autocomplete, spellcheck, faceted + hierarchical drill-down navigation, query elevation.
- Two indexing paths: external **web crawler** (via a generated sitemap) and **Data Ingestion
  API** (real-time sync on entity save/delete + bulk cron ingestion). Both build identical docs.
- Analytics dashboard (queries, clicks, CTR, no-results; hashed IPs), persistent filters,
  per-search Fresh Results Bias, multi-site shared index.

## Key files
- `src/Service/OpensolrClient.php` — all Opensolr management-API + Solr HTTP calls (fixed hosts,
  `CURLOPT_SSL_VERIFYPEER` on; HMAC-signed crawler ops).
- `src/Service/SolrQueryService.php` — builds/escapes the Solr query; `src/Service/IngestService.php`
  — builds ingest docs and (4.5.0) only indexes content an anonymous user may view (fails closed).
- `src/Controller/{Search,Ai,Setup,AnalyticsApi,Sitemap,ElevationDelete}Controller.php`.
- `src/Form/*` — 10 admin tabs; `opensolr_search.routing.yml`, `.permissions.yml`,
  `.services.yml`, `config/{install,schema}/`.

## Security-relevant shape (plain mechanism)
- Opensolr account email + API key and the per-index Solr HTTP-auth username/password are entered
  on the Settings tab and stored in the module's configuration (`opensolr_search.settings`); the
  API key is used server-side only and never emitted to the browser.
- Management API base is fixed to `opensolr.com` / `api.opensolr.com`; Solr host/port come from the
  Opensolr index metadata. All outbound cURL verifies TLS.
- Public query, facet-range and sort parameters are numeric-cast / regex-validated / Solr-escaped
  before reaching Solr; results render through Twig (auto-escaped) and Search-API-style templates.
- Every admin/management route requires the restrict-access `administer opensolr search` permission;
  the public search/autocomplete/AI/sitemap routes serve only the already-public index.

## Diff 4.1.x → 4.5.x (real changes)
- **4.5.0 (security):** content an anonymous visitor cannot view is no longer indexed — the
  ingest path now runs an entity `access('view', anonymous)` check that fails closed, instead of
  only checking `isPublished()`. Attached-document crawling fixed (`crawler_include_files` /
  `ingest_include_files` now actually drive `follow_docs`); embedded-widget initial-query fixed;
  Facet Mapping save no longer wipes facets when Solr is unreachable; search page no longer 500s
  for anonymous visitors on a missing elevations table; Solr outages are now logged.
- **4.4.0:** real-time indexing of newly saved documents (PDF/Office/`.odp`), removal of deleted
  files from the index; PIN / EXCLUDE / EXCLUDE ALL result-page curation buttons fixed and global
  EXCLUDE ALL rules now applied.
- **4.3.x:** Fresh Results Bias **Weight** slider on Search Tuning; undated docs excluded while
  Fresh is on; "Clear all" no longer resets sort/tab/Fresh.
- **4.2.x:** Fresh Results Bias toggle added (per-search `?fresh_bias=1`); AI Hints rewritten to
  direct grounded answers and AI Reader to a full readable rendition; AI answer caching keyed on
  documents+prompt+temperature with a 7-day TTL; the public AI query is length-capped (500 chars)
  and client-supplied prompt context is ignored (server-side retrieval only); Drupal 12 hook
  readiness.
- **Metadata:** `core_version_requirement` now `^10.1 || ^11 || ^12`, PHP 8.1, `configure` link to
  the settings form.
