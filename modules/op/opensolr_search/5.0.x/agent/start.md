<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Opensolr Search — agent index

**Hybrid AI search powered by the hosted Opensolr service** (keyword/BM25 + vector/semantic),
indexed by an **external web crawler and/or a direct Data Ingestion API**. Adds AI answers,
autocomplete, facets (incl. hierarchical drill-down), analytics, query elevation and image search.
Depends on core `node`. Provides its own permission and config schema. Version **5.0.0**.
Core `^10.1 || ^11 || ^12`, PHP `8.1`.

Search/integration — an **external Opensolr service crawls your site and/or receives pushed
documents and hosts the index** (egress; ensure content that must stay private is not crawled or
ingested). Authenticates with an **Opensolr account email + API key** plus per-index **Solr HTTP
auth** credentials, all stored in module config (`opensolr_search.settings`). All outbound calls
use HTTPS with peer verification; the API base host is fixed to `opensolr.com` / `api.opensolr.com`.
Ships one **restrict-access** permission, `administer opensolr search`, gating every admin and
crawl/index-management route; ingestion only indexes content an anonymous user may view.

## What it does

- Connects Drupal to a hosted Opensolr (Apache Solr) index; no local Solr, no manual schema/field
  mapping, no indexing load on Drupal.
- Two index paths, producing identical Solr documents:
  - **Web Crawler** — Opensolr fetches your public pages (via a generated
    `/opensolr-sitemap.xml`) and extracts HTML + PDF/DOCX/XLSX/PPTX/ODT text.
  - **Data Ingestion API** — Drupal pushes documents directly (real-time on entity save/delete,
    plus a cron-batched "Ingest All"); works behind a firewall.
- Hybrid search via Opensolr's `{!hybrid}` parser (BM25 + 1024-dim BGE-m3 KNN), with search modes,
  field weights, minimum-match, freshness bias and a content-quality boost (Search Tuning).
- Public search UI at `/opensolr-search` (Twig) or an optional embeddable hosted widget; plus
  autocomplete, "Did you mean?" spellcheck, highlighting, facets, analytics click tracking,
  AI Hints (streamed RAG answer) and AI Reader (streamed per-document summary).
- **Image search** (5.0.x): a photo is POSTed, read to CLIP labels / OCR text / barcodes by the
  Opensolr `image_to_text` API, then redirected into a normal query.
- Injects `opensolr:*` / OG / Twitter / JSON-LD meta tags on node & commerce_product pages for the
  crawler to read; keeps the index in step on node/product/file insert/update/delete.

## Key surfaces (for code work)

- `Service/OpensolrClient` — the Opensolr management + Solr API client (create/reset/delete index,
  upload config ZIP, reload core, start/stop/pause crawl, embeddings, Solr select/delete, account
  summary). Credentials read from config; HMAC-signed calls for crawl-URL and account endpoints.
- `Service/SolrQueryService` — builds the hybrid Solr query (facets, fq, sanitisation); `IngestService`
  — builds/pushes documents, gated by an anonymous `view` access check.
- `Controller/SearchController`, `AiController`, `SitemapController` — public routes (`_access: TRUE`).
- `Controller/SetupController`, `AnalyticsApiController` — admin AJAX (index setup, crawl control,
  reset, elevation, ingest); all gated by `administer opensolr search` and an XHR (`X-Requested-With`)
  guard on state-changing POSTs.
- Config: `opensolr_search.settings` (credentials, index/Solr connection, facets, tuning, crawler
  and ingest options). Two DB tables (`opensolr_search_query_log`, `opensolr_search_click_log`,
  ingest-jobs table) via `hook_schema`. No Drush commands. One Block plugin (`SearchBlock`).

## Diff 4.1.x → 5.0.x

A **major (feature) bump**, not an API rewrite — most integrations carry over unchanged.

- **New: image search.** Route `opensolr_search.image_search` (POST `/opensolr-search/image`,
  `_access: TRUE`) accepts an uploaded picture (magic-byte MIME allow-list, 20 MB cap, never stored)
  and turns it into a query; new `?img=` / `?im=` / `?img_error=` result markers.
- **New: per-search AI (hybrid) toggle** (`?ai=yes|no`) and a **Duration** facet widget
  (h:mm:ss slider); facet Filter box now searches the full value list; richer document result fields.
- **Behavioural / indexing change (from 4.5.0):** ingestion now indexes an entity only if an
  **anonymous user may `view`** it — content hidden by node-access grants (Group, Content Access,
  Domain Access, etc.) is no longer indexed even when published. Some previously-indexed content may
  drop out of the index after upgrade; re-ingest/re-crawl to refresh.
- **Config key rename (with fallback):** crawler/ingest file inclusion moved from
  `include_attached_files` to `crawler_include_files` / `ingest_include_files`; the old key is still
  read as a fallback, so no manual migration is required. New tuning/embed keys added to schema.
- **Fresh Results Bias** (4.2.x/4.3.x): a per-search recency toggle (`?fresh_bias=1`) plus a
  Search-Tuning strength slider; hybrid moved to the `{!hybrid}` parser (4.0.0) — query-side only,
  no reindex.
- **Core:** now also allows Drupal `^12`; `php: 8.1` declared. Permission, routes and the
  `opensolr_search.settings` config object are unchanged in name and shape.

## Security / data-handling notes (public, plain-mechanism)

- Content indexed by Opensolr is served to anonymous visitors on the search page; the crawler
  indexes what it can reach. Only expose content you are comfortable making searchable, and rely on
  the anonymous-view check (ingestion) plus your own crawl scoping.
- Opensolr credentials (account API key + Solr HTTP auth) live in `opensolr_search.settings`. Treat
  that config as sensitive: restrict the `administer opensolr search` permission to trusted roles,
  and keep the values out of exported/committed config (e.g. override `api_key` from `settings.php`).
- All Opensolr/Solr HTTP calls verify TLS and target the fixed `opensolr.com` / `api.opensolr.com`
  hosts. Admin index-management endpoints require the admin permission and an XHR header;
  destructive infra actions (reset/delete index, recrawl) are not reachable anonymously.
