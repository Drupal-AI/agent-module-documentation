# Managing cron jobs

Jobs are `simple_cron_job` config entities (`Drupal\simple_cron\Entity\CronJob`), listed at
`/admin/config/system/cron/jobs` (`entity.simple_cron_job.collection`,
`Drupal\simple_cron\CronJobListBuilder`, a draggable weight list). You do **not** create jobs by hand:
`CronJobManager::updateList()` derives them from the available `@SimpleCron` plugins on module
install/uninstall/rebuild and when the settings form is saved. You edit, enable/disable, unlock and run
existing jobs.

## Entity fields (config_export → `simple_cron.job.<id>`)

| Key | Meaning |
|---|---|
| `id` | Job machine id. `<plugin_id>` for the default type, else `<plugin_id>.<type>` (`:` in the type becomes `.`, e.g. `cron.node`, `queue.aggregator_feeds`). |
| `crontab` | 5-field crontab expression (validated by `dragonmantank/cron-expression`). Auto-created jobs default to `*/15 * * * *`. |
| `plugin` | The `@SimpleCron` plugin id backing the job. |
| `type` | Plugin sub-type key (`default`, or a key from the plugin's `getTypeDefinitions()`). |
| `provider` | Module machine name the job belongs to (adds a config dependency on that module). |
| `single` | If TRUE the job is skipped in the default cron run and only runs via its single URL. |
| `status` | Enabled/disabled. Disabled jobs never run. |
| `configuration` | Per-job plugin configuration (sequence of strings in schema). |
| `weight` | Execution order in the default run (ascending; ties broken by id, natural case-insensitive). |

## Edit form

`Drupal\simple_cron\Form\CronJobForm` (route `entity.simple_cron_job.edit_form`,
`/admin/config/system/cron/jobs/{simple_cron_job}/edit`, admin permission): fields **Enabled**,
**Single URL only**, **Crontab expression** (required, validated with
`CronExpression::isValidExpression()`), plus the plugin's own `buildConfigurationForm()` under a
**Configuration** fieldset (omitted if the plugin adds no fields). The **Cron job ID** field is
read-only and shows a link to this job's single-run URL. Saving resets the next-run time.

## Operations

Access is enforced by `Drupal\simple_cron\CronJobAccessControlHandler`:

| Operation | Route | Allowed when |
|---|---|---|
| Edit | `entity.simple_cron_job.edit_form` | `administer simple cron` |
| Enable | `entity.simple_cron_job.enable` | job disabled **and** `administer simple cron` |
| Disable | `entity.simple_cron_job.disable` | job enabled **and** `administer simple cron` |
| Run | `entity.simple_cron_job.run` | job enabled **and** not locked **and** (`run simple cron jobs` **or** `administer simple cron`) |
| Unlock | `entity.simple_cron_job.unlock` | job locked **and** `administer simple cron` |
| Delete | – | always forbidden (jobs are managed automatically) |

Enable/Disable/Unlock use confirm forms; **Run** (`JobController::run()`) calls `cron->run()`, which
force-runs the routed job and redirects back to the collection with a status/error message. The list
shows each job's module, crontab, last run, next run, type (Default / Single URL) and status
(Enabled / Disabled / **Locked**).

## Single-URL / forced run

Every job has a single-run URL (`CronJob::getSingleRunUrl()`):
`/cron/<system.cron_key>?job=<id>`. Add `&force=1` to skip the crontab schedule check (the per-job
lock is still honored). This rides core's `system.cron` route, so the secret `system.cron_key` is
required just as for a normal cron trigger.

## Locking & state

A run acquires lock `simple_cron:<id>` (timeout `base.lock_timeout`). `isLocked()` reports it;
`unlock()` deletes the matching `semaphore` row (or use the Unlock operation). Last/next run
timestamps live in State under `simple_cron.state.<id>` and are removed when the job entity is
deleted. `hook_requirements` raises a runtime warning listing any enabled job whose next run is more
than 10 minutes overdue.

## Create a job as config (advanced)

Jobs are normally auto-derived, but you can ship one as config (see the plugin's `type`/`provider`):

```yaml
# config/install/simple_cron.job.my_job.yml
id: my_job
crontab: '0 * * * *'
plugin: example_simple_cron_single
type: default
provider: my_module
single: false
status: true
configuration: {  }
weight: 0
```
