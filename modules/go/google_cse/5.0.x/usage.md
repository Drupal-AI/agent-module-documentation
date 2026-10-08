Google Programmable Search embeds Google's hosted Programmable Search Engine (formerly Custom Search Engine, "CSE") into a Drupal site, letting Google index and serve search results for your site (or any set of sites) with no Google API key required.

---

The module plugs into Drupal core's Search framework as a search page plugin (`google_cse_search`). You register a Programmable Search Engine on Google, copy its Search Engine ID ("cx"), and create a Search page at `/admin/config/search/pages` using the Google Programmable Search plugin, pasting the cx into the plugin's configuration. Results can be rendered on-site via Google's JavaScript widget (an embedded results element) or the search box can redirect the visitor to Google's own results page. A dedicated `google_cse` block provides a combined search-box-and-results widget you can place in any region for pages that should not use a standalone search route. Because Google hosts the index, there is no Solr/Search API backend, cron indexing, or field mapping to manage — the trade-off is that results depend on Google having crawled the site and on the visitor's browser running Google's script. All behaviour is controlled through the search page plugin configuration keys (cx, results_display, custom_results_display, query_key, watermark, prefix/suffix text, search box width, custom CSS, and arbitrary Programmable Search data-attributes). Access is gated by the `search Google CSE` permission; search configuration is gated by core's `administer search`.

---

- Add Google-powered site search to a Drupal site without running Solr or Search API
- Search your own site using Google's crawl and relevance ranking
- Search across multiple sites/domains from one search box (a multi-site Programmable Search Engine)
- Stand up site search with zero indexing/cron infrastructure to maintain
- Render Google search results inline on your own themed page (on-site results element)
- Redirect the core search block straight to Google's hosted results page instead
- Place a self-contained search-box-plus-results block in a sidebar or header region
- Set Google Programmable Search as the site's default search so the core search block uses it
- Offer search over a documentation or knowledge-base site backed by Google's index
- Provide search on a static/brochure site that has no database-driven content model
- Restrict which roles can run Google searches via the "View Google Programmable Search" permission
- Customize the results layout (overlay, full-width, two-column, compact, results-only, Google-hosted)
- Add prefix/suffix HTML around the search results area for instructions or promos
- Rename the query string parameter used for search terms (query_key) to fit existing URLs
- Show or hide the Google watermark per Google's branding guidelines
- Inject a custom external stylesheet to restyle the embedded Google results
- Pass through arbitrary Programmable Search element attributes (e.g. data-gl, data-lr, data-cr, data-as_sitesearch, data-safeSearch) as key/value data-attributes
- Scope search results to a specific country, language, or subdirectory via those data-attributes
- Improve accessibility of the results summary (adds role="status") when rendering on-site
- Tune the on-site search input width in characters
- Run several distinct Google search pages (each its own search engine ID) on one site
- Migrate Drupal 7 google_cse configuration into the new search page plugin (D7 migration provided)
- Give editors a hosted search experience while keeping the search box native to the Drupal theme
- Offer language-aware search using the visitor's current language for the Google widget
