<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Google JSON API lets you create Drupal search pages whose results come from a Google Programmable Search Engine (Custom Search) via its JSON API, presented through core Search with paging and highlighting.

---

It provides a core Search plugin (GoogleJsonApiSearch) that queries the Google endpoint with your Search Engine ID (cx) and API key, merges paged result sets (Google caps results at 100), and renders them; a pager-manager decorator adapts core's pager to the API's paging model, and a Twig extension highlights search terms in results. A global settings form at /admin/config/search/google-json-api (perm 'administer google json api') stores endpoint/documentation URLs, while the per-search-page configuration (cx, apikey, endpoint choice) is set on the search page itself. It depends on core search and token. HTTP requests go through Drupal's http_client with default TLS verification, and the endpoint URL comes from admin configuration (no user-supplied SSRF). Use it to add Google-quality search over your own domain(s) without running an index.

---

- Add Google-powered site search to a Drupal site.
- Return Programmable Search Engine results in a core search page.
- Avoid running and maintaining a local search index.
- Search across multiple domains configured in a Google CSE.
- Highlight query terms in the result listing.
- Page through Google results within Drupal's pager.
- Provide familiar Google-quality relevance to visitors.
- Configure the CSE ID and API key per search page.
- Offer image or web result modes via the CSE settings.
- Set up multiple search pages with different engines.
- Store endpoint and documentation URLs centrally.
- Sort results using supported Google sort parameters.
- Integrate hosted search without server-side crawling.
- Use tokens in configured search-page values.
- Replace core node search with Google results.
- Deliver search over content Google has already indexed.
