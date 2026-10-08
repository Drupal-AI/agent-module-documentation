# Global settings

Form `Drupal\simple_cron\Form\SimpleCronSettingsForm` (`ConfigFormBase`), route `simple_cron.settings`
at `/admin/config/system/cron/jobs/settings` (permission `administer simple cron`). Config object
`simple_cron.settings` (constant `SimpleCronSettingsForm::SETTINGS_NAME`). Saving the form also calls
`simple_cron.cron_job_manager::updateList()` and redirects to the job collection.

| Config key | Form field | Type | Default | Range | Effect |
|---|---|---|---|---|---|
| `cron.override_enabled` | "Cron hook override → Enabled" | bool | `TRUE` | – | When TRUE, each module's `hook_cron` is exposed as its own `cron.<module>` job and core's monolithic `hook_cron` dispatch is skipped. When FALSE, core `hook_cron` runs as normal and no per-module jobs are created. |
| `queue.override_enabled` | "Queue workers override → Enabled" | bool | `FALSE` | – | When TRUE, each cron-enabled queue worker is exposed as its own `queue.<worker>` job and core's `processQueues()` is skipped. When FALSE (default), core processes cron queues as normal. |
| `base.max_execution_time` | "Maximum execution time" (seconds) | int | `240` | 0–7200 | Passed to `Environment::setTimeLimit()` at the start of every cron run and of the `simple-cron` drush command. |
| `base.lock_timeout` | "Lock timeout" (seconds) | int | `900` | 0–7200 | Timeout for the core `cron` lock (when override disabled) and for each per-job lock `simple_cron:<id>`. Read by `CronJob` in its constructor. |

## What happens at runtime

`Drupal\simple_cron\SimpleCron::run()` (the swapped core `cron` service) branches:

1. **Manual run** (`_route === entity.simple_cron_job.run`): force-runs the single routed job.
2. **Single-URL run** (`?job=<id>` present): loads the enabled job via
   `CronJobManager::getEnabledJob()` and runs it, honoring `&force`.
3. **Default run** (normal cron): runs `cronJobsRun()` — every enabled, non-`single` job in weight
   order, each gated by its own crontab via `CronJob::shouldRun()`. Then, if `cron.override_enabled`
   is FALSE it invokes core cron handlers under the `cron` lock; otherwise it just records the cron
   last-run time. Finally, if `queue.override_enabled` is FALSE it runs core `processQueues()`.

Every run switches the current user to anonymous (`AnonymousUserSession`) and restores it afterward.

## Set via drush / PHP

```php
\Drupal::configFactory()->getEditable('simple_cron.settings')
  ->set('cron.override_enabled', TRUE)
  ->set('queue.override_enabled', TRUE)
  ->set('base.max_execution_time', 300)
  ->set('base.lock_timeout', 600)
  ->save();
// Re-derive the job list after toggling the override flags:
\Drupal::service('simple_cron.cron_job_manager')->updateList();
```

Drush: `ddev drush cset simple_cron.settings queue.override_enabled true -y` (then `drush cr` /
`updateList()` so the new queue jobs appear).

Schema: `config/schema/simple_cron.schema.yml` defines `simple_cron.settings` as a `config_object`
with the `cron`, `queue` and `base` mappings above; install defaults in
`config/install/simple_cron.settings.yml`.
