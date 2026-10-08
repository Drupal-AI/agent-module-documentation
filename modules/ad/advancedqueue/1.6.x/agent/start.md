<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Advanced Queue — agent index

A replacement Queue API. Three moving parts:

1. **`advancedqueue_queue`** config entity — a queue (`config_prefix: advancedqueue_queue`,
   collection at `/admin/config/system/queues`, `configure` route
   `entity.advancedqueue_queue.collection`). Ships one queue: `default`.
2. **Backend plugin** (`advancedqueue_backend`) — where jobs live. `database` (core table
   `advancedqueue`) and `null` ship.
3. **Job type plugin** (`advancedqueue_job_type`) — `process(Job $job): JobResult`.

- **Queue entity keys, defaults, thresholds, admin UI, drush config** →
  [configure/queues.md](configure/queues.md)
- **Write a job type or a backend plugin (attributes, base classes, interfaces)** →
  [plugins/job-types-and-backends.md](plugins/job-types-and-backends.md)
- **Enqueue / process jobs in code: `Job`, `JobResult`, the processor, events** →
  [api/jobs.md](api/jobs.md)
- **`advancedqueue:queue:process` / `advancedqueue:queue:list`** →
  [drush/commands.md](drush/commands.md)
- **The one permission and what it gates** →
  [permissions/permissions.md](permissions/permissions.md)

One-liner to enqueue:

```php
use Drupal\advancedqueue\Job;
use Drupal\advancedqueue\Entity\Queue;
Queue::load('default')->enqueueJob(Job::create('my_job_type', ['id' => 42]));
```

Job states are exactly `queued`, `processing`, `success`, `failure`
(`Job::STATE_*`). Processor values are exactly `cron` and `daemon`
(`QueueInterface::PROCESSOR_CRON` / `PROCESSOR_DAEMON`).
