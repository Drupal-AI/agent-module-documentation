# Vragen.ai client library (developer API)

The HTTP layer is a small wrapper around `swisnl/json-api-client`. You normally never touch it — the
backend drives it — but you can build a client from PHP for scripts/tests.

## Factory service — `search_api_vragen_ai.client_factory`

`Client\ClientFactory` (args `@http_client_factory`, `@cache.default`; also aliased by FQCN so it can
be autowired as `Drupal\search_api_vragen_ai\Client\ClientFactory`).

```php
/** @var \Drupal\search_api_vragen_ai\Client\ClientFactory $factory */
$factory = \Drupal::service('search_api_vragen_ai.client_factory');
$client  = $factory->createClient($endpoint, $token, $searchCacheTtl = 3600);
```

- `createClient()` normalizes the endpoint to a single trailing `/`, derives a cache key
  `sha1($endpoint . '|' . $token)`, and wraps the HTTP client from `createHttpClient()`.
- `createHttpClient()` = `http_client_factory->fromOptions(['base_uri' => $endpoint, 'headers' =>
  ['Authorization' => 'Bearer ' . $token]])`. Only those two options are passed; all other client
  behavior uses the Drupal/Guzzle defaults.

## `Client\Client`

Constant `Client::DEFAULT_SEARCH_CACHE_TTL = 3600`. Repositories are lazily created and memoized:
`->documents()` (`DocumentRepository`), `->systems()` (`SystemRepository`).

- `search(string $query, ConditionGroupInterface $conditions, array $facets = [], int $offset = 0,
  int $limit = 10, array $filterableFields = [], array $sorts = [], ?string $system_id = NULL,
  ?float $alpha = NULL, ?float $max_distance = NULL): SearchResultCollection` — builds a
  `QueryParamsDTO`, checks the result cache, then calls `documents()->search()` or, when a
  `$system_id` is given, `documents()->systemSearch()` (system search paginates client-side via
  `getRange()`).
- `similar(string $external_id, ConditionGroupInterface $conditions, int $offset = 0, int $limit = 10,
  array $filterableFields = [], ?float $distance = NULL): SearchResultCollection` — "more like this"
  against `documents/similar`.
- Both cache under `search_api_vragen_ai:<type>:<cacheKey>:sha1(serialize($params))`, tag
  `search_api_vragen_ai_client:<cacheKey>`, expiring at `time() + $searchCacheTtl`. `clearCache()`
  invalidates that tag.

## Repositories & endpoints

`BaseRepository extends Swis\JsonApi\Client\BaseRepository` (uses `FetchOne`, `FetchMany`), constructed
from `$client->getDocumentClient()` + `getDocumentFactory()`. `allWithoutPagination()` walks pages of
50 using the response `meta.page.lastPage`. `createResponseException()` turns a JSON:API error document
into a `VragenAiResponseException` (carries `status`/`title`/`detail`).

- `DocumentRepository` (`$endpoint = 'documents'`, traits `Create`/`Update`/`Delete`):
  - `findByExternalReference($ref)` — `filter[external_reference]`, page size 1.
  - `newByExternalReference($ref)` — new local `DocumentItem`.
  - `search(QueryParamsDTO)` → `GET documents/search?<params>`.
  - `systemSearch($systemId, QueryParamsDTO)` → `GET systems/{id}/search?<params>`
    (filters/facets/sorts omitted: `toHttpQueryParams(includeFilterFacetsSort: FALSE)`).
  - `similar(QueryParamsDTO)` → `GET documents/similar?<params>`.
- `SystemRepository` (`$endpoint = 'systems'`): `cachedAllByType($type, $forceRefresh = FALSE)` caches
  systems grouped by `system_type` under `search_api_vragen_ai:systems:<cacheKey>` for 3600s
  (tags `search_api_vragen_ai_systems`, `search_api_vragen_ai_client:<cacheKey>`).
- Items: `DocumentItem` (`type = documents`), `SystemItem` (`type = systems`, props `uuid`/`id`/
  `system_type`).

## `DTO\QueryParamsDTO`

Immutable request params. Requested fieldset is fixed:
`['external_reference', 'relevance_score', 'metadata_fields']`. `toArray()`/`toHttpQueryParams()`
emit `page[offset]`, `page[limit]`, `fields[documents]`, and conditionally `query`, `filter`, `facets`,
`sort`, `alpha`, `maxDistance`, `distance`.

## Query translation services (static)

- `FilterService::toQueryParams(ConditionGroupInterface $root, array $fields)` — walks the Search API
  condition tree into nested Vragen.ai filter rows (`id`/`parent`/`path`/`operator`/`value`/`tags`).
  Maps operators via `mapOperator()` (`IN`/`NOT IN`/`ALL`/`BETWEEN`/`LIKE`/`IS NULL`/comparisons →
  Vragen.ai equivalents; default `=`), expands `IN`/`BETWEEN` into sub-groups, formats `date` fields as
  RFC-3339, and json-encodes non-scalar values (`toScalar()`).
- `FacetService::toQueryParams(array $facets)` — emits `facets[i][limit|path|min_count|operator]`.
- `SortService::toQueryParams(array $sorts)` — `DESC` → `-field`, else `field`.

## Errors

`Client\Exception\VragenAiResponseException extends \RuntimeException` with `getStatus()`/`getTitle()`/
`getDetail()`. The backend maps a `404` on a "more like this" query to an empty result and logs other
failures via `logSearchResponseException()`.
