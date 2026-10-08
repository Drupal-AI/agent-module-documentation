<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Opensolr Search — agent index

**Hybrid AI search powered by the hosted Opensolr service** (keyword/BM25 + vector/semantic),
indexed by an **external web crawler and/or a direct Data Ingestion API**. Adds AI answers,
autocomplete, facets (incl. hierarchical drill-down), analytics, query elevation, image search and
page-level PDF results. Depends on core `node`. Provides its own permission and config schema.
Version **5.1.3**. Core `^10.1 || ^11 || ^12`, PHP `8.1`.

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
- **Page-level PDF results** (5.1.x): a PDF is indexed one Solr document per page; results carry a
  **Page N** deep link, consecutive pages of one PDF are grouped under its title, and Read Page /
  Read Document summarise a single page or the whole PDF.
- **Image search**: a photo is POSTed (magic-byte MIME allow-list, 20 MB cap, 30/min/IP flood gate,
  never stored), read to CLIP labels / OCR text / barcodes by the Opensolr `image_to_text` API,
  then redirected into a normal query.
- Injects `opensolr:*` / OG / Twitter / JSON-LD meta tags on node & commerce_product pages for the
  crawler to read; keeps the index in step on node/product/file insert/update/delete.

## Key surfaces (for code work)

- `Service/OpensolrClient` — the Opensolr management + Solr API client (create/reset/delete index,
  upload config ZIP, reload core, start/stop/pause crawl, embeddings, Solr select/delete, account
  summary). Credentials read from config; HMAC-signed calls for crawl-URL and account endpoints.
- `Service/SolrQueryService` — builds the hybrid Solr query (facets, fq, sanitisation); `IngestService`
  — builds/pushes documents, gated by an anonymous `view` access check.
- `Service/AnalyticsService` — writes the query/click logs AND the new per-word suggestion tables
  (`addTerm()` / `recordTerms()`), hashing IPs before storage.
- `Controller/SearchController`, `AiController`, `SitemapController` — public routes (`_access: TRUE`).
- `Controller/SetupController`, `AnalyticsApiController` — admin AJAX (index setup, crawl control,
  reset, elevation, ingest); all gated by `administer opensolr search` and an XHR (`X-Requested-With`)
  guard on state-changing POSTs.
- Config: `opensolr_search.settings` (credentials, index/Solr connection, facets, tuning, crawler
  and ingest options). Six DB tables via `hook_schema` — query log, click log, elevations,
  ingest-jobs, and (5.1.x) `opensolr_search_query_terms` + `opensolr_search_query_words` for
  autocomplete suggestions. No Drush commands. One Block plugin (`SearchBlock`).

## Diff 5.0.x → 5.1.x

A **minor (feature) bump**; routes, permission and the `opensolr_search.settings` config object are
unchanged — all integrations carry over.

- **New: page-level PDF indexing** (5.1.0). Crawler and ingestion now index each PDF as one Solr
  document per page. Result page carries a **Page N** pill linking to that page of the PDF; pages of
  the same PDF that fall together are grouped under the document title (match count + which pages,
  top 5 shown, rest expand). **Read Page** summarises the matched page, **Read Document** the whole
  PDF; results show page count and creation date. Re-crawl / re-ingest PDFs to populate.
- **New: smarter autocomplete** (5.1.2). Suggestions now match the start of **any word** in a past
  search, in any order (`alterna`, `curre`, `alternative curr` all find "8558A Alternative
  Current"); prefix matches rank first, then most-searched. Backed by two new tables
  (`opensolr_search_query_terms`, `opensolr_search_query_words`) populated live and backfilled by
  `hook_update_10005` — **run `drush updatedb`** on upgrade.
- **UI/layout fixes** (5.1.1 / 5.1.2 / 5.1.3): the sort / Fresh / AI controls row and the PDF group
  header stay pinned under the search box while scrolling; the facet sidebar always fits the viewport
  so its last facet is reachable even with infinite scroll.
- **Carried over from 5.0.x:** hybrid `{!hybrid}` parser, per-search AI toggle (`?ai=yes|no`),
  Fresh bias (`?fresh_bias=1`), image search (`POST /opensolr-search/image`), Duration facet widget,
  and the 4.5.0 anonymous-view indexing gate. **Core `^12` and PHP 8.1** unchanged.

## Security / data-handling notes (public, plain-mechanism)

- Content indexed by Opensolr is served to anonymous visitors on the search page; the crawler
  indexes what it can reach. Only expose content you are comfortable making searchable, and rely on
  the anonymous-view check (ingestion) plus your own crawl scoping.
- Opensolr credentials (account API key + Solr HTTP auth) live in `opensolr_search.settings`. Treat
  that config as sensitive: restrict the `administer opensolr search` permission to trusted roles,
  and keep the values out of exported/committed config (e.g. override `api_key` from `settings.php`).
- All Opensolr/Solr HTTP calls verify TLS and target the fixed `opensolr.com` / `api.opensolr.com`
  hosts. Admin index-management endpoints require the admin permission and an XHR header;
  destructive infra actions (reset/delete index, recrawl) are not reachable anonymously. The public
  image-search route is additionally flood-limited (30/min/IP) and validates uploads by magic bytes.
