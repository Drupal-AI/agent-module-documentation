<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Vertex AI Search adds a core Search page plugin that runs site search queries against a Google Vertex AI Search (Discovery Engine) app instead of the built-in index.

---

Vertex AI Search integrates with Drupal core Search by providing a `ConfigurableSearchPluginBase` plugin (`vertex_ai_search`) that talks to a Vertex AI Search / Discovery Engine app hosted on Google Cloud, using the `google/cloud-discoveryengine` PHP client and a Google service-account credentials file. You create one or more search pages under core Search Pages, point each at a Google Cloud project, location, data store ID and serving config, and configure how results are rendered. It was built as a migration path for sites leaving the Programmable Search Engine / `google_json_api` Site-Restricted JSON API (retired December 18, 2024). Beyond basic keyword search it supports spelling correction, safe search, snippet/title output, standard or Vertex-style paging, autocomplete (a simple local-DB source and a Vertex Completion source), keyword exclusion lists, configurable client-side JavaScript (regex validation), pluggable search filter/order/results extension points, per-page flood control, token-driven result messages, a "disable API / sample result" development mode, and an optional REST resource (`/search/vertex/v1/{search_page}`, provided via the RESTUI/rest layer) that returns search results as JSON. Each search page defines its own `use <id> custom search page` permission that gates the rendered results page. Depends on core `search` and `token`.

---

- Create a core Search page backed by Google Vertex AI Search instead of the core index.
- Migrate a site off the retired Programmable Search Engine / google_json_api Site-Restricted JSON API.
- Query a Vertex AI Website, Structured, or Unstructured data store from Drupal.
- Authenticate to Google Cloud with a service-account JSON credentials file referenced by path.
- Configure a search page's project ID, location, data store ID and serving config (default `default_search`).
- Use the config form's "Lookup Project" and "Lookup Data Stores" AJAX buttons to discover project/data-store IDs.
- Return title-only or title-plus-snippet results, using basic or advanced website indexing snippets.
- Enable Vertex spelling correction (AUTO / SUGGESTION_ONLY) and show "did you mean" links with an override.
- Turn on SafeSearch to filter explicit content in results.
- Strip the production domain from result links (relative links) for non-production environments.
- Page results with a standard multi-page pager or the module's incremental "Vertex" pager.
- Add autocomplete to the search page and/or the core search block using the Simple (local node title/body) source.
- Add autocomplete driven by Vertex query completion / search history via the Vertex Autocomplete source.
- Strip configured words, phrases, or regex patterns from user keywords with the exclusion list.
- Run filter-only searches (no keywords) driven by a custom Search Filter plugin's filter expression.
- Order results with a custom Search Order plugin's `orderBy` expression.
- Manipulate or inject curated results with a custom Search Results plugin.
- Attach configurable client-side JavaScript (e.g. the bundled Regex Validator) to the search form.
- Customize all result/no-result/no-keyword/correction/flood messages with Vertex AI Search tokens.
- Throttle abusive querying per page with built-in flood control (threshold, window, message).
- Develop and theme the results page offline with "Disable Google API Queries" returning a sample result.
- Expose search results as JSON to a decoupled front end through the REST resource route.
- Alter the outgoing `SearchRequest` or the returned results via `hook_vertex_ai_search_search_request_alter` / `hook_vertex_ai_search_search_results_alter`.
- Restrict who can use each search page through its generated `use <id> custom search page` permission.
