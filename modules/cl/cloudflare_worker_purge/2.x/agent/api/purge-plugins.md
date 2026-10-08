# Purge plugins & the Worker request contract (API)

This module ships two Purge framework plugins and no services/routes of its own. Both are driven by
the **Purge** module (`purge`/`purge_ui`/`purge_processor_*`/`purge_queuer_*`), not by this module.

## Purger — `cloudflare_worker`

`Drupal\cloudflare_worker_purge\Plugin\Purge\Purger\CloudflareWorkerPurger` extends
`Drupal\purge\Plugin\Purge\Purger\PurgerBase`.

Annotation: `types = {"tag"}` (only **tag** invalidations; other types are marked `NOT_SUPPORTED`),
`multi_instance = FALSE`, `configform = CloudflareWorkerPurgeForm`.

Constructor deps: `config.factory`→`cloudflare_worker_purge.settings` (as a `Config`), `http_client`
(Guzzle `ClientInterface`), a logger on channel `cloudflare_worker_purge`, and an **optional**
`key.repository` (`Container::NULL_ON_INVALID_REFERENCE` → `null` when `key` is not installed).

- `getIdealConditionsLimit()` → `MAX_TAG_PURGES_PER_REQUEST` (30) × 10 = **300**.
- `hasRuntimeMeasurement()` → `TRUE`.

### `invalidate(array $invalidations)` (`CloudflareWorkerPurger.php:79`)

1. Empty input → returns.
2. Reads `url` from config. **Empty URL** → logs `error('Purge URL not set')` and sets every
   invalidation to `FAILED`, then returns.
3. **Group by tag**: `array_reduce` keys invalidations by `getExpression()`. An empty or non-string
   expression sets that item to `NOT_SUPPORTED` and is dropped.
4. **Chunk**: `array_chunk(..., 30, TRUE)` — up to 30 distinct tags per HTTP request.
5. **Auth header** (`:120`): only if `keyRepository` is set **and** `token` config is non-empty —
   `getKey($token_id)->getKeyValue()`; if the resolved value is truthy, add
   `headers['Authorization'] = "Bearer $token"`. Otherwise the request is unauthenticated.
6. For each chunk, fire an **async** request:
   `client->requestAsync('POST', $url, ['headers' => $headers, 'json' => ['tags' => array_keys($chunk)]])`.
   No `verify => false` / no cURL override — **TLS certificate verification uses the Guzzle default
   (enabled)**.
7. On fulfilment → every invalidation in the chunk set to `SUCCEEDED`. On rejection → `logger->critical($e->getMessage())`
   and every invalidation in the chunk set to `FAILED`.
8. `GuzzleHttp\Promise\Utils::unwrap($promises)` blocks until all chunk requests settle.

### Worker request contract

- Method/URL: `POST <configured url>`.
- Headers: `Authorization: Bearer <token>` when a Key is configured; `Content-Type: application/json`
  (from Guzzle's `json` option).
- Body: `{"tags": ["<tag1>", "<tag2>", …]}` (≤ 30 tags). The tag strings are Drupal cache tags (e.g.
  `node:12`, `config:system.site`). The Worker is expected to return a 2xx on success; any 4xx/5xx or
  transport error makes the whole chunk `FAILED` and gets retried by Purge later.

## Tags-header — `cloudflare_worker`

`Drupal\cloudflare_worker_purge\Plugin\Purge\TagsHeader\CacheTagHeader` extends `TagsHeaderBase`.
Annotation: `header_name = "X-Cache-Tag"`. `getValue(array $tags)` = `implode(',', $tags)`.

Purge's response subscriber adds this header to cacheable responses. It is named **`X-Cache-Tag`**
(not `Cache-Tag`) on purpose: Cloudflare consumes/strips `Cache-Tag` at the edge before the response
reaches a custom Worker, so the Worker instead reads `X-Cache-Tag` to learn which tags a cached
response belongs to. That mapping is what lets the later purge-by-tag POST invalidate the right assets.

## What this module does NOT expose

No `*.routing.yml`, controllers, forms other than the purger config form, services, permissions,
hooks, events, or drush commands. Nothing here begins a purge from an inbound HTTP request; the URL
fetched by the purger is the admin-configured Worker endpoint only.
