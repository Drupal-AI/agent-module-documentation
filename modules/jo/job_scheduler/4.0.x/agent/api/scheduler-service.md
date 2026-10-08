# Scheduling jobs — `job_scheduler.manager`

`$scheduler = \Drupal::service('job_scheduler.manager');` (`Drupal\job_scheduler\JobScheduler`,
interface `JobSchedulerInterface`).

## The job array

```php
$job = [
  'name'     => 'example_unpublish', // scheduler name (matches a hook_cron_job_scheduler_info key)
  'type'     => 'node',              // free string grouping (e.g. entity type / bundle)
  'id'       => 12,                  // numeric id (e.g. the entity id)
  'period'   => 3600,                // seconds until run (required unless 'crontab' set)
  'periodic' => TRUE,                // reschedule after each run
  'crontab'  => '0 2 * * *',         // optional *NIX crontab; overrides 'period' for next time
  'data'     => ['foo' => 'bar'],    // optional arbitrary payload (map field)
];
```

A job is uniquely identified by `[type, id]` (within a `name`).

## Methods

| Call | Effect |
|---|---|
| `->set($job)` | Create a `job_schedule` entity; computes `next` = `time()+period` (or from `crontab`). **Does not de-duplicate** — call `removeAll`/`remove` first if you must avoid duplicates. |
| `->remove($job)` | Delete jobs matching `name` + `type` + `id`. |
| `->removeAll($name, $type)` | Delete all jobs for a `name`/`type`. |
| `->perform($name = NULL, $limit = 200, $time = 30)` | Run due jobs (called by cron). Returns `['start','total','failed', …]`. |
| `->reschedule($job)` | Recompute `next` for a periodic job (drops it if none). |
| `->rebuild($name)` / `->rebuildAll()` | Reconstruct schedule info from declarations. |
| `->dispatch($job)` / `->execute($job)` | Low-level: queue or run a single job entity. |

## Example

```php
$scheduler = \Drupal::service('job_scheduler.manager');
$scheduler->set([
  'name' => 'example_unpublish', 'type' => 'article', 'id' => 42,
  'period' => 86400, 'periodic' => TRUE,
]);
// later:
$scheduler->removeAll('example_unpublish', 'article');
```

Read scheduled jobs directly from the entity when introspecting:

```php
$ids = \Drupal::entityTypeManager()->getStorage('job_schedule')->getQuery()
  ->accessCheck(FALSE)->condition('name', 'example_unpublish')->execute();
```
