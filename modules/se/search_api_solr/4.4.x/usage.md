Search API Solr connects Drupal's Search API to an Apache Solr server, providing a high-performance backend for full-text, faceted, and multilingual search over any indexed entity.

---

The module registers a Search API **backend plugin** (`SearchApiSolrBackend`) so you can create a Search API server that talks to Solr through the Solarium PHP library. Connectivity is handled by pluggable **SolrConnector** plugins (Standard, Basic Auth, Solr Cloud, Basic-Auth Cloud), letting you target self-hosted Solr, SolrCloud, or hosted providers. It ships language-specific Solr field types and configuration entities (`SolrFieldType`, `SolrCache`, `SolrRequestHandler`, `SolrRequestDispatcher`) that are compiled into a downloadable Solr config set (`schema.xml`, `solrconfig.xml`, etc.). It supports faceting, spatial/location search, autocomplete, spellcheck, "more like this", highlighting/snippets, streaming expressions, and Solr's block-join and multisite features. Multilingual sites get per-language analyzers and stemming out of the box. Site builders configure everything through the Search API server/index forms plus extra Solr-specific tabs; developers extend behavior via a rich set of alter hooks and events. Drush commands generate config sets, (re)install field types, finalize indexes, and run parallel indexing. It is the de-facto standard for serious search on Drupal.

---

- Index Drupal content into Apache Solr for fast full-text search.
- Replace the core database search backend with Solr for large sites.
- Connect to a self-hosted standalone Solr server via the Standard connector.
- Connect to SolrCloud clusters using the Solr Cloud connector.
- Authenticate to Solr with HTTP Basic Auth (standard or cloud).
- Provide faceted search when combined with the Facets module.
- Add autocomplete/typeahead to search boxes (with the autocomplete submodule).
- Offer "Did you mean?" spellcheck suggestions on search results.
- Build multilingual search with per-language stemming and analyzers.
- Generate and download a ready-to-use Solr config set (zip) for your server.
- Run location/spatial (geofield) searches and sort by distance.
- Highlight matched terms and return result snippets/excerpts.
- Implement "more like this" related-content queries.
- Boost fields, documents, or recent content to tune relevance.
- Execute Solr streaming expressions for analytics and advanced queries.
- Index and search across multiple Drupal sites (multisite) against one Solr.
- Add custom Solr field types via SolrFieldType config entities.
- Configure request handlers and dispatchers per server.
- Finalize an index (e.g. commit/optimize) before serving queries.
- Index content in parallel with multiple threads via Drush for speed.
- Alter Solr queries or documents programmatically through hooks/events.
- Add a custom SolrConnector plugin for a hosted Solr provider.
- Perform partial/fuzzy and ngram matching for better recall.
- Support NLP-based field types for smarter tokenization.
- Migrate search from Search API DB to Solr without changing app code.
- Debug the raw Solr requests/responses during development.
