<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Elasticsearch - Search API is a framework for building custom Elasticsearch-backed search pages on top of Search API and elasticsearch_connector, supplying services, an extendable controller and search form, faceted-search plumbing, index sync strategies (n-gram, autosuggest, did-you-mean, synonyms), and themeable templates.

---

Elasticsearch - Search API is not a turnkey Search API backend but a developer framework: it ships routing, services, permissions and drush definitions as `.example` files that you copy into your own module, then extend its `SearchController`, `SearchForm`, `ElasticSearchParamsBuilder`, facet controls and `SyncStrategy` classes to build a tailored Elasticsearch search page. The connection, cluster and index live in elasticsearch_connector and Search API; this module adds the query-building, faceting, autocomplete, did-you-mean, synonym and keymatch layers plus AJAX pagination. Its `elasticsearch_search_api_example` submodule is a complete working reference (a live `/example/search` page with a hierarchical taxonomy facet), and `esa_pager` provides the custom AJAX/Views pager.

---
- Build a custom Elasticsearch search page from a framework rather than configuring a backend.
- Extend SearchController for a bespoke result page.
- Add an AJAX faceted search over a taxonomy vocabulary.
- Render a hierarchical taxonomy facet with counts.
- Add autocomplete/typeahead to a search box.
- Add a "did you mean" spelling suggestion.
- Configure synonyms that rewrite queries at search time.
- Pin curated links to the top of results with keymatches.
- Copy the fulltext of every field into one custom_all field to simplify querying.
- Add an n-gram sub-field to titles for partial-word matching.
- Provide a reusable search-form block for the site header.
- Redirect a header search box to a results route.
- Trim and strip tags from body text for result snippets.
- Reindex and re-apply analyzers via a drush command.
- Re-run index sync strategies on cron.
- Alter ES index settings and mappings via elasticsearch_connector events.
- Use the example submodule as a starting scaffold for a new search module.
- Serve faceted, paged, relevance-ranked results from Elasticsearch.
- Filter results to published, current-language content by default.
- Add a custom AJAX pager to a search page.
- Query multiple fulltext fields with per-field boosting.
- Support quoted-phrase matching in the keyword box.
- Give a taxonomy-term facet single- or multi-select behavior.
- Show active-filter chips with per-filter removal links.
