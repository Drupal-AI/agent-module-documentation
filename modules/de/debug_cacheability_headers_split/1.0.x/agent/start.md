<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Debug Cacheability Headers Split (debug_cacheability_headers_split) — agent index

Splits Drupal core's oversized debug cacheability headers into multiple numbered headers so they stay under a server's per-header size limit. Development/debugging aid; no dependencies.

## What it is
- Core `^10 || ^11`, package Development, GPL-2.0-or-later. No composer or module dependencies.
- Only acts when core setting `http.response.debug_cacheability_headers` is enabled (injected as the container parameter `%http.response.debug_cacheability_headers%`) and the response is a `CacheableResponseInterface` main response.
- Inspects `X-Drupal-Cache-Tags` and `X-Drupal-Cache-Contexts`; if a header exceeds `header_size_limit`, word-wraps it into chunks of `header_chunk_size` and re-emits as `X-Drupal-Cache-Tags`, `-1`, `-2`, … (same for contexts).

## Provides
- Service `debug_cacheability_headers_split.response_subscriber` → `EventSubscriber\DebugCacheabilityHeadersSplitSubscriber` (args: `@config.factory`, `%http.response.debug_cacheability_headers%`). Subscribes to `KernelEvents::RESPONSE` at priority -500 (`onRespond`), after core's `FinishResponseSubscriber`.
- Config-form route `debug_cacheability_headers_split.settings` at `/admin/config/development/settings/cacheability`, permission `administer site configuration`. Local task under `system.development_settings`.
- Simple config `debug_cacheability_headers_split.settings` with keys `header_size_limit` (default 8192, min 1024) and `header_chunk_size` (default 8000, min 512). Ships `config/install` but NO `config/schema`.
- No permissions file, no plugins, no Drush commands, no hooks.

## Solution docs
- [Configuration & thresholds](config/settings.md) — settings form, config keys, validation, settings.local.php override.
- [Header-split subscriber](api/subscriber.md) — how the split works, event priority, guards.
