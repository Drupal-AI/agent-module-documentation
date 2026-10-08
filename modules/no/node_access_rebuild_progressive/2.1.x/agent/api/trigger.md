<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Programmatic API, state keys, and processing

The module is procedural (functions in `node_access_rebuild_progressive.module`) plus a hooks
class (`src/Hook/NodeAccessRebuildProgressiveHooks.php`). There is **no public service**.

## State keys (the working position)

| `state` key | Meaning |
|---|---|
| `node_access_rebuild_progressive.current` | Next node id / position; **0 means idle/finished**. |
| `node_access_rebuild_progressive.processed` | Count of nodes processed so far this run. |
| `node_access_rebuild_progressive.bundles` | Active content-type filter array (unset when idle). |

```bash
drush sget node_access_rebuild_progressive.current
drush sset node_access_rebuild_progressive.current 0
drush sdel node_access_rebuild_progressive.bundles
```

## Key functions

- `node_access_rebuild_progressive_trigger(bool $resume = FALSE, array $bundles = []): int`
  — initializes (or resumes) a rebuild: sets `.current` to the highest node id + 1, records
  `.bundles`, logs the queued count, and returns the number of nodes to process. If no module
  implements `hook_node_grants`, it just writes the default grant and finishes.
- `node_access_rebuild_progressive_process_chunk(): array` — processes up to `chunk` nodes
  below `.current` (descending), calling `acquireGrants()` and `node.grant_storage->write()`,
  invalidating cache tags, and advancing `.current`. Returns `['total' => …, 'processed' => …]`.
- `node_access_rebuild_progressive_process_cron()` — one cron pass; acquires the lock, processes
  a chunk, and calls `…_finished()` when done.
- `node_access_rebuild_progressive_finished()` — cleanup: sets `.current` to `0` and **deletes**
  `.bundles`. This is what "clearing" a stuck/leftover rebuild means.
- `node_access_rebuild_progressive_set_default()` — resets grants to a clean default
  (`deleteGrants()` + `writeDefaultGrant()`).

## Hooks (`NodeAccessRebuildProgressiveHooks`)

- `#[Hook('cron')]` — if `settings.cron` is true and a rebuild is needed, triggers and processes
  a chunk per cron run.
- `#[Hook('form_node_configure_rebuild_confirm_alter')]` — disables core's rebuild form.

## Trigger from PHP

```php
// Queue a full rebuild for all bundles:
$count = node_access_rebuild_progressive_trigger();
// Queue a rebuild limited to the 'article' bundle:
$count = node_access_rebuild_progressive_trigger(FALSE, ['article']);
```
