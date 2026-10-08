<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Backend plugin — ElasticEnterpriseSearchBackend

`src/Plugin/search_api/backend/ElasticEnterpriseSearchBackend.php`
`@SearchApiBackend(id = "centarro_search_ees", label = "Elastic Enterprise Search (Centarro Search)")`
`extends BackendPluginBase implements PluginFormInterface` (uses `PluginFormTrait`).

Talks to Elastic **App Search** via `$client->appSearch()` using the `elastic/enterprise-search` client from
`getEnterpriseClient()` (cached in `$this->enterpriseClient`). `getSupportedFeatures()` returns
`search_api_facets` and `search_api_facets_operator_or`.

## Engine resolution

- `getEngineName(IndexInterface)` — returns the index third-party setting `centarro_search.engine`, else falls back
  to `str_replace('_', '-', $index->id())`.
- `ensureEngine(IndexInterface)` — `GetEngine`; on exception, logs it and creates a `default`-type engine via
  `CreateEngine`. Called from `updateIndex()`.

## Indexing (`indexItems`)

- Builds a document per item with `id`, `search_api_language`, `search_api_datasource`, plus each field's values.
- Value coercion in `array_map`: `TextValueInterface` -> `toText()`; `bool` -> `int` (App Search has no boolean
  filtering); `date` numeric values -> `date('c', ...)` (ISO-8601). Single-value fields flattened, multi-value kept
  as arrays.
- Sends `IndexDocuments(engine, documents)`; inspects the response, collecting `errors` into `$failed_ids`. If any
  failed, throws `SearchApiException` listing the ids (partial success is not returned). Returns indexed ids.

## Schema (`updateIndex`, `buildSchema`)

- `updateIndex()` calls `ensureEngine()`, then `PutSchema` with a `SchemaUpdateRequest` built from `buildSchema()`.
- `buildSchema()` maps Search API field types to App Search: `date->date`, `decimal/integer->number`,
  `string/text->text`; unmapped types skipped.
- If `indexFieldsUpdated()` detects field-set changes (via `$index->original`), triggers `$index->reindex()`.
- Errors in `updateIndex` are logged (`getLogger()->error`), not thrown.

## Deletion

- `deleteItems()` — `DeleteDocuments(engine, item_ids)`.
- `deleteAllIndexItems()` — no bulk-clear API, so it pages `ListDocuments` (page size 1000) and `DeleteDocuments`
  each page until pages exhausted.

## Query -> search (`search`, `doSearch`)

- `search()` clones the query, runs `doSearch()`, maps `response['results']` to Search API result items via
  `fieldsHelper->createItem($index, $result['_meta']['id'])`, sets score from `_meta.score`, and copies each field's
  `raw` value. `setResultCount` from `meta.page.total_results`.
- `doSearch()` builds a `SearchRequestParams`: keys from `$query->getKeys()`, filters from `buildFilters()`, facets
  from `buildFacets()`, pagination from `limit`/`offset` (`current = ceil(offset/limit)+1`), and sorts
  (`search_api_relevance` -> `_score`). Executes `Search(engine, params)`; on exception logs and throws
  `SearchApiException`.
- Language filtering: `$query->getLanguages()` is injected as a `search_api_language` filter.

## Filters and facets

- `buildFilters()` (recursive over `ConditionGroupInterface`): conjunction `AND->all`, `OR->any`; operators
  `<>`/`NOT IN`/`NOT BETWEEN` -> `none` subgroup; `<,>,<=,>=` on date/integer/decimal -> `from`/`to` ranges (with
  +1 fudges for integer inclusive/exclusive bounds); `BETWEEN`/`NOT BETWEEN` -> `{from,to}`. Value coercion mirrors
  indexing (dates to ISO-8601, int/float casts). Honors `filters_to_skip` (used for OR-facet passes).
- `validateOperator()` only accepts `=`, `<>`, `BETWEEN` (throws otherwise).
- `buildFacets()` maps `search_api_string`/`search_api_date` query types to `value` facets, `size` 250 (App Search max).
- OR facets: `search()` re-runs `doSearch()` once per OR facet with that facet removed from filters, then merges via
  `parseFacets()`; non-OR facets parsed from the main response. `parseFacets()` converts date facet values back to
  timestamps and stores terms under `search_api_facets` extra data.

## hook glue (centarro_search.module)

- `centarro_search_get_servers($only_active)` — loads `search_api_server` entities backed by this plugin.
- `centarro_search_form_search_api_index_form_alter()` + validate handler add/validate the per-index `engine` setting
  (see [../config/settings.md](../config/settings.md)).
