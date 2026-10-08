<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Advanced Queue (advancedqueue) — agent index

A configurable, database-backed replacement for Drupal's core Queue API. Jobs carry a
type, JSON payload, state (queued/processing/success/failure), retries, delay, lease
time and an optional fingerprint for duplicate detection. Core requirement `^10.2 || ^11`;
no module dependencies. `drupal/plugin` is a dev-only requirement (used by the plugin-type
decorator). License GPL-2.0-or-later.

## What it provides
- **Config entity**: `advancedqueue_queue` (`src/Entity/Queue.php`). Pairs a backend plugin
  with a processor; managed at `admin/config/system/queues`. Access handler
  `QueueAccessControlHandler` (locked queues cannot be deleted).
- **Plugin types** (`advancedqueue.plugin_type.yml`):
  - `advancedqueue_backend` — manager `plugin.manager.advancedqueue_backend` (`BackendManager`).
    Ships `database` (`Plugin/AdvancedQueue/Backend/Database.php`) and `null` (`NullBackend`).
  - `advancedqueue_job_type` — manager `plugin.manager.advancedqueue_job_type` (`JobTypeManager`).
    Base class `JobTypeBase`; you subclass it and implement `process(Job): JobResult`.
- **Value objects**: `Job` (`src/Job.php`), `JobResult` (`src/JobResult.php`).
- **Processor service**: `advancedqueue.processor` (`Processor`, alias `ProcessorInterface`) —
  claims and runs jobs, records results, handles retries, dispatches events.
- **Events**: `AdvancedQueueEvents` — `PRE_PROCESS`, `POST_PROCESS`, `JOB_SUCCESS`, `JOB_RETRY`,
  `JOB_FAILURE`; each carries a `JobEvent`.
- **Hooks** (OOP, `src/Hook/AdvancedqueueHooks.php`): `hook_cron` processes all queues whose
  processor is `cron`; `hook_theme` registers `advancedqueue_state_icon`.
- **Drush commands** (`src/Commands/AdvancedQueueCommands.php`): `advancedqueue:queue:process`,
  `advancedqueue:queue:list`.
- **Views integration**: field plugins (`Json`, `JobState`, `JobType`, `Operations`,
  `AdvancedQueueBulkForm`) and argument validator `QueueBackend`; optional view
  `views.view.advancedqueue_jobs`.
- **Schema table**: `advancedqueue` (`advancedqueue.install`), storing job rows.
- **Permission**: `administer advancedqueue` (restricted).

## Solution docs
- [Queue configuration & backends](configure/queues.md) — the config entity, config schema keys,
  backends, thresholds, processors.
- [Enqueuing & processing jobs (API)](api/jobs.md) — `Job`, `JobResult`, `Processor`, events,
  retries, fingerprints/duplicates.
- [Job type & backend plugins](plugins/job-types-and-backends.md) — writing plugins and the
  optional backend capability interfaces.
- [Routes & permissions](permissions/permissions.md) — admin routes, access control, bulk actions.
- [Drush commands](drush/commands.md) — processing and listing queues from the CLI.
