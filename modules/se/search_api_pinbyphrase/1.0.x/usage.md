<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Search API PinByPhrase promotes specific nodes to the top for configured query phrases.

---

Search API PinByPhrase pins a node to the top of search results when the search query matches an expected phrase — so editors can promote specific content (featured pages, answers) for particular queries, similar to 'best bets' in enterprise search. It works with Search API Solr.

Administration is gated by `administer search_api_pinbyphrase`. Depends on `search_api` and `search_api_solr`; supports Drupal 10.3+ and 11.

---

- Pin nodes for matching phrases.
- Promote content to the top.
- Support 'best bets'.
- Feature specific answers.
- Match query phrases.
- Work with Search API Solr.
- Gate admin with `administer search_api_pinbyphrase`.
- Depend on `search_api` and `search_api_solr`.
- Support Drupal 10.3+ and 11.
- Configure pinned phrases.
- Boost relevance editorially.
- Promote featured pages.
- Support curated results
- Handle query matching
- Improve findability.
- Pin results.
- Support editors.
- Curate search
