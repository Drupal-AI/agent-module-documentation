# Job Scheduler settings, cron & the entity

## Config object `job_scheduler.settings`

Form route `job_scheduler.admin_settings` → `/admin/config/system/job-scheduler`
(permission `administer site configuration` — the module defines no permissions of its own).

| Key | Type | Default | Meaning |
|---|---|---|---|
| `logging` | bool | true | Write per-run stats to watchdog (`logger.channel.job_scheduler`) |
| `limit` | int | 200 | Max jobs processed per cron run |
| `time` | int | 30 | Max seconds spent processing jobs per cron run |

```bash
drush cset job_scheduler.settings limit 500 -y
drush cset job_scheduler.settings time 60 -y
```

The form also has a **Rebuild** button that calls `job_scheduler_rebuild_all()`
(`$scheduler->rebuildAll()`) to reconstruct schedule info. (No config schema ships with the module.)

## Cron behaviour

`job_scheduler_cron()` runs on every cron and calls
`$scheduler->perform(NULL, $config->get('limit'), $config->get('time'))`. Due jobs
(`next <= now`) are dispatched to their worker callback or queue; periodic jobs are rescheduled.
Trigger manually with `drush cron`.

## The `job_schedule` entity

Content entity, base table `job_schedule`, entity key `jid`. Base fields:

| Field | Meaning |
|---|---|
| `name` | Scheduler name (matches a `hook_cron_job_scheduler_info` key) |
| `type` | Free grouping string |
| `id` | Numeric job id (with `type`, uniquely identifies a job) |
| `period` | Seconds between runs |
| `crontab` | *NIX crontab line (alternative to `period`) |
| `periodic` | If TRUE, auto-reschedule |
| `data` | Arbitrary map payload |
| `last` / `next` / `scheduled` | Timestamps (last run, next due, when scheduled) |

Inspect scheduled jobs:

```bash
drush php:eval '$ids = \Drupal::entityTypeManager()->getStorage("job_schedule")->getQuery()->accessCheck(FALSE)->execute(); print count($ids) . " jobs scheduled\n";'
```
