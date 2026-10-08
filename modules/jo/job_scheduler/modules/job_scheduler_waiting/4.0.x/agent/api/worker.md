# The waiting worker

## What it does

`job_scheduler_waiting_perform_job($name)` (defined in `job_scheduler_waiting.drush.inc`) is
essentially the whole module:

```php
function job_scheduler_waiting_perform_job($name) {
  set_time_limit(0);
  while (TRUE) {
    $timer = microtime(TRUE);
    $results = \Drupal::service('job_scheduler.manager')->perform($name);
    if ($results['total']) {
      \Drupal::service('kernel')->rebuildContainer();
    }
    if (round(microtime(TRUE) - $timer) < 1) {
      sleep(1);
    }
  }
}
```

So one iteration == one `perform($name)` (the same due-job dispatch cron uses). The container is
rebuilt after any non-empty batch to avoid stale state in the long-lived process.

## Running it

Intended to run under a process supervisor. The module ships templates:

- `misc/worker` — `$DRUSH_COMMAND job-scheduler-waiting-perform $JOB_NAME`
- `misc/drupal.supervisord.conf` — a `[program:drupal_job]` block (one per waiting job) with
  `environment=DRUSH_COMMAND="…",JOB_NAME="…"`, `autostart`, `autorestart`.

## The Drush command (legacy)

`job_scheduler_waiting.drush.inc` declares a **Drush 8-style** command
`job-scheduler-waiting-perform` (alias `jswp`) taking the scheduler `name`. Legacy `.drush.inc`
files are **not loaded by Drush 10+**, so on a modern Drupal 10/11 site this alias won't be
available; call the loop from your own script/service, e.g. a small PHP runner that invokes
`\Drupal::service('job_scheduler.manager')->perform('<name>')` repeatedly, or run `drush cron`
for the normal (non-waiting) path.

To simulate one iteration (e.g. in tests) just call `perform()` once:

```php
\Drupal::service('job_scheduler.manager')->perform('my_scheduler');
```
