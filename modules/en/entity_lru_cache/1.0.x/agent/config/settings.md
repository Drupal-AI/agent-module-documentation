<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration — container parameters

There is **no admin UI, route, form, permission, or config entity**. All configuration is done
through two **container parameters** declared in `entity_lru_cache.services.yml`:

```yaml
parameters:
  lru_memory_cache_slots: 300
  lru_mode: cli
```

- **`lru_memory_cache_slots`** (int, default `300`) — max number of items the LRU cache holds.
  Injected into `LruMemoryCache::__construct($time, $allowedSlots)`. When a `set()` would exceed
  the count, the least-recently-used item is evicted.
- **`lru_mode`** (string, default `cli`) — when the LRU cache is used. Parsed by
  `LruMode::from()` (`src/LruMode.php`); valid values only:
  - `cli` (`LruMode::CLI_ONLY`) — LRU cache used **only** when `PHP_SAPI === 'cli'`; web
    requests fall through to core's default `entity.memory_cache`.
  - `on` (`LruMode::ON`) — LRU cache used for every request.
  - `off` (`LruMode::OFF`) — never; core's default memory cache is used everywhere.

  An invalid value makes `LruMode::from()` throw a `\ValueError` at container build.

## How to override

Container parameters are not editable through the Drupal UI. Override them per environment by
adding a `services.yml` (e.g. `sites/default/services.yml`, referenced from `settings.php`) with
a `parameters:` block setting `lru_memory_cache_slots` / `lru_mode`, then rebuild the container
(`drush cr`). Changing values requires a cache rebuild because they are compiled into the service
container.

## Enable / disable

- Enable: `drush en entity_lru_cache`. With defaults, the LRU cache only affects CLI (Drush,
  cron via CLI, migrations) — no change to web-request behavior.
- Disable behavior without uninstalling: set `lru_mode: off` and rebuild.
- Uninstall: `drush pmu entity_lru_cache` — the decorator is removed and core's default memory
  cache is restored.
