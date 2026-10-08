Search 404 turns a "404 Page not found" response into a search: it extracts keywords from the requested URL path and shows search results (or jumps straight to a matching page) instead of a plain error.

---

On install, Search 404 sets the site's `page.404` (`system.site` `page.404`) to `/search404`, so every unresolved request is routed to `Search404Controller::search404Page()`. The controller parses keywords out of the requested path (`search404GetKeys()`) — splitting on slashes, hyphens and punctuation, stripping ignored words (`search404_ignore`), file extensions (`search404_ignore_extensions`) and optionally a leading language code — then runs them through the site's default core Search page (`search.search_page_repository`) and renders the search form plus results on the 404 page. Out of the box it uses the **core Search** module; it also works with **Search API** or any other search by enabling a custom search path (`search404_do_custom_search` + `search404_custom_search_path` with an `@keys` token that redirects to e.g. a View), and has built-in hooks for **Search by page** and **Google CSE**. Optional "jump" behavior redirects the visitor directly to the first hit — when there is exactly one result (`search404_jump`) or always to the first of many (`search404_first`, optionally restricted to `search404_first_on_paths`) — using a 302 or, if `search404_redirect_301` is set, a 301. To protect large sites and asset requests, it can abort searches on paths ending in a file extension (`search404_deny_all_file_extensions` / `search404_deny_specific_file_extensions`), skip the automatic search and just show the form (`search404_skip_auto_search`), and ignore whole path patterns (`search404_ignore_paths`). The 404 page's title, intro text, error message and an empty-result redirect are all configurable. All settings live in the `search404.settings` config object and are edited at **Admin → Configuration → Search and metadata → Search 404 settings** (`/admin/config/search/search404`, gated by the core `administer search` permission).

---

- Show search results for the keywords in a broken URL instead of a bare "Page not found".
- Recover inbound traffic from links to pages that were renamed or removed.
- Turn `/some-old-article-title` into a search for "some old article title".
- Keep the core Search module as the backend with zero extra configuration.
- Point 404 searches at a Search API index by setting a custom search path to a View.
- Redirect 404 keywords into any View that takes a path argument via `@keys`.
- Jump the visitor straight to the page when the search returns exactly one result.
- Always send visitors to the first result, even when several match, on chosen paths.
- Restrict the "jump to first result" behavior to specific paths (e.g. `blog/*`).
- Issue a 301 (instead of the default 302) for the jump/redirect for SEO.
- Reduce server load on large sites by showing the populated search form without auto-searching.
- Abort the search for any URL that ends in a file extension (images, PDFs, scripts).
- Abort searches only for specific extensions like `gif jpg jpeg bmp png`.
- Strip extensions such as `htm html php` from the keywords before searching.
- Ignore stop words like "and or the" so they don't pollute the query.
- Ignore whole path patterns (e.g. `admin/*`, `ajax/*`) and show the default 404 there.
- Drop a leading language-code segment from the keywords on multilingual sites.
- Combine keywords with OR (`search404_use_or`) to widen the search.
- Concatenate keywords with a custom separator instead of whitespace.
- Detect the query from a search-engine referer (Google, Bing, Yahoo, etc.) and search for it.
- Redirect a managed-file request straight to the file (`search404_search_file_entities`).
- Set a custom title for the 404 search-results page.
- Add custom intro text (HTML) above the search results.
- Replace the default Drupal error message with a custom one containing `@keys`.
- Suppress the error message entirely on the 404 results page.
- Redirect to a fallback URL (e.g. `/node`) when the search yields no results.
- Exclude parts of the path from the query with a PCRE regex filter.
- Deploy all 404-search behavior as configuration between environments.
- Route 404s to a "Search by page" search or a Google CSE when those modules are enabled.
