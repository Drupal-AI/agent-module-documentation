Adds an Elasticsearch (8+) backend to Search API so Drupal indexes and queries content against an external Elasticsearch cluster over its official PHP client.

---

Search API ElasticSearch Client registers a Search API backend plugin (`elasticsearch_client`) that connects to an Elasticsearch cluster (version 8 or newer, including OpenSearch-compatible endpoints) using the official `elasticsearch/elasticsearch` PHP client, which you install yourself via Composer so you control the client version. On a Search API server you pick a connector (a "Standard" no-auth connector or an "HTTP Basic Authentication" connector), give it the cluster URL, and optionally set fuzziness, an index prefix, and Solr-format synonyms. The backend creates one Elasticsearch index per Search API index, maps Drupal/Search API field types to Elasticsearch mappings, translates Search API queries (full text via a Lucene `query_string`, filters, sorts, ranges) into Elasticsearch request bodies, and parses results back into Search API result sets. It supports facets (including OR facets), More Like This, and spellcheck/suggestions, plus custom data types for ngram, edge-ngram, search-as-you-type, completion, geo point, object/nested, rank feature, and date range. A connector plugin type and an analyser plugin type let other modules extend authentication and analyzer behavior, and a rich set of events lets you alter mappings, settings, and query params. It is derived from the Search API OpenSearch module.

---

- Index Drupal nodes, users, taxonomy terms, or any Search API datasource into an external Elasticsearch cluster instead of the database or Solr.
- Connect Drupal to a managed Elasticsearch service (Elastic Cloud, self-hosted, or an OpenSearch endpoint on the ES 8 API) as the Search API server backend.
- Serve site search from Elasticsearch with a Search API + Views search page and exposed filters.
- Add faceted search (checkbox/select facets, including "OR" facets) backed by Elasticsearch aggregations via the Facets module.
- Provide "More Like This" related-content blocks driven by Elasticsearch MLT queries.
- Offer spellcheck / "did you mean" query suggestions on a search results page.
- Run the same cluster for several sites or environments by setting a per-server index prefix.
- Tune inexact matching by choosing a fuzziness level (auto, disabled, or 1–5) for full-text queries.
- Improve recall with synonyms entered in Solr `synonyms.txt` format applied at index settings level.
- Add autocomplete/typeahead by indexing a search-as-you-type or completion field type.
- Support partial-match and infix search by mapping fields to ngram or edge-ngram analyzers.
- Index and query geospatial data (geo_point) for proximity or bounding-box search, using the required geofield dependency.
- Index nested/object structures with the object (nested) data type for structured documents.
- Boost documents with rank-feature fields (e.g. popularity or freshness signals) in relevance scoring.
- Index and filter on date-range fields using dedicated Elasticsearch date_range mappings.
- Authenticate to a secured cluster with HTTP Basic Authentication (username/password) via the built-in basicauth connector.
- Extend authentication (API key, cloud ID, custom headers, TLS options) by writing a custom connector plugin implementing `ElasticSearchConnectorInterface`.
- Customize index field mappings, analyzers, or query bodies at runtime by subscribing to the module's alter events (mapping, settings, query params, base params, delete params, field mapping).
- Keep field mappings in sync automatically: the backend detects incompatible mapping changes and reindexes only when needed.
- Migrate an existing Search API Solr or database-backed setup to Elasticsearch by swapping the server backend and reindexing.
- Support multilingual search by letting the backend add language conditions to queries per index language.
- Exclude large source fields from result payloads with the `elasticsearch_exclude_source_fields` query option for lighter responses.
- Use Drupal Views as the query builder against Elasticsearch, including sorts, range filters, and IN/NOT IN conditions.
