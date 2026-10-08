Elasticsearch Connector Autocomplete adds an ngram (or edge-ngram) analyzer to a Search API Elasticsearch index and a `text_ngram` Fulltext data type, so autocomplete and search return results on partial words instead of requiring whole words.

---

Out of the box, Search API + Elasticsearch Connector index whole words, so autocompletion returns nothing until a full word is typed. This module hooks the Search API index forms (`hook_form_search_api_index_form_alter`) to add an *Elasticsearch specific index options* section with an "Enable ngram analyzer" checkbox plus ngram config (type = `edge_ngram`/`ngram`, `min_gram` default 3, `max_gram` default 20), stored as `elasticsearch_connector` third-party settings on the index entity. When enabled it also exposes a **Fulltext (ngram)** Search API data type (`text_ngram`, `src/Plugin/search_api/data_type/TextNgramDataType.php`, fallback `text`) selectable per field on the index Fields form. An event subscriber (`DefaultSubscriber`) listens to `elasticsearch_connector.prepare_index` (injects a custom `ngram_filter` + `ngram_analyzer` into the index analysis settings) and `elasticsearch_connector.prepare_index_mapping` (maps `text_ngram` fields to a `text` type with `analyzer: ngram_analyzer`, `search_analyzer: standard`, and a `keyword` sub-field). Changing the analyzer on an existing index triggers a confirmation step warning that the index will be deleted, rebuilt, and must be re-indexed. Requires `elasticsearch_connector` (`^8.0@alpha`) and `search_api`; no config UI route, permissions, or Drush of its own.

---

- Enable partial-word / typeahead autocomplete on an Elasticsearch-backed Search API index.
- Return search results as the user types the first few characters of a word.
- Add an edge-ngram analyzer for prefix matching (matches from the start of words).
- Add a standard ngram analyzer for substring matching anywhere in a word.
- Tune minimum gram length (`min_gram`) to control the shortest matchable fragment.
- Tune maximum gram length (`max_gram`) to bound token size and index growth.
- Apply the `text_ngram` Fulltext data type to specific fields (title, name) needing autocomplete.
- Keep other fields on standard fulltext while only ngram-indexing autocomplete fields.
- Improve `search_api_autocomplete` suggestions for Elasticsearch indexes.
- Boost ngram fields relative to others via the per-field boost select.
- Get a `keyword` sub-field automatically for exact-match/sorting alongside the ngram text.
- Roll out ngram search on an existing index with an explicit rebuild confirmation step.
- Provide better search UX for product names, usernames, or tags with partial input.
- Support search-as-you-type across multilingual content on Elasticsearch.
- Avoid writing custom Elasticsearch analysis JSON by configuring it through the index form.
- Disable ngram analysis per index by unchecking the option (hides the `text_ngram` type again).
- Standardise the ngram analyzer name (`ngram_analyzer`) across indexes for consistency.
- Reduce "no results until full word" complaints in site search.
- Combine ngram indexing with Elasticsearch's standard search analyzer at query time.
- Migrate a whole-word search index to partial-word matching without leaving the Drupal UI.
