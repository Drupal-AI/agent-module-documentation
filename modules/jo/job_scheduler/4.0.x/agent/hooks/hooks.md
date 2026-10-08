# Job Scheduler hooks

Declared in `job_scheduler.api.php`. Collected via `job_scheduler_info()` /
`job_scheduler_queue_info()` (invokeAll + alter).

## `hook_cron_job_scheduler_info()`

Declare named schedulers. Each key is a scheduler name; the value chooses **how** its jobs run:

```php
function mymodule_cron_job_scheduler_info() {
  return [
    // Run a callback directly:
    'example_reset'  => ['worker callback' => 'example_cache_clear_worker'],
    // Or hand the job to a queue (worker callback is then ignored):
    'example_import' => [
      'worker callback' => 'example_import_worker',
      'queue name'      => 'example_import_queue',
    ],
  ];
}
```

## Worker callback signature

```php
function example_import_worker(\Drupal\job_scheduler\Entity\JobSchedule $job) {
  // Do the work. For manually-repeating jobs, call $scheduler->set($job) again to reschedule.
}
```

## Queue declaration & alters

```php
function mymodule_cron_job_scheduler_queue_info() {
  return ['example_import_queue' => ['title' => 'Job Scheduler Example', 'time' => 60]];
}
```

- `hook_cron_job_scheduler_info_alter(&$info)` — change a scheduler's callback/queue before cron.
- `hook_cron_job_scheduler_queue_info_alter(&$info)` — change a queue's `time` etc.

Each declared queue becomes a derived core QueueWorker plugin `job_scheduler_queue:<queue name>`
(see `Plugin/Derivative/JobSchedulerQueueWorker`), processed on cron with the given `time` budget.
