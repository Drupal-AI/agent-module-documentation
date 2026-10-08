# Lifecycle hooks

Declared in `ultimate_cron.api.php`. Each fires during a job's life cycle and receives the
`Drupal\ultimate_cron\Entity\CronJob` being processed. Chronological order:

```
hook_cron_pre_schedule($job)
hook_cron_post_schedule($job)
hook_cron_pre_launch($job)
hook_cron_pre_run($job)
hook_cron_post_run($job)
hook_cron_post_launch($job)
```

| Hook | When |
|---|---|
| `hook_cron_pre_schedule($job)` | Before the scheduler is asked if the job is due. |
| `hook_cron_post_schedule($job)` | After the schedule check. |
| `hook_cron_pre_launch($job)` | Before the launcher starts the job. |
| `hook_cron_pre_run($job)` | Immediately before the callback runs. |
| `hook_cron_post_run($job)` | After the callback finishes. |
| `hook_cron_post_launch($job)` | After launch — may fire before/after run for async launchers. |

```php
function my_module_cron_pre_launch($job) {
  \Drupal::logger('my_module')->info('Launching @id', ['@id' => $job->id()]);
}
```

Notes:
- With an async launcher (e.g. Background Process) `post_launch` can run before/around
  `post_run`, since the job runs in a separate thread.
- All of these can also be implemented as **methods on a plugin** instead of module hooks.
- Plugin-info alter hooks (`hook_ultimate_cron_{scheduler,launcher,logger}_info_alter`) let
  you modify plugin definitions — see [../plugins/plugins.md](../plugins/plugins.md).
