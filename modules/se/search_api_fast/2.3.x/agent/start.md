<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Search API Fast (search_api_fast) — agent index

Drush-only tool that (re)indexes a **Search API** index in PARALLEL by spawning many
background Drush workers, each draining its own database queue. Aimed at large indexes
(10k+ items) where sequential Search API indexing is too slow. Requires a Unix/Linux host,
Drush, and `search_api ^1.0`. Core `^9.5 || ^10 || ^11`. All work runs from the CLI; the
only route is an admin settings form.

Config object: `search_api_fast.performance` (keys `index_workers`, `worker_batch_size`,
`max_batches_worker_respawn`, `drush`). Settings form route `search_api_fast.settings` at
`/admin/config/search/search-api-fast` (permission `administer site configuration`), menu
link under `system.admin_config_search`. No module-defined permissions.

- **Run a parallel (re)index / clear an index** → [drush/commands.md](drush/commands.md)
- **Tune worker count, batch size, respawn interval, drush path** → [configure/settings.md](configure/settings.md)

Key facts:
- Drush service id `search_api_fast.commands` → class `SearchApiFastCommands` (`drush.services.yml`).
- Commands: `search-api-fast:index` (alias `sapi-fast`) is the public entry point;
  `search-api-fast:index-queue` (alias `sapi-ifq`) is the internal per-worker command it spawns.
- `hook_init()` (`search_api_fast_init`) primes the static `SearchApiFastConfig` helper from config.
- `SearchApiFastQueue` extends core `DatabaseQueue` with bulk `createItems`/`claimItems`/`deleteItems`
  (multi-item claims). Items are round-robined into one `{queue}` row-set per worker, named
  `search_api_fast_index_fast_<index>_<worker>`.
- Config object ships via `config/install/search_api_fast.performance.yml`; there is no config
  schema, and the settings form does not expose the `drush` key.
