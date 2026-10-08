<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush command

Command id **`node-access-rebuild-progressive:rebuild`**, alias
**`node-access-rebuild-progressive`** (class `NodeAccessRebuildProgressiveCommands`,
registered in `drush.services.yml`).

```bash
# Rebuild all node access grants (only acts if a rebuild is needed):
drush node-access-rebuild-progressive

# Rebuild even if Drupal doesn't flag one as needed:
drush node-access-rebuild-progressive --force

# Resume an interrupted rebuild from the stored position:
drush node-access-rebuild-progressive --resume

# Rebuild only specific content types:
drush node-access-rebuild-progressive --bundle=article
drush node-access-rebuild-progressive --bundle=article,page,event
```

## Options

| Option | Effect |
|---|---|
| `--force` | Run even when `node_access_needs_rebuild()` is false. |
| `--resume` | Continue from the stored `state` position instead of starting fresh. |
| `--bundle` | Comma-separated content-type machine names to restrict the rebuild. |

## Behavior notes

- Without `--force`/`--resume`, the command is a no-op unless a rebuild is actually needed
  (exit code 0).
- It acquires the `node_access_rebuild_progressive_process` lock (1 hour) so it cannot run
  concurrently with the cron processor; if the lock is held it logs an error and exits 1.
- It loops, dispatching `_drush_node_access_rebuild_progressive_process()` via `drush php-eval`
  for each pass until no nodes remain.
- Bundle-restricted rebuilds do **not** clear the global "needs rebuild" flag (you are
  expected to rebuild every needed bundle first).

## Stuck rebuild (from README troubleshooting)

```bash
# Inspect the lock:
drush sqlq "SELECT * FROM semaphore WHERE name='node_access_rebuild_progressive_process'"
# Release a crashed lock, then resume:
drush sqlq "DELETE FROM semaphore WHERE name='node_access_rebuild_progressive_process'"
drush node-access-rebuild-progressive --resume
```

> A legacy `hook_drush_command` (`node_access_rebuild_progressive.drush.inc`) provides the same
> command for Drush 8-style environments; on modern Drush the annotated command above is used.
