<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cache Metrics — services & telemetry internals

Two services (both in `cache_metrics.services.yml`), three classes in `src/`. Both wrappers are
"inspired by webprofiler". Everything is a no-op unless `newrelic_record_custom_event()` exists.

## cache_metrics.cache_factory — hit/miss logging

`CacheFactoryWrapper` (`src/CacheFactoryWrapper.php`) implements `CacheFactoryInterface`,
`decorates: cache_factory`, `public: false`. Constructor args: inner factory, `@current_user`,
`@request_stack`, `%cache_metrics.bins.blacklist%`.

- `get($bin)` — if `isEnabled($bin)` is false, returns the raw inner backend. Otherwise wraps it
  once (memoized in `$cacheBackends[$bin]`) in a `CacheBackendWrapper`.
- `isEnabled($bin)` — true only when `'*'` is NOT in the blacklist, `$bin` is NOT in the blacklist,
  AND `function_exists('newrelic_record_custom_event')`.

`CacheBackendWrapper` (`src/CacheBackendWrapper.php`) implements `CacheBackendInterface` (and
`CacheTagsInvalidatorInterface`). Only reads are instrumented; every write/delete/invalidate op
delegates unchanged to the wrapped backend.

- `get()` — fetches, sets `$hit = $cache !== FALSE`, builds attributes, `record()`s.
- `getMultiple(&$cids)` — records one event per requested cid; `$hit` = cid NOT left in `$cids`
  after fetch (i.e. it was found). `duration` is always NULL for multiple.
- `record($attributes)` → `newrelic_record_custom_event('CacheGet', $attributes)` (const
  `EVENT_NAME = 'CacheGet'`).
- `buildAttributes()` builds the `CacheGet` payload:
  `duration` (NULL), `cid`, `bin`, `hit` (0/1), `miss` (0/1), `expire` (on hit), `tags`
  (space-joined, on hit), `isMultiple` (bool), `uri` (baseUrl+pathInfo), `request_id`
  (`getenv('HTTP_X_REQUEST_ID')`, Acquia), `cf_ray` (`CF-RAY` header, Cloudflare),
  `username` (`currentUser->getAccountName()`).

## cache_metrics.invalidator — invalidation logging

`CacheMetricsCacheTagsInvalidator` (`src/CacheMetricsCacheTagsInvalidator.php`) implements
`CacheTagsInvalidatorInterface`, tagged `cache_tags_invalidator`. Constructor args:
`@logger.factory`, `@request_stack`, `@current_user`, `%cache_metrics.invalidations%`.

- `invalidateTags(array $tags)` — (a debug log is commented out, wrapped in a try/catch for the
  rare `DatabaseExceptionWrapper` seen when uninstalling a DB-backed logger); then, if
  `isEnabled()`, iterates tags, skipping any already recorded this request via `$invalidatedTags`
  (de-dup), and `record()`s one event each.
- `isEnabled()` — `$this->isEnabled` (the `cache_metrics.invalidations` param) AND
  `function_exists('newrelic_record_custom_event')`.
- `record($attributes)` → `newrelic_record_custom_event('InvalidateTag', $attributes)`.
- `InvalidateTag` payload: `tag`, `uri` (baseUrl+pathInfo), `request_id`, `cf_ray`, `username`.

## Extension points

Override either service to retarget telemetry (see config/settings.md). `CacheBackendWrapper` is
designed to be subclassed with a custom `record()`. No routes, controllers, forms, permissions,
queries, hooks, or Drush commands are provided.
