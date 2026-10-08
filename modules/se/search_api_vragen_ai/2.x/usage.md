<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Search API Vragen.ai adds a Search API backend that indexes your Drupal content into the hosted Vragen.ai semantic-search service and runs searches against it.

---

Install with `composer require drupal/search_api_vragen_ai` and enable it (it depends on **Search API** and the `swisnl/json-api-client` library). Then, under **Configuration → Search and metadata → Search API** (`/admin/config/search/search-api`), add a **Server** using the **Vragen.ai** backend and enter the **API endpoint** and **Bearer token** that Vragen.ai provisioned for your organization; once both are valid, a **Search System** dropdown loads so you can optionally scope searches to a Vragen.ai system. Create an **Index** on that server with **Content** and/or **Media** datasources, add your fields, and (recommended) render text fields to HTML so the service reads structure. Use the **Vragen.ai semantic content** processor to pick which fields become the searchable document body — everything else is sent as display-only **metadata** (author, dates). To index PDFs, add file/media reference fields as the **Vragen.ai attachment** type and enable the **Vragen.ai attachment files** processor; media PDFs are detected and handed to Vragen.ai for extraction. Set **Index items immediately** off so indexing runs on cron rather than on every save. Extra knobs include **alpha** (semantic-vs-keyword weighting), **max distance**/**distance** (relevance cut-offs, also settable per Views display), **language fallback**, **multisite support** (prefixes references when several sites share one account, and requires a reindex when toggled), and a config-only **search_cache_ttl** that caches results for one hour by default. Because indexed content and queries are sent to an external service, treat the bearer token as a credential and confirm your content is appropriate to process off-site.

---

- Add AI-powered semantic search to a Drupal site via Search API.
- Index Content entities into Vragen.ai as searchable documents.
- Index Media (PDF) documents for full-text extraction by the service.
- Run "more like this" (related content) queries with `search_api_mlt`.
- Build faceted search over Vragen.ai results (including OR facets).
- Choose exactly which fields are semantic body vs metadata.
- Attach files/PDFs to documents via the attachment field type.
- Tune hybrid search with the alpha (semantic vs keyword) value.
- Filter out weak matches with max-distance / distance cut-offs.
- Override those query settings per Views display.
- Scope searches to a specific Vragen.ai "search system".
- Keep multilingual results mapped to the right translation.
- Share one Vragen.ai account across a Drupal multisite safely.
- Cache repeated searches to cut API calls, tuned by TTL.
- Sync content in the background through cron instead of on save.
- Alter or veto a document before it is indexed, from custom code.
- Power a chatbot or assistant from your existing Search API index.
- Provide question-answering search over documentation/knowledge bases.
- Keep Drupal as the source of truth while searching externally.
- Restrict configuration to trusted Search API administrators.
- Reindex all content after changing multisite or field settings.
- Test connectivity from the server form before going live.
