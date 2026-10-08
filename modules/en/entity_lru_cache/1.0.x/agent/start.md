<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity LRU Cache (entity_lru_cache) — agent index

Replaces Drupal's entity memory cache with a bounded **least-recently-used (LRU)** cache to cap
memory during long-running/high-volume entity processing. Core `^10.3|^11`. License
GPL-2.0-or-later. Version dir 1.0.x (installed release 1.0.0-alpha3, pre-release).
**No dependencies, no UI, no routes, no permissions, no config schema, no config entities, no
Drush commands.** Configured only via container parameters.

## What it actually is

- Decorates core service **`entity.memory_cache`** with `Adapter`
  (`src/Adapter.php`, implements `MemoryCacheInterface`), which forwards to either the original
  memory cache or an **`LruMemoryCache`** (`src/LruMemoryCache.php`, extends core `MemoryCache`).
- Mode selected by the `LruMode` enum (`src/LruMode.php`): `cli` / `on` / `off`.
- Bounded PHP-array memory cache: fixed slots, least-recently-used eviction. Per-request /
  per-process only.

## Solution docs

- **Container parameters (`lru_memory_cache_slots`, `lru_mode`), enable/disable, overriding** →
  [config/settings.md](config/settings.md)
- **Decorator wiring, LRU eviction/ordering algorithm, class/method details, tests** →
  [api/cache.md](api/cache.md)

## Defaults

- `lru_memory_cache_slots: 300`, `lru_mode: cli` (LRU active only under CLI by default).
