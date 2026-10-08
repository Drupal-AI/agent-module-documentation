Search API is a generic, backend-agnostic search framework for Drupal that lets you index entities (and other data) and run structured, faceted, full-text searches against pluggable backends such as a database or Apache Solr.

---

Search API decouples *what* you search from *how* it is stored: you define one or more **indexes** (config entities) that pull content from **datasources** (typically content entities), attach **fields** to index, run indexed data through a pipeline of **processors** (tokenizing, HTML filtering, stemming, aggregated fields, boosting, etc.), and store it on a **server** (config entity) backed by a **backend** plugin. Queries are built with a fluent `QueryInterface` (keys, condition groups, sorts, ranges, tags, parse modes) and executed against the index, returning a `ResultSet` of loaded items. A **tracker** plugin keeps a queue of which items are new, changed, or deleted so indexing can run incrementally via cron, a batch, Drush, or a post-request handler. It integrates deeply with Views (a Search API query type and displays), and its **display** plugins let contrib modules like Facets and Search API Autocomplete attach to a specific search. Everything is exportable configuration, so indexes and servers deploy cleanly between environments. The module ships a Database backend submodule and is the foundation for the Solr, Elasticsearch, and many other search integrations.

---

- Build a site-wide full-text search page over nodes, users, and taxonomy terms.
- Index content entities and expose them through a Views-based search results page.
- Swap the search backend (Database → Solr) without changing your search UI.
- Add faceted search (by category, date, author) via the Facets module on a display.
- Provide autocomplete suggestions on a search box via Search API Autocomplete.
- Index only specific bundles or fields of an entity type.
- Combine multiple entity types into one unified search index.
- Boost certain fields (e.g. title) so matches there rank higher.
- Add a fulltext "rendered HTML" field that indexes the display output of an entity.
- Strip HTML, tokenize, transliterate, and stem text with processors before indexing.
- Ignore stop-words or apply a stemmer/ngram processor for better recall.
- Aggregate several fields into one searchable field (e.g. title + body).
- Incrementally index new and changed content via cron using a tracker queue.
- Bulk-index or re-index an entire site from the command line with Drush.
- Filter results with condition groups (AND/OR) and range/pagination.
- Sort results by relevance, date, or any indexed field.
- Restrict a search to specific languages on a multilingual site.
- Tag queries and alter them programmatically with hooks.
- Expose a search index to a decoupled/headless front end via a custom query.
- Implement a custom backend plugin for a new search engine.
- Write a custom processor to clean or enrich indexed data.
- Add a custom datasource to index non-entity data (e.g. external records).
- Track indexing status and clear/rebuild the tracker when data drifts.
- Mark a server read-only to freeze indexing during deployments.
- Deploy indexes and servers as exportable configuration between environments.
- Report indexing progress and item counts in the admin overview UI.
- Attach relevance-based "More like this" or related-content queries.
- Enable partial-match / substring search through the database backend options.
- Restrict search administration to trusted roles via permissions.
