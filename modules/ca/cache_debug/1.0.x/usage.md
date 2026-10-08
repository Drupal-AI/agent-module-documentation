<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Cache Debug logs the cache tags of responses and of cache-tag invalidations so developers can see what is being cached and cleared.

---

Configure it at `/admin/config/development/cache-debug` (permission `configure cache debug`). You independently choose a **response logger** and an **invalidated logger** from pluggable `CacheDebugLogger` plugins — `File`, `LoggerChannel` (watchdog) and `Sentry` (via the Raven module) — and set a **file log path** that defaults to `private://cache_debug`. A response `KernelEvents::RESPONSE` subscriber records the cacheable response's tags, and a `cache_tags_invalidator`-tagged service records tags as they are invalidated (including on CLI/drush runs, described from `argv`).

Cache tags are internal cache identifiers (e.g. `node:1`, `config:system.site`) rather than user data, and the module writes them only to the configured sink — a private-scheme file, the Drupal log, or Sentry — **not** to HTTP response headers, and it exposes no public route beyond the permission-gated settings form. So it does not leak cache internals to anonymous users or in production headers by default; the main operational care is keeping the file log under `private://` (the default) and disabling loggers when not actively debugging. New sinks can be added by writing a `CacheDebugLogger` plugin.

---
- Enable the module in a development/staging environment
- Open `/admin/config/development/cache-debug`
- Select a response logger to record response cache tags
- Select an invalidated logger to record cache-tag invalidations
- Log cache tags to a file under `private://cache_debug`
- Log cache tags to the Drupal logger channel (watchdog)
- Send cache tags to Sentry via the Raven module
- Set a custom file log path for the File logger
- Debug why a page is (or isn't) being cached
- Trace which cache tags clear a given page
- Capture invalidations triggered by drush/CLI commands
- Disable both loggers to turn debugging off in production
- Keep logs in the private file scheme to avoid exposure
- Add a custom `CacheDebugLogger` plugin for a new sink
- Integrate with the Purge minificator for tag analysis
