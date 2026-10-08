<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
SearchStax connects a Drupal site to the SearchStax hosted Solr / SearchStudio Site Search product, adding a Search API Solr connector for the managed cluster plus front-end search tracking, analytics, and auto-suggest.

---

SearchStax builds on Search API (and, for indexing, `search_api_solr`) to talk to SearchStax's cloud-hosted Solr. It ships a `SolrConnector` plugin (`searchstax`, "SearchStax Cloud with Token Auth") that authenticates to the managed cluster with a short-lived token rather than basic auth, and a Tika file extractor plugin for `search_api_attachments`. Beyond indexing, it wires the SearchStudio JavaScript tracker into search-results pages so query/click analytics flow back to the SearchStax dashboard, with opt-out by role and integration with EU Cookie Compliance for consent gating. Optional features include SearchStudio auto-suggest (typeahead) through `search_api_autocomplete`, re-routing live search queries through SearchStudio (`searches_via_searchstudio`), Views relevance-model selection, and built-in flood protection that rate-limits search and update requests per IP. Site-wide behaviour is controlled by the `searchstax.settings` config object edited at `/admin/config/search/searchstax`; per-server credentials live on the Search API server's connector config (optionally backed by Key entities). A `Check version compatibility` form talks to the SearchStax account API to confirm the Solr app matches the Drupal major version. The project also bundles two submodules: `solr_to_searchstax_ss_migration`, a one-off UI/Drush workflow to migrate an existing Solr server's configuration into SearchStax (as of 1.13.0 it also migrates field/date boosts); and `searchstax_ui_kit` (new in 1.13.0), which stores SearchStax "app" config entities and exposes server-side proxy endpoints so a SearchStax UI Kit search page can query the app without exposing its credentials to the browser. Live indexing, analytics, and version checks require a SearchStax subscription and network access to SearchStax; without `search_api_solr` the module still provides tracking/analytics only.

---

- Connect Drupal's Search API to a SearchStax hosted Solr cluster using token authentication.
- Index site content into a SearchStax-managed Solr core via `search_api_solr`.
- Add the "SearchStax Cloud with Token Auth" Solr connector to a Search API server.
- Feed search query and result-click analytics to the SearchStax / SearchStudio dashboard.
- Track result clicks correctly even when result links carry their own query parameters.
- Exclude specific user roles (e.g. administrators, editors) from analytics tracking.
- Gate SearchStudio tracking behind EU Cookie Compliance consent categories.
- Add SearchStudio auto-suggest / typeahead to a search box via `search_api_autocomplete`.
- Re-route live search requests through SearchStudio instead of querying Solr directly.
- Discard selected Drupal query parameters (highlight, keys, spellcheck…) when using SearchStudio.
- Pin which version of the SearchStudio tracking JavaScript to load.
- Extract text from PDFs and office documents for indexing with the SearchStax Tika extractor.
- Rate-limit search requests per IP to protect the Solr backend from abuse (flood protection).
- Rate-limit index update requests per IP within a configurable time window.
- Choose a SearchStudio relevance model per Views search display.
- Verify that the SearchStax Solr app is compatible with the site's Drupal major version.
- Store SearchStax Solr and analytics credentials as Key entities rather than plain config.
- Configure separate analytics keys for individual searches on multi-search sites.
- Set the global SearchStax analytics key and analytics endpoint URL.
- Migrate an existing generic Solr server's config (including field/date boosts) to SearchStax.
- Copy a Search API index onto a freshly migrated SearchStax server.
- Set a valid SearchStax auth token from the CLI for headless/automated indexing.
- Detect and surface Solr connection errors raised by the SearchStax backend.
- Provide search-only tracking/analytics on sites that do not use Solr indexing at all.
- Build a SearchStax UI Kit search page that proxies requests through Drupal (via the `searchstax_ui_kit` submodule).
