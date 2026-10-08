<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Search API Pages creates standalone search pages, each served at a URL path and backed by a Search API index, plus a matching search form block — a lightweight alternative to building search with Views.

---

The module defines a `search_api_page` configuration entity: each instance binds one Search API **index** to a URL **path** (e.g. `search/content`) and is managed at `/admin/config/search/search-api-pages`. When a visitor submits keywords, the page runs a Search API query against the chosen index over the configured full-text (searched) fields and renders the results, either as rendered entity view modes or as excerpt "snippets", with a pager whose page size comes from the `limit` setting. Options per page include `clean_url` (path-based vs. query-string keys), `show_all_when_no_keys` (list everything before a search is run), `show_search_form` (render the form above results), and `parse_mode` (how the keyword string is parsed, e.g. `direct` or `terms`). A companion **Search Api Page search block form** block (`search_api_page_form_block`) places a search box anywhere and redirects submissions to a chosen search page. Each page is also exposed to Search API as a derived **display** plugin, so Facets and other display-aware integrations can target an individual page. The only hard dependency is `search_api` (an index — DB, Solr, or otherwise — must already exist to bind).

---

- Add a public site-wide search page at a clean URL such as `/search` backed by a content index.
- Provide multiple search pages (e.g. one for articles, one for documents) each bound to a different index.
- Bind an existing Search API DB index to a browsable search page without building a View.
- Bind a Solr-backed index to a fast full-text search page.
- Place a search box block in the header that redirects to a full results page.
- Add a search block to the sidebar of specific content types only, via block visibility.
- Restrict which fields are searched by choosing a subset of the index's full-text fields per page.
- Show all indexed results as a browsable listing when no keywords are entered (`show_all_when_no_keys`).
- Render results as full entity teasers by using the "view modes" style.
- Render results as compact excerpt snippets with highlighted terms using the "search results" style.
- Control results-per-page and pagination with the per-page `limit` setting.
- Offer keyword search with clean, bookmarkable URLs (`clean_url`) like `/search/drupal`.
- Switch a page to query-string keys (`?keys=...`) when clean URLs are not wanted.
- Choose how queries are parsed (`direct`, `terms`, ...) to tune exact-phrase vs. term matching.
- Add Facets to a search page by targeting its Search API display plugin.
- Build a knowledge-base / documentation search over an index of pages and files.
- Provide a members-only search page gated by the "Use search" permission.
- Let editors administer search pages through a dedicated admin permission without granting broader access.
- Translate a search page's path and label per language on multilingual sites.
- Theme results by overriding the `search-api-page.html.twig` / `search-api-page-result.html.twig` templates.
- Alter the rendered results page programmatically via `hook_search_api_page_alter()`.
- Ship a search page as exportable configuration so it deploys with the site.
- Replace or supplement core Search with Search API's indexing while keeping a familiar search-page UX.
- Create a file/media search page when the bound index includes file datasources.
- Give a small site full-text search without the overhead of a Views-based search display.
- Expose a search endpoint whose results feed a block placed on the front page.
