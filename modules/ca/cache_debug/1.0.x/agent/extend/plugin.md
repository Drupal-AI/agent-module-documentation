<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Add a CacheDebugLogger plugin

Create a plugin in `src/Plugin/CacheDebugLogger` annotated `@CacheDebugLogger(id=..., label=...)` implementing `Drupal\cache_debug\CacheDebugLogger\CacheDebugLoggerInterface` (optionally extend `CacheDebugLoggerBase`, which supplies `isAvailable()`, or `GroupInvalidatedCacheDebugLogger`).

- Implement `logCacheTags($type, array $cache_tags, ?string $description)` (or `writeCacheTagsLog()` when extending the group base — see the `File` plugin, which writes to `<log_path>/<type>/<description>.log`).
- The `CacheDebug` service selects your plugin when it is chosen as the response or invalidated logger and `isAvailable()` returns TRUE.
- Register nothing extra — the `plugin.manager.cache_debug_logger` manager discovers it.
