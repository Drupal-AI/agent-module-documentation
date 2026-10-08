<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush commands

Registered via `drush.services.yml` →
`Drupal\advancedqueue\Commands\AdvancedQueueCommands` (Drush 11+ service style; the
module's `composer.json` declares `extra.drush.services`). Two commands, no aliases.

## `advancedqueue:queue:process <queue_id>`

```bash
drush advancedqueue:queue:process default
drush advancedqueue:queue:process reports --timeout=60
drush advancedqueue:queue:process reports --timeout=0     # unlimited (CLI only)
```

- `--timeout` (default **90**) is written onto the loaded queue with
  `setProcessingTime()` *in memory only* — the config entity is not saved.
- Throws `Could not find queue "<id>".` if the queue does not exist.
- If the `pcntl` extension is loaded it installs `SIGTERM` and `SIGINT` handlers that call
  `Processor::stop()`, so the worker finishes the current job and exits cleanly. This is
  what makes it safe to run as a supervised daemon process.
- Prints `Processed @count jobs from the @queue queue in @elapsed seconds.` on success.

Use this for queues whose `processor` is `daemon` (cron ignores those), or to drain a cron
queue on demand.

## `advancedqueue:queue:list`

```bash
drush advancedqueue:queue:list
drush advancedqueue:queue:list --format=json
```

Table of every `advancedqueue_queue` entity with columns `ID`, `Label` and `Jobs`, where
`Jobs` is `Queued: n | Processing: n | Success: n | Failure: n` built from
`$queue->getBackend()->countJobs()`. Returns `RowsOfFields`, so all the usual Drush
`--format` / `--fields` options work.

## Things there is *no* command for

Enqueuing, retrying, releasing and deleting individual jobs have **no** Drush command —
use the admin UI routes (`/admin/config/system/queues/{queue}/jobs/{job_id}/{release|retry|delete}`)
or `drush php:eval`:

```bash
drush php:eval '
  use Drupal\advancedqueue\Job;
  use Drupal\advancedqueue\Entity\Queue;
  Queue::load("default")->enqueueJob(Job::create("mymodule_send_report", ["report_id" => 42]));
'
```
