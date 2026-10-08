<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush commands

Registered via `drush.services.yml` (service `search_api_fast.commands`, class
`Drupal\search_api_fast\Commands\SearchApiFastCommands`). Requires Drush and a Unix/Linux host.

| Command | Aliases | Args | Purpose |
| --- | --- | --- | --- |
| `search-api-fast:index` | `sapi-fast`, `search-api-index-fast`, `search:api-index-fast` | `[index_name] [clear]` | Public entry point. Splits the index's remaining items across workers and spawns them. |
| `search-api-fast:index-queue` | `sapi-ifq`, `search-api-index-fast-queue`, `search:api-index-fast-queue` | `<index_name> <worker>` | Internal per-worker command spawned by the above; drains one worker queue. Not meant to be run by hand. |

`index_name` is a Search API index id (loaded via `search_api`'s `CommandHelper::loadIndexes`).
The optional second arg to `search-api-fast:index` is `clear` or `reindex`.

## Usage

```bash
# Index only the items still un-indexed (no clear/reindex).
drush sapi-fast INDEX_ID

# Mark everything for reindex first, then index in parallel.
drush sapi-fast INDEX_ID reindex

# Clear the index, then index from empty.
drush sapi-fast INDEX_ID clear

# No index id → prints the index list (delegates to search_api's `sapi-l`).
drush sapi-fast
```

Monitor the spawned workers with `top` or `ps -ef | grep drush`.

## How it works (behavior traced from source)

1. `apiIndexFast()` loads the index. It first runs a `ps -ef | grep` guard
   (`isAlreadyRunning()`, with the index name `escapeshellarg`-escaped) and exits if a worker
   for that index is already running.
2. If arg 2 is `clear` it calls `$index->clear()`; if `reindex` it calls `$index->reindex()`.
3. It reads the remaining items from the index tracker (`getTrackerInstance()->getRemainingItems()`)
   and round-robins them into `index_workers` separate queues named
   `search_api_fast_index_fast_<index_name>_<worker>`, bulk-inserting via
   `SearchApiFastQueue::createItems()` (one multi-row insert per queue).
4. For each non-empty queue it spawns a detached worker:
   `nohup <drush> --uri=<base_url> search-api-index-fast-queue <index_name> <worker> > /dev/null 2>&1 &`.
   The drush binary is the config `drush` value, or the parent's own `$argv[0]` when running under Drush CLI.
5. Each worker (`apiIndexFastQueue()`) claims up to `max_batches_worker_respawn` batches of
   `worker_batch_size` items (`SearchApiFastQueue::claimItems()`), loads them
   (`$index->loadItemsMultiple()`), indexes them (`$index->indexSpecificItems()`), then resets the
   datasource entity-type caches and calls `gc_collect_cycles()` to bound memory.
6. If items remain in its queue, the worker `respawn()`s itself (a fresh `nohup` of its own `$argv`)
   and exits — so long-running workers periodically drop their memory footprint instead of leaking.

Queue items are stored serialized in the core `queue` table and read back with
`unserialize(..., ['allowed_classes' => FALSE])`.
