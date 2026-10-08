<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Elasticsearch Connector adds an "elasticsearch" backend plugin to Search API, letting a Drupal site index and query content on a real Elasticsearch (8/9) cluster instead of Database Search or Solr.

---

The module is a Search API backend, not a standalone search UI: you still build indexes, fields, and views through Search API, but point the server's backend at `elasticsearch`. Talking to the cluster is delegated to a small "connector" plugin type the module defines (`elasticsearch_connector`, `@ElasticSearchConnector`), each of which builds an `Elastic\Elasticsearch\Client` a different way: `standard` (bare URL), `basicauth` (URL + username/password, extends `standard`), `elastic_cloud_id` (Elastic Cloud ID + API key), and `elastic_cloud_endpoint` (endpoint URL + API key). The backend's own "advanced" settings add query fuzziness, an index name prefix/suffix (useful for sharing one cluster across environments), and Solr-style synonyms, all translated into Elasticsearch request parameters by the module's field mapper and query/param builders. Two Search API processor plugins ship alongside the backend: `elasticsearch_type_boost` (query-time boosting by datasource/bundle) and `elasticsearch_highlight` (excerpts via Elasticsearch's native highlighter). The module also defines a second, currently-unused plugin type, `elasticsearch_analyser` (`@ElasticSearchAnalyser`), for customizing text-analysis settings at index-creation time. None of this works without an actual Elasticsearch cluster reachable over HTTP(S) and the underlying `elasticsearch/elasticsearch` and `makinacorpus/php-lucene` Composer libraries — the module ships no bundled search engine.

---

- Replace Database Search or Solr with a real Elasticsearch cluster as a Search API backend.
- Point a new `search_api.server` config entity at backend `elasticsearch` and index content through the normal Search API UI.
- Connect to a self-hosted Elasticsearch instance with no authentication via the `standard` connector.
- Connect to an Elasticsearch cluster protected by HTTP Basic Auth via the `basicauth` connector (username/password).
- Connect to Elasticsearch B.V.'s managed Elastic Cloud using a Cloud ID and API key via the `elastic_cloud_id` connector.
- Connect to an Elastic Cloud deployment by its endpoint URL and API key via the `elastic_cloud_endpoint` connector.
- Store the Elastic Cloud API key in a Key module entity instead of plain config, when `drupal/key` is installed.
- Share one Elasticsearch cluster across multiple environments by giving each `search_api.server` a distinct index prefix/suffix.
- Tune fuzzy matching (auto or 1-5 edit distance, or disabled) on a server's advanced settings.
- Load a Solr-format synonyms list so search treats configured word groups as equivalent.
- Add the `elasticsearch_type_boost` processor to an index to boost results by datasource and/or bundle at query time.
- Add the `elasticsearch_highlight` processor to surface Elasticsearch-generated excerpts on search result pages, instead of Search API's default excerpt highlighting.
- Configure highlighter behavior (fragment size, number of fragments, boundary scanner, pre/post tags, snippet joiner) via the `elasticsearch_highlight` processor's own settings.
- Enable request/response debug logging on a connector to troubleshoot connectivity or query problems.
- Write a custom connector plugin to support an authentication scheme the shipped connectors don't cover (e.g. mutual TLS, a custom API gateway).
- Write a custom analyser plugin to control Elasticsearch text-analysis settings applied when the module creates an index.
- Power faceted search UIs by pairing this backend with the `drupal/facets` module.
- Add search-box autocomplete on top of an Elasticsearch-backed index via `drupal/search_api_autocomplete`.
- Support geospatial/location queries against Elasticsearch content via `drupal/search_api_location`.
- Add spell-check / "Did you mean?" suggestions to an Elasticsearch-backed search via `drupal/search_api_spellcheck`.
- Index geometry/date-range/full-date-precision Search API field types using the module's dedicated Elasticsearch data-type mappings.
- Migrate an existing Solr- or Database-Search-backed site to Elasticsearch by swapping the server's backend plugin and re-indexing.
- Run a dedicated Elasticsearch cluster per content type or site section by creating multiple `search_api.server` entities, each with its own connector config.
- Programmatically build or audit a server's backend/connector configuration via Drupal config (`search_api.server.<id>`) instead of the admin UI.
- Diagnose which connector and URL a given search server actually uses by reading its `backend_config` config.
- Swap connectors on an existing server (e.g. moving from `standard` to `basicauth`) as an environment's security requirements change.
- Rely on the bundled `makinacorpus/php-lucene` library for parsing advanced Lucene-syntax search expressions.
- Stand up a throwaway or CI test server definition (as the module's own test fixtures do) purely from exported config, without ever touching the admin form.
