<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Backend plugin & data types

## Backend plugin

`Drupal\search_api_typesense\Plugin\search_api\backend\SearchApiTypesenseBackend`
(`@SearchApiBackend(id = "search_api_typesense")`), extends `BackendPluginBase`, implements
`PluginFormInterface`. Injects `http_client`, `config.factory`, `entity_type.manager`,
`search_api_typesense.document_splitter`, `event_dispatcher`.

Key Search API methods:

- `indexItems($index, $items)` — builds a Typesense document per item via
  `TypesenseClient::prepareItemValue()` (enforces the `typesense_*` type; multi-value only for `[]`
  types); renames a field literally named `id` to `search_api_id`; document id via `prepareId()`
  (replaces `/` with `-`). If the schema has embeddings enabled, deletes prior chunks
  (`filter_by document_id:=…`), splits fields with the document splitter, and upserts one document per
  chunk; otherwise upserts one document.
- `deleteItems()` / `deleteAllIndexItems()` — per-id delete (or per-`document_id` filter when
  embedding); "delete all" drops+recreates the collection and re-imports synonyms/curations.
- `updateIndex()` — reindexes: exports collection data, drops, re-syncs, re-imports.
- `removeIndex()` — drops the collection.
- `search($query)` — only handles the `server_index_status` tag (returns collection doc count). Normal
  search is NOT executed server-side / not via Views — it happens in the browser via InstantSearch
  (see [../blocks/search-block.md](../blocks/search-block.md)).
- `getSupportedFeatures()` = `[]`; `getDiscouragedProcessors()` = snowball_stemmer, stemmer, stopwords,
  tokenizer; `supportsDataType($t)` = `str_starts_with($t, 'typesense_')`.
- `viewSettings()` — shows per-collection name/created/doc-count plus server health and version.

Helpers used by the render service / block: `getCollectionSpecificSearchParameters()` (query_by,
query_by_weights, sort_by), `getCollectionRenderParameters()`, `getFacetsForCollection()`,
`getSchemaForIndex()` (loads the `typesense_schema` config entity keyed by index id;
`getSchema(string)` is deprecated).

## typesense_schema config entity

`Drupal\search_api_typesense\Entity\TypesenseSchema` (`@ConfigEntityType id = "typesense_schema"`,
`config_prefix = typesense_schema`, `admin_permission = administer search_api`, form
`Form\SchemaForm`). `config_export`: id, default_sorting_field, fields, enable_embedding,
embedding_fields, embedding_model, chunk_prepend_fields, chunk_size, chunk_overlap_size.

- `getSchema(): array` — builds the Typesense collection schema payload. Per-field properties: type,
  facet, optional, index, store, sort, sort_type, infix, locale, stem, weight. Omits
  `default_sorting_field` when it equals `-none-`. When AI support is available and embedding is
  enabled, appends `chunk` (string), `document_id` (string, faceted) and `embedding` (`float[]` with
  `embed.from=[chunk]` and `model_config` from `AiModels::getEmbeddingModelConfig()`). Dispatches
  `TypesenseSchemaEvents::ALTER_SCHEMA` (`TypesenseSchemaEvent`) before returning.
- `isEmbeddingEnabled()`, `getFields()`, `getDefaultSortingField()`, `getStringFields()`,
  `equals()`.

## Data type plugins

`src/Plugin/search_api/data_type/`: `StringDataType`, `Int32DataType`, `Int64DataType`,
`FloatDataType`, `BoolDataType`, `GeopointDataType`, and `*MultiDataType` variants
(`typesense_string[]`, `typesense_int32[]`, `typesense_int64[]`, `typesense_float[]`,
`typesense_bool[]`). `FacetFieldType` enum (`src/Enum/FacetFieldType.php`) maps facet widgets to
Typesense types.

## Document splitter (embeddings)

`FixedLengthDocumentSplitter` (service `search_api_typesense.document_splitter`, implements
`DocumentSplitterInterface`) splits selected embedding fields into `Chunk` objects using the schema's
`chunk_size` / `chunk_overlap_size`, with `chunk_prepend_fields` prepended to every chunk. Splitter
instances are `document_splitter` config entities at `/admin/structure/document-splitter`.
