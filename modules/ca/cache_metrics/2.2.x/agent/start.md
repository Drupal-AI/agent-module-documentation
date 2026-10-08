<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cache Metrics (cache_metrics) — agent index

Backend-only performance telemetry. Records Drupal cache hits/misses and cache-tag
invalidations as New Relic custom events (`CacheGet`, `InvalidateTag`) for analysis in
New Relic Insights. No admin UI, routes, permissions, forms, config entities, or Drush
commands. Configured entirely by container parameters in a `services.yml`.

- Package: Performance. License: GPL-2.0-or-later. Core: `^8.7.7 || ^9.5 || ^10 || ^11`. PHP `>=8.1`.
- Dependencies: none (Drupal modules or Composer packages). Optional runtime: the New Relic PHP
  extension — events are only emitted when `newrelic_record_custom_event()` exists.

## What it provides

- Service `cache_metrics.cache_factory` (`src/CacheFactoryWrapper.php`) — `public: false`,
  `decorates: cache_factory`. Wraps each cache bin backend in a `CacheBackendWrapper`, unless the
  bin is blacklisted or `newrelic_record_custom_event()` is unavailable (`isEnabled()`).
- Class `CacheBackendWrapper` (`src/CacheBackendWrapper.php`) — implements `CacheBackendInterface`;
  on `get()`/`getMultiple()` records a `CacheGet` event; all other cache ops delegate to the inner
  backend unchanged. `record()` calls `newrelic_record_custom_event('CacheGet', …)`.
- Service `cache_metrics.invalidator` (`src/CacheMetricsCacheTagsInvalidator.php`) — tagged
  `cache_tags_invalidator`; on `invalidateTags()` records one `InvalidateTag` event per tag
  (de-duplicated per request). Gated by the `cache_metrics.invalidations` parameter + New Relic.

## Container parameters (no config API)

- `cache_metrics.invalidations` (bool, default `true`) — enable/disable invalidation logging.
- `cache_metrics.bins.blacklist` (array, default `['config','discovery']`) — bins excluded from
  hit/miss logging; `['*']` disables hit/miss logging entirely.

## Solution docs

- Configuration & operation (parameters, enabling per-environment, overriding the provider):
  [agent/config/settings.md](config/settings.md)
- Services & telemetry internals (event schemas, class/method map, extension points):
  [agent/api/services.md](api/services.md)
