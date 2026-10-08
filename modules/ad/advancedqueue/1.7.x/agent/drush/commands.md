<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush commands

Defined in `src/Commands/AdvancedQueueCommands.php` (registered via `drush.services.yml`,
service `advancedqueue.commands`, injected with `entity_type.manager` and
`advancedqueue.processor`). The Drush integration requires Drush `^11` (`composer.json`
`extra.drush.services`).

## `advancedqueue:queue:process <queue_id>`
Processes one queue via `Processor::processQueue()`.
- Argument: `queue_id` — the queue entity id (throws if not found).
- Option: `--timeout` (default 90) — maximum run time in seconds; checked between jobs, so it
  is approximate. Passed to `Queue::setProcessingTime()`.
- If the `pcntl` extension is loaded, `SIGTERM`/`SIGINT` call `Processor::stop()` for a graceful
  shutdown between jobs.
- Prints how many jobs were processed and the elapsed time.
- Usage: `drush advancedqueue:queue:process default --timeout=60`.

Use this for the `daemon` processor, for CLI-driven processing, or to run a queue on demand
instead of waiting for cron. On the CLI a `processing_time` of 0 means unlimited.

## `advancedqueue:queue:list`
Lists every queue with per-state job counts (Queued / Processing / Success / Failure), computed
from each backend's `countJobs()`. Returns a `RowsOfFields` (id, label, jobs).
- Usage: `drush advancedqueue:queue:list`.

Note: cron-processor queues are also processed automatically by `hook_cron`
(`AdvancedqueueHooks::cron()`); the process command is mainly for daemon/manual/CLI runs.
