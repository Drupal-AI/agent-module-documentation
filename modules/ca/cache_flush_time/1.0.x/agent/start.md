<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cache Flush Time (cache_flush_time) — agent index

Prints a status message ("Cache flushed at <datetime>") every time Drupal rebuilds its caches. Version dir **1.0.x** (installed 1.0.0). Core `^10 || ^11`. Package: Development.

## What it provides
- **One hook only:** `cache_flush_time_cache_flush()` in `cache_flush_time.module` implements `hook_cache_flush()`. It formats `time()` with the `date.formatter` service ("short" format) and calls `messenger()->addStatus()`.
- **No** routes, permissions, services, config, schema, blocks, plugins, entities, libraries, or Drush commands.
- Dependency: core `system` only.

## How it works / operate it
- See [agent/api/cache-flush-hook.md](api/cache-flush-hook.md) for the hook behavior, when the message appears, and how to install/enable.

## Notes
- Purely presentational operational feedback; stores no state. The displayed value is a server-clock timestamp, not user input.
