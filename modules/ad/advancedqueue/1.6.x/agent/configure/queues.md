<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — the `advancedqueue_queue` config entity

Admin UI: **Configuration → System → Queues** (`/admin/config/system/queues`), which is the
`configure` route `entity.advancedqueue_queue.collection`. Add form
`/admin/config/system/queues/add`, edit
`/admin/config/system/queues/manage/{id}`, delete `.../delete`.
`admin_permission` is `administer advancedqueue`.

## Full config shape

`advancedqueue.advancedqueue_queue.<id>` — the shipped `default` queue, verbatim:

```yaml
langcode: en
status: true
dependencies: {  }
id: default
label: Default
backend: database              # backend plugin id
backend_configuration:
  lease_time: 300              # seconds a claimed job is leased for
processor: cron                # 'cron' | 'daemon'
processing_time: 90            # seconds; 0 = unlimited (CLI only, see below)
locked: false                  # locked queues cannot be deleted
stop_when_empty: true          # processor stops as soon as the queue drains
threshold:
  type: 0                      # 0 = keep all | 1 = items | 2 = days
  limit: 0                     # number of items or days
  state: all                   # 'all' | 'success'
```

`config_export` order is `id, label, backend, backend_configuration, processor,
processing_time, threshold, locked, stop_when_empty`.

Key semantics:

| Key | Notes |
|---|---|
| `backend` | plugin id; `database` and `null` ship. `backend_configuration` is schema-typed as `advancedqueue.backend.[%parent.backend]`, and the base schema only declares `lease_time`. |
| `processor` | `cron` → `advancedqueue_cron()` processes it on every cron run. `daemon` → cron ignores it; you run `drush advancedqueue:queue:process`. |
| `processing_time` | Seconds the processor may keep going. `0` means unlimited, **but only on the CLI** — `Processor::processQueue()` coerces `0` back to `90` when `PHP_SAPI != 'cli'`. |
| `stop_when_empty` | `TRUE` = return as soon as `claimJob()` returns nothing; `FALSE` = keep polling until the time budget expires. |
| `threshold.type` | `QueueInterface::QUEUE_THRESHOLD_ITEMS = 1`, `QUEUE_THRESHOLD_DAYS = 2`, `0` = keep everything. The UI offers limits from `QUEUE_THRESHOLD_ITEMS_LIMITS` (100/1000/10000/100000/1000000) and `QUEUE_THRESHOLD_DAYS_LIMITS` (7/30/60/180/365). |
| `threshold.state` | `all` or `success` (i.e. keep failures forever). Enforced by the backend's `cleanupQueue()`, which the processor calls at the start of every run. |
| `locked` | `TRUE` hides the delete operation. Set it from code for queues your module owns. |

## Create / edit a queue with Drush

```bash
# create
drush php:eval '
  use Drupal\advancedqueue\Entity\Queue;
  Queue::create([
    "id" => "reports",
    "label" => "Reports",
    "backend" => "database",
    "backend_configuration" => ["lease_time" => 600],
    "processor" => "cron",
    "processing_time" => 120,
    "locked" => FALSE,
    "stop_when_empty" => TRUE,
    "threshold" => ["type" => 1, "limit" => 1000, "state" => "success"],
  ])->save();
'

# read
drush config:get advancedqueue.advancedqueue_queue.reports

# change one key
drush config:set advancedqueue.advancedqueue_queue.reports processor daemon -y
```

Programmatic setters on `QueueInterface`: `setBackendId()`, `setBackendConfiguration()`,
`setProcessor()`, `setProcessingTime()`, `setThreshold()`, `setStopWhenEmpty()`, plus the
matching getters and `isLocked()`, `getBackend()`.

## Job listing UI

`config/optional/views.view.advancedqueue_jobs` provides the per-queue job list. It uses
this module's Views handlers: `advancedqueue_job_state` (with an optional icon, themed by
`advancedqueue-state-icon.html.twig`), `advancedqueue_job_type`, `advancedqueue_json`
(pull one key out of the JSON payload), `advancedqueue_bulk_form` and an `Operations` field.
The view only makes sense for backends implementing `SupportsListingJobsInterface`.

Single-job operations are routes, all gated on `administer advancedqueue`:

- `/admin/config/system/queues/{queue}/jobs/{job_id}/release` — `advancedqueue.job.release`
- `/admin/config/system/queues/{queue}/jobs/{job_id}/retry` — `advancedqueue.job.retry`
- `/admin/config/system/queues/{queue}/jobs/{job_id}/delete` — `advancedqueue.job.delete`
- `/admin/config/system/queues/bulk_action/{action}` — `advancedqueue.bulk_action_confirm`,
  where `{action}` is `delete|release|retry`

## Storage

The `database` backend keeps every queue's jobs in one table, `advancedqueue`:
`job_id` (serial PK), `queue_id`, `type`, `payload` (big blob, JSON), `state`, `message`,
`num_retries`, `available`, `processed`, `expires`, `fingerprint`. Indexes:
`queue (queue_id,state,available,expires)`, `queue_state (state)`,
`queue_expires (expires)`, `fingerprint`, `queue_processed (processed)`, `type`.
Creating a queue with the `database` backend does **not** create a table
(`createQueue()` is a no-op); deleting one deletes that queue's rows.
