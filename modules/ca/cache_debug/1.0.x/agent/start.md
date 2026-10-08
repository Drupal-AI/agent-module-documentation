<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cache Debug (cache_debug) — agent index

**Logs response and invalidated cache tags to a file, logger channel or Sentry.**

- **Version:** 1.0.x (1.0.1), core `^10 || ^11`, package Development
- **Config route:** `cache_debug.admin.settings` → `/admin/config/development/cache-debug` (perm `configure cache debug`)
- **Services:** `cache_debug.cache_debug` (needs_destruction), `LogCacheTagsSubscriber` (`KernelEvents::RESPONSE`), `InvalidatedCacheTagsLogger` (`cache_tags_invalidator` tag), plugin manager `plugin.manager.cache_debug_logger`
- **Plugins (`CacheDebugLogger`):** `File`, `LoggerChannel`, `Sentry`; config `response_logger`/`invalidated_logger`/`log_path` (default `private://cache_debug`)
- **Security:** cache tags are internal identifiers, written only to the configured sink (private-scheme file / log / Sentry), **never to HTTP headers**, and there is no non-admin route. Not a data-exposure risk by default; keep the log path under `private://` and disable in production.

See [configure/loggers.md](configure/loggers.md) and [extend/plugin.md](extend/plugin.md)
