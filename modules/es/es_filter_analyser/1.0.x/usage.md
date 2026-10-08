<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
ElasticSearch Filter-Analyser Management lets you build ElasticSearch token filters and analysers as reusable Drupal config entities and have them injected automatically into your Search API / Elasticsearch Connector indexes, field mappings and search queries.

---

The module adds two config entity types — **ElasticSearch Filter** (`es_filter`) and **ElasticSearch Analyser** (`es_analyser`) — plus a Search API processor (`analyser_processor`). A filter maps one native ElasticSearch token filter (stemmer, synonym, edge n-gram, stop words, elision, ...) with its settings; an analyser bundles a tokenizer with an ordered list of those filters. On each affected index you enable the "ElasticSearch Analyser" processor and pick, per text field, an index analyser and/or search analyser (and optionally a global search analyser). When Elasticsearch Connector rebuilds the index or runs a query, three event subscribers translate the selected entities into the `analysis.filter` / `analysis.analyzer` index settings, into per-field `analyzer` / `search_analyzer` mappings, and into a query-time `analyzer`. Everything is authored in the Drupal admin UI and stored as configuration, so analysis chains are exportable and version-controllable instead of hand-edited into index mappings. Administration is gated by the `administer es_filter_analyser` permission. Requires `elasticsearch_connector` and `search_api`; runs on Drupal 10, 11 and 12.

---

- Define reusable ElasticSearch token filters as Drupal config entities.
- Configure a stemmer filter and choose its language (english, french, german, ...).
- Configure synonym and synonym_graph filters from a textarea of rules.
- Configure edge n-gram / n-gram filters for autocomplete-style partial matching.
- Configure stop-word, elision, keyword-marker and stemmer-override filters.
- Configure ASCII folding to make accented text match unaccented queries.
- Assemble multiple filters, in a drag-and-drop weighted order, into one analyser.
- Pick an ElasticSearch tokenizer (standard, whitespace, keyword, ngram, icu, kuromoji, ...) per analyser.
- Assign a different index analyser and search analyser to each Search API text field.
- Set a global search analyser applied to all queries unless a field overrides it.
- Inject filters and analysers into the index `analysis` settings automatically on rebuild.
- Inject per-field `analyzer` / `search_analyzer` into the ElasticSearch field mapping.
- Inject a `search_analyzer` into match / multi_match / query_string / match_phrase queries at search time.
- Export analysis configuration between environments as normal Drupal config.
- Improve multilingual search relevance with language-specific stemming and elision.
- Manage synonyms centrally and reuse them across several analysers.
- Avoid hand-editing ElasticSearch index mappings or connector plugin code.
- Reuse one filter (for example "lowercase") across many analysers.
- Ship starter French text analyser, elision and lowercase configuration on install.
- Build accent-insensitive and case-insensitive search behaviour.
- Restrict analyser/filter administration to trusted roles via a dedicated permission.
