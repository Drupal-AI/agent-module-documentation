<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Search API OpenSearch provides an OpenSearch backend plugin for the Search API module, letting Drupal index content into an OpenSearch cluster and run full-text search, facets, More Like This and spellcheck against it via the official OpenSearch PHP client.

---

The module registers a Search API backend plugin with id `opensearch`. You create a Search API server, choose the OpenSearch backend, and configure a **connector** plugin that knows how to reach the cluster: `standard` (no auth), `basicauth` (HTTP basic auth), or `aws_signature` (from the AWS Signature submodule). The connector holds the cluster `url` and options like `ssl_verification`; the backend adds `advanced` settings for default query `fuzziness`, an index `prefix`, and `synonyms`. Indexing and querying are delegated to a set of builder/parser services (IndexParamBuilder, QueryParamBuilder, FieldMapper, FacetParamBuilder, MoreLikeThisParamBuilder, SpellCheckBuilder, and result parsers) that translate Search API operations into OpenSearch DSL and back. It defines two custom plugin types via attribute-based managers: **OpenSearch connectors** (`opensearch_connector`) and **OpenSearch analysers** (`opensearch_analyser`, shipping `ngram` and `edge_ngram`). It also adds several Search API data types (ngram, edge_ngram, search_as_you_type, rank_feature, date_range, object, text_spellcheck) and a DateRange processor. A rich set of dispatched events (FieldMappingEvent, IndexParamsEvent, QueryParamsEvent, AlterSettingsEvent, BeforeIndexCreateEvent, SupportsDataTypeEvent, ClientOptionsEvent, etc.) and a `hook_index_param_value_alter()` hook let other modules customise mappings, index/query params and client options. Two submodules extend it: `search_api_aws_signature_connector` (AWS-signed connector) and `search_api_opensearch_location` (a `location`/geo_point data type). It requires an actual OpenSearch cluster plus the `opensearch-project/opensearch-php`, `makinacorpus/php-lucene` and Guzzle libraries; it is heavily based on the Elasticsearch Connector module.

---

- Use OpenSearch as the search backend for a Search API index instead of the database or Solr.
- Index Drupal content (nodes, media, users, taxonomy) into an OpenSearch cluster.
- Run full-text search over indexed content backed by OpenSearch.
- Connect to a self-hosted OpenSearch cluster with the standard (no-auth) connector.
- Connect to a secured cluster using HTTP basic authentication (basicauth connector).
- Connect to Amazon OpenSearch Service using AWS Signature v4 (aws_signature submodule).
- Configure default query fuzziness (e.g. AUTO) for typo-tolerant search.
- Prefix all index names for a server so multiple sites share one cluster safely.
- Provide synonyms to the backend so related terms match at query time.
- Power faceted search UIs (via the Facets module) against OpenSearch.
- Offer "More Like This" related-content queries from OpenSearch.
- Add spellcheck / "did you mean" suggestions using the spellcheck data type and builder.
- Enable search-as-you-type / autocomplete via the search_as_you_type data type.
- Use ngram or edge_ngram analysers for partial-word and prefix matching.
- Boost documents with a rank_feature field for relevance tuning.
- Index date-range fields using the date_range data type and processor.
- Index nested/object structures with the object data type.
- Add a custom connector plugin to reach a cluster behind a bespoke auth scheme.
- Add a custom OpenSearch analyser plugin for specialised tokenisation.
- Alter field mappings before index creation via the FieldMappingEvent.
- Alter index or query parameters (OpenSearch DSL) via IndexParamsEvent / QueryParamsEvent.
- Modify OpenSearch client options (e.g. timeouts, TLS) via the ClientOptionsEvent.
- Declare support for additional Search API data types via the SupportsDataTypeEvent.
- Index geospatial (geofield) data as geo_point using the location submodule.
- Silence the noisy OpenSearch PHP client by overriding its logger channel to a NullLogger.
- Migrate an Elasticsearch Connector setup to OpenSearch with a similar architecture.
- Share one OpenSearch server across several Search API indexes.
- Store the cluster URL/credentials in settings.php via config overrides for per-environment config.
