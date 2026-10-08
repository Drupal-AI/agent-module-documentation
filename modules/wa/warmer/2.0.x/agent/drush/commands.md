<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Warmer Drush commands

Defined in `Drupal\warmer\Drush\Commands\WarmerCommands` (Drush ^11.6 || ^12 || ^13).

## `warmer:enqueue` (alias `warmer-enqueue`)

Enqueue one or more warmers, identified by a comma-separated list of plugin IDs.

```bash
drush warmer:enqueue entity                 # schedule the entity warmer (drained on cron)
drush warmer:enqueue cdn,entity             # multiple warmers at once
drush warmer:enqueue cdn --run-queue        # enqueue AND drain the queue now
```

- Argument: `warmer_ids` — comma-separated plugin IDs. Validated against the registered
  warmers; unknown IDs abort with `Warmer plugin(s) not found: …`.
- `--run-queue` — after enqueuing, immediately run the `warmer` queue to completion (via
  `drush queue:run warmer`) so items land in cache right away. Without it, the command only
  enqueues and prints a reminder to run `drush queue-run warmer` (or wait for cron).

## `warmer:list` (alias `warmer-list`)

Table of every registered warmer with its ID, label, description, current `frequency` and
`batchSize`. Add `--format=json` for machine output.

```bash
drush warmer:list
drush warmer:list --format=json
```

## Related core queue command

Warming batches live in the reliable queue named **`warmer`**. Drain it manually with:

```bash
drush queue:run warmer
```
