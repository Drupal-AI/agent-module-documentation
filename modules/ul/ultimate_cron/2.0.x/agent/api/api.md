# Run & manage jobs in code

Jobs are the `CronJob` config entity (`Drupal\ultimate_cron\Entity\CronJob`,
`CronJobInterface`). Load and drive them directly:

```php
use Drupal\ultimate_cron\Entity\CronJob;

$job = CronJob::load('node_cron');       // ::loadMultiple() for all
if ($job->isScheduled() && !$job->isLocked()) {
  $job->run(t('Launched programmatically'));   // schedule check is caller's job
}
```

Common `CronJob` methods:

| Method | Purpose |
|---|---|
| `run($init_message = NULL)` | Execute the job now via its launcher. |
| `isScheduled()` / `isBehindSchedule()` | Ask the scheduler if it's due / overdue. |
| `lock()` / `unlock($lock_id, $manual)` / `isLocked()` | Concurrency locking. |
| `enable()` / `disable()` | Toggle status (then `->save()`). |
| `getPlugin($type, $name = NULL)` | Get the scheduler/launcher/logger plugin instance. |
| `getConfiguration($type)` / `setConfiguration($type, $cfg)` | Read/write plugin config. |
| `getLogEntries($types, $limit)` / `loadLatestLogEntry()` | Retrieve run logs (`LogEntry`). |
| `getProgress()` / `setProgress($p)` / `formatProgress()` | Long-run progress (0–1). |
| `getCallback()` / `getModule()` / `getTitle()` | Metadata accessors. |

Relevant services:

- `plugin.manager.ultimate_cron.{scheduler,launcher,logger}` — plugin managers.
- `ultimate_cron.discovery` (`CronJobDiscovery`) — `discoverCronJobs()` re-scans modules/queue
  workers and creates missing job entities.
- `ultimate_cron.lock` (`Lock`), `ultimate_cron.signal` (`SignalCache`),
  `ultimate_cron.progress` (`Progress`) — locking, cross-process signals, progress storage.
- `ultimate_cron.queue_worker` (`QueueWorker`) — processes a queue as a job.

Do not run all jobs by looping `run()`; let the normal cron trigger drive scheduling.
Signals (`sendSignal`/`getSignal`/`clearSignal`) let a running job be told to stop from
another request.
