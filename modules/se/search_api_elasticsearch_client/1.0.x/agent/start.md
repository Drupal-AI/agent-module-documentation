<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Search API ElasticSearch Client (search_api_elasticsearch_client) — agent index

A **Search API backend** that indexes and queries against an **Elasticsearch 8+ cluster** using the
official `elasticsearch/elasticsearch` PHP client (which you install yourself via Composer — it is
**not** a module dependency). Package `Search`. Core `^9 || ^10 || ^11`, PHP 8.0+. License
GPL-2.0-or-later. Installed version 1.0.8. Ported from Search API OpenSearch.

- **Depends on** `search_api` and `geofield` (Drupal modules) + the `elasticsearch/elasticsearch`
  and `makinacorpus/php-lucene` PHP libraries. No permissions, no routes, no Drush, no `.install`.

## What it provides (from source)

- **Search API backend plugin** `elasticsearch_client` —
  `src/Plugin/search_api/backend/ElasticSearchBackend.php`. Config-only form (no dedicated route);
  configured on the Search API server. See [config/backend.md](config/backend.md).
- **Two plugin types it defines** (annotations in `src/Annotation/`, managers in
  `search_api_elasticsearch_client.services.yml`):
  - `ElasticSearchConnector` (dir `Plugin/ElasticSearchClient/Connector/`) → `standard`,
    `basicauth`. Builds the `Elastic\Elasticsearch\Client`.
  - `ElasticSearchAnalyser` (dir `Plugin/ElasticSearchClient/Analyser/`) → `ngram`, `edge_ngram`.
  - See [plugins/connectors.md](plugins/connectors.md).
- **Search API data types & one processor** (`src/Plugin/search_api/data_type/`,
  `.../processor/`) — object/nested, geo_point, completion, edge_ngram, ngram, search_as_you_type,
  text_spellcheck, rank_feature, two date_range types; processor `search_api_elasticsearch_client_date_range`.
  Field-type mapping in `src/SearchAPI/FieldMapper.php`. See [plugins/data-types.md](plugins/data-types.md).
- **The Search API client layer** (`src/SearchAPI/`) — `BackendClient` (index CRUD, bulk, search),
  `BackendClientFactory`, param builders (index/query/filter/sort/facet/MLT/spellcheck/delete) and
  result parsers. Fires alter **events** (`src/Event/`). See [api/backend-client.md](api/backend-client.md).

## Supported features / data types

- `getSupportedFeatures()`: `search_api_facets`, `search_api_facets_operator_or`, `search_api_mlt`,
  `search_api_spellcheck`. `getSupportedDataTypes()`: `object`, `geo_point`.
- `supportsDataType()` returns TRUE for any type prefixed `search_api_elasticsearch_client_`, plus
  anything a `SupportsDataTypeEvent` subscriber approves.

## Operate it

Install the ES PHP client (`ddev composer require elasticsearch/elasticsearch ^8.11`), enable the
module, create a Search API **server** using backend *Elasticsearch Client*, pick a connector, enter
the cluster URL, then attach indexes. Details in [config/backend.md](config/backend.md).
