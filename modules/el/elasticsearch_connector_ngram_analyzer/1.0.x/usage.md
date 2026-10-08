<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Adds an n-gram analyzer and a "Text Ngram" Search API data type to Elasticsearch Connector indexes so searches match partial words and substrings.

---

Elasticsearch Connector Ngram analyzer extends the Elasticsearch Connector module with n-gram tokenization for Search API. It registers a "Text Ngram" data type (machine name `text_ngram`) that you assign to text fields on a Search API index, and an `ngram_analyzer` Elasticsearch analyser that produces fixed 3-character grams (min_gram and max_gram both 3, over letters and digits) lowercased. Event subscribers wire everything together automatically: one injects the analyzer and `es_ngram` tokenizer into the index's Elasticsearch settings, another maps every `text_ngram` field to an Elasticsearch `text` field using the ngram analyzer (plus a `keyword` sub-field capped at 256 characters), and a third normalises incoming query strings (stripping ` AND` and `~`, forcing the default operator to `AND`). There are no config forms, routes, permissions, or Drush commands — you enable it per field in the Search API index Fields tab and then reindex. It depends on `elasticsearch_connector` and requires `search_api`.

---

- Enable substring/partial-word matching on an Elasticsearch-backed Search API index.
- Match a query like "sear" against the term "search" without wildcards.
- Power autocomplete/typeahead search boxes with n-gram matching.
- Provide "search as you type" behaviour on product names.
- Find people by a fragment of a name in a directory search.
- Match SKUs or part numbers by an embedded substring.
- Improve matching for compound words and long tokens.
- Tolerate partial spellings in a site-wide search block.
- Apply n-gram tokenization to a specific text field only, leaving other fields on their normal analyzers.
- Add a dedicated "Text Ngram" field type option to a Search API index's Fields tab.
- Keep an exact-match `keyword` sub-field alongside the n-gram text for sorting or filtering.
- Force AND semantics so multi-term queries narrow rather than broaden results.
- Clean up stray ` AND` / `~` characters from user-entered query strings before they hit Elasticsearch.
- Reuse the shared `ngram_analyzer` definition across multiple fields on the same index.
- Inject a custom analyzer into Elasticsearch index settings without hand-editing mappings.
- Combine full-text and partial-match fields in one search index.
- Support faceted or filtered search where the free-text field needs substring matching.
- Prototype fuzzy-feeling search quickly without configuring a synonyms or stemming pipeline.
- Serve multilingual or transliterated content where whole-word matching is too strict.
- Improve recall on short queries against large text bodies.
- Drive a "did you mean / partial" search experience on a knowledge base.
- Index catalog descriptions so substring queries return relevant items.
- Let editors find nodes by typing part of a title.
- Provide n-gram matching for a Views-driven Search API display.
