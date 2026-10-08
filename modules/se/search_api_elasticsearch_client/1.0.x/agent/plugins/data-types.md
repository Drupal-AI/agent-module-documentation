<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Data types, processor & field mapping

## Search API data types (`src/Plugin/search_api/data_type/`)

Each is a `@SearchApiDataType`. IDs and their Elasticsearch mapping (see `FieldMapper::mapFieldProperty()`):

- `search_api_elasticsearch_client_object` (ObjectDataType) — `object` → ES `nested`.
- `geo_point` (GeoPointDataType) — ES `geo_point` (requires the `geofield` dependency).
- `search_api_elasticsearch_client_completion` (CompletionDataType) — completion suggester field.
- `search_api_elasticsearch_client_ngram` (NgramDataType) — ES `text` with analyzer `Ngram::PLUGIN_ID`.
- `search_api_elasticsearch_client_edge_ngram` (EdgeNgramDataType) — ES `text` with analyzer
  `EdgeNgram::PLUGIN_ID`.
- `search_api_elasticsearch_client_search_as_you_type` (SearchAsYouTypeDataType) — ES `search_as_you_type`.
- `search_api_elasticsearch_client_text_spellcheck` (SpellcheckTextDataType) — text for spellcheck/suggest.
- `search_api_elasticsearch_client_rank_feature` (RankFeature) — ES `rank_feature`.
- `search_api_elasticsearch_client_date_range` (DateRangeDataType) — ES `date_range`
  (`strict_date_optional_time||epoch_second`).
- `elasticsearch_date_range` (ElasticsearchDateRangeDataType) — ES `date_range` (`epoch_second`).

`ElasticSearchBackend::supportsDataType()` returns TRUE for any type whose id starts with
`search_api_elasticsearch_client_`, plus whatever a `SupportsDataTypeEvent` subscriber approves.
`getSupportedDataTypes()` also reports `object` and `geo_point`.

## Processor

- `DateRange` (`src/Plugin/search_api/processor/DateRange.php`, id
  `search_api_elasticsearch_client_date_range`) — a `@SearchApiProcessor` that prepares daterange
  field values for indexing as ES date ranges.

## hook_search_api_field_type_mapping_alter

`search_api_elasticsearch_client.module` maps Drupal core data types to Search API types:
`object → object`, `geo_point → geo_point`, `daterange → search_api_elasticsearch_client_date_range`,
`elasticsearch_date_range → elasticsearch_date_range`.

## FieldMapper (`src/SearchAPI/FieldMapper.php`)

`mapFieldParams($indexId, $index)` builds the ES `putMapping` body: a fixed `id` keyword property
plus one property per index field (index fields + the "magic" `search_api_id`,
`search_api_datasource`, `search_api_language` string fields). `mapFieldProperty()` is the
`match($type)` table that turns each Search API/ES type into an ES mapping — e.g. `text` →
`text` with a `keyword` sub-field (`ignore_above: 256`); `string`/`uri`/`token` → `keyword`;
`integer`/`duration` → `integer`; `decimal` → `float`; `boolean` → `boolean`; `date` → `date`;
`location` → `geo_point`. A `FieldMappingEvent` (per field) and an `AlterMappingEvent` (whole
mapping) let subscribers override the result.
