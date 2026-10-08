<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
A Manticore Search backend for Search API.

---

Search API Manticore offers an implementation of the Search API that uses a Manticore Search server for indexing and searching content — so a site can use Manticore (a fast, lightweight open-source search engine) as its Search API backend instead of database/Solr/Elasticsearch. It connects over Manticore's HTTP JSON API through the official `manticoresoftware/manticoresearch-php` SDK, and appears as a backend option when adding a Search API server.

Configuration is entirely admin-only Search API server and index config: a server holds the Manticore URL and optional HTTP Basic Auth (username plus a Key entity that stores the password), and each index maps to one Manticore table. Beyond classic full-text search, the 1.2.x series adds facets, autocomplete, spellcheck, More Like This / semantic / hybrid vector search using Manticore's engine-side auto-embeddings, and location & geospatial search (radius filter, distance sort, and optional server-side geohash clustering). Depends on core `key`, `language`, and `search_api`; supports Drupal 10.5+/11 and PHP 8.3+.

---

- Use Manticore as a Search API backend.
- Index any Search API datasource into a Manticore table.
- Provide high-performance full-text search over Views and the query API.
- Replace database, Solr, or Elasticsearch backends.
- Store the Manticore Basic Auth password in a Key entity.
- Connect to Manticore over its HTTP JSON API.
- Build search pages with Views on a Manticore-backed index.
- Add faceted search with the Facets module (AND or OR operator).
- Facet multi-value fields with per-element counts.
- Offer keyword autocomplete (with Search API Autocomplete + infix indexing).
- Offer "did you mean" spellcheck suggestions (with Search API Spellcheck).
- Provide More Like This / related-items via vector similarity.
- Run semantic search that matches by meaning rather than exact words.
- Run hybrid search fusing keyword and semantic relevance.
- Use engine-side auto-embeddings so Drupal never computes or sends a vector.
- Filter and sort on all six built-in Search API field types.
- Do radius (proximity) filtering on latitude/longitude fields.
- Sort results closest-first with a per-document distance field.
- Cluster many map points into server-side geohash cells.
- Shuffle results with the Global: Random sort criterion.
- Restrict full-text search per language on multilingual indexes.
- Subscribe to six write-path lifecycle events around indexing and deletion.
- Set per-index table settings (morphology, field lengths, infix length).
- Share one Manticore engine across sites with a table prefix.
- Support Drupal 10.5+, Drupal 11, and PHP 8.3+.
