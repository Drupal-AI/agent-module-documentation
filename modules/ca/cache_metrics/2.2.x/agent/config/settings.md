<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cache Metrics — configuration & operation

There is NO admin UI, no `*.settings.yml`, and no `config/schema`. All behavior is set with
two container parameters declared in `cache_metrics.services.yml` (defaults shown):

```yaml
parameters:
  cache_metrics.invalidations: true
  cache_metrics.bins.blacklist:
    - config
    - discovery
```

## Install / enable

`drush en cache_metrics -y`. No config import needed. Events only actually fire when the New
Relic PHP extension is loaded (`newrelic_record_custom_event()` must exist) — otherwise the
wrappers run but record nothing.

## Parameters

- `cache_metrics.invalidations` (bool, default `true`) — passed as the `$isEnabled` constructor
  arg of `cache_metrics.invalidator`. `false` stops all `InvalidateTag` logging.
- `cache_metrics.bins.blacklist` (array, default `['config','discovery']`) — passed to
  `CacheFactoryWrapper::isEnabled($bin)`. A bin in this list is returned unwrapped (no `CacheGet`
  logging for it). These two bins are omitted by default because they are high-volume and almost
  always hit. Add more bin names to reduce event volume. The special value `'*'` disables hit/miss
  logging for ALL bins (invalidation logging still works).

To change these, override the parameter values in your own site/services file (e.g.
`sites/default/services.yml` or an environment-specific services file).

## Enabling only in Production

The module is intended for Production, where New Relic is present, and to be left disabled in
local/dev. Use Drupal's environment-specific configuration approach
(https://www.drupal.org/node/3079028) to enable it per environment. Where New Relic is absent the
`isEnabled()` guards make the module a no-op regardless.

## Using a different analytics provider

New Relic is not hard-required; both services are override points:

1. Override `cache_metrics.cache_factory` — adjust `CacheFactoryWrapper::isEnabled()` and change
   `get()` to instantiate your own `CacheBackendWrapper` subclass that overrides `record()`.
2. Override `cache_metrics.invalidator` — subclass `CacheMetricsCacheTagsInvalidator` and change
   `isEnabled()` and `record()` to log to your destination.

## Event volume / performance

On busy sites hit/miss logging can produce thousands of events per minute. The New Relic daemon
buffers events and flushes ~once per minute, so this does not add page latency; if you exceed New
Relic limits the daemon auto-samples. Trim volume via the bin blacklist. See README.md for NRQL
dashboard queries (Cache Miss %, Cache Hit %, invalidations over time/by tag/by URI).
