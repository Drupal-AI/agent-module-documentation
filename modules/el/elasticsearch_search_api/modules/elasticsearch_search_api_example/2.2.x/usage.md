<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Elasticsearch - Search API Example is a submodule of elasticsearch_search_api that provides a complete, working reference implementation of the framework: a live faceted search page at /example/search over an "Elasticsearch page" node type.

---

Elasticsearch - Search API Example wires the parent framework end to end so you can see it run or copy it as a scaffold. It ships real services.yml and routing.yml (routes `/example/search`, `/example/search/filter`, `/example/search/autocomplete`), an `ExampleSearchController` extending the base controller, an `ExampleElasticSearchParamsBuilder` that multi-matches all fulltext fields with boosting, ngram sub-fields, quoted-phrase and highlight support, a hierarchical `page_type` taxonomy facet, and installed config for the `elasticsearch_page` content type, the `page_type` vocabulary and the `example_general` Search API index (server `elastic`). Enable it after creating an elasticsearch-connector cluster and a Search API server named `elastic`, then add "Elasticsearch page" nodes to populate the search. It is a demo/starting point, not a standalone production feature.

---
- See the Elasticsearch - Search API framework working out of the box.
- Copy it as the scaffold for a new custom search module.
- Get a live faceted search page at /example/search.
- Study how to extend SearchController for a real page.
- Study a multi-field multi_match query with per-field boosting.
- See ngram sub-field querying and quoted-phrase matching.
- See ES result highlighting wired into a Drupal page.
- Implement a hierarchical taxonomy facet (page_type).
- Learn the services.yml wiring the framework expects.
- Get an installable Search API index example (example_general).
- Get an example content type and vocabulary for search.
- Reference the autocomplete route/controller setup.
- Compare your own implementation against a known-good one.
- Bootstrap a demo Elasticsearch search quickly.
- Disable it once your own search module is built.
