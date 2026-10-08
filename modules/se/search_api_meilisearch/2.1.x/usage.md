<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Search API Meilisearch adds Meilisearch as a Search API backend, with submodules for autocomplete and facets.

---

The Search API backend choice has been Solr or Elasticsearch for a decade, and both are capable and heavy — a JVM, a schema, a memory allocation measured in gigabytes and an operational burden a small team feels. Meilisearch is the newer, lighter option: a single Rust binary with no JVM, sensible defaults, and typo tolerance and prefix search turned on by default rather than configured in — the "search as you type, forgive my spelling" behaviour users now expect and the one that takes the most work to get right on Solr. This module supplies the Search API integration: it registers a `search_api_meilisearch` backend plugin that talks to the Meilisearch HTTP API through the official `meilisearch/meilisearch-php` SDK (wrapped over Drupal's Guzzle client), creating and deleting indexes, pushing documents on index, and translating Search API queries — conditions, sorts, boosts, facets — into Meilisearch filter expressions and options. Connection settings live on the Search API **server** entity: a host address, a port, and a single **Master Key** field (default `http://127.0.0.1:7700`, empty key). Two processors ship in the main module (Synonyms, Language filter), and the `search_api_meilisearch_autocomplete` and `search_api_meilisearch_facets` submodules cover the two features a site notices immediately if they are missing. Version **2.1.0** on core `^9.3 || ^10 || ^11`, depending on `search_api`. Three things to establish before committing. **Facets and complex filtering** are where lighter engines historically fall short of Solr, so test the site's actual facet set rather than a simple keyword query. **Scale**: Meilisearch holds its index in memory, which is what makes it fast and what makes a very large corpus an infrastructure question rather than a configuration one. And **access**: the Meilisearch server must not be reachable from the internet, and the key Drupal stores should be a scoped, search-only key rather than a true master key wherever the deployment allows — the standard mistake with every search server, and the reason exposed instances turn up in scans.

---

- Add search to a site without running Solr or Elasticsearch.
- Get typo-tolerant search by default.
- Add search-as-you-type / autocomplete to a search box.
- Replace a heavy JVM-based search stack with a single Rust binary.
- Reduce search infrastructure cost and memory footprint.
- Add faceted search (via the facets submodule) on a small site.
- Improve search relevance on a documentation or knowledge-base site.
- Index a product catalogue for a fast product finder.
- Add search to a decoupled / headless front end.
- Run search on a single small server.
- Improve relevance without hand-tuning a schema.
- Index multilingual content and filter results by language.
- Configure synonyms so alternate labels match the same phrase.
- Configure stop words to drop noise terms from indexing.
- Sort and filter results using Search API conditions and boosts.
- Prototype search quickly before committing to a heavier engine.
- Replace core search with a faster, more forgiving engine.
- Reduce the operational burden of maintaining a search cluster.
- Boost specific fulltext fields so title matches outrank body matches.
- Randomize result order for a "featured / shuffle" listing.
