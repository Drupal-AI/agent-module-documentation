<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Simple Cron (simple_cron) — agent index

Turns cron work into individually configurable **`simple_cron_job` config entities**, each backed by a
`@SimpleCron` plugin with its own crontab expression, enable/disable state, weight and lock. It swaps
the core `cron` service (via `SimpleCronServiceProvider`) for `Drupal\simple_cron\SimpleCron`, so the
normal cron run drives these jobs, and can optionally expose every module `hook_cron` and every
cron-enabled queue worker as its own job. Jobs can be run one at a time from the UI, a per-job URL, or
Drush.

No module dependencies; core `^10.2 || ^11`, PHP `>=8.1`, Composer lib `dragonmantank/cron-expression`.
Declares a Composer `conflict` with `drupal/ultimate_cron` (install also blocked by
`hook_requirements`). Configure route: `simple_cron.settings` (`/admin/config/system/cron/jobs/settings`).
Ships submodule `simple_cron_examples`. Defines permissions, a config-entity type, a plugin type, and
Drush commands.

- **Global settings (hook_cron / queue override toggles, execution time, lock timeout)** → [configure/settings.md](configure/settings.md)
- **Managing individual jobs: crontab, enable/disable/run/unlock, single-URL run, force run** → [configure/jobs.md](configure/jobs.md)
- **Defining your own cron job as a plugin (`@SimpleCron`), built-in `cron`/`queue` plugins, multi-type jobs** → [plugins/simple_cron.md](plugins/simple_cron.md)
- **Services & entity API (manager, plugin manager, `CronJob` methods, hooks)** → [api/services.md](api/services.md)
- **Permissions** → [permissions/permissions.md](permissions/permissions.md)
- **Drush commands** → [drush/commands.md](drush/commands.md)

Key facts:
- Settings config object `simple_cron.settings`: `cron.override_enabled` (bool, default TRUE),
  `queue.override_enabled` (bool, default FALSE), `base.max_execution_time` (int seconds, default 240),
  `base.lock_timeout` (int seconds, default 900).
- Config entity type `simple_cron_job` (config_prefix `job` → config names `simple_cron.job.<id>`);
  exported keys: `id`, `crontab`, `plugin`, `type`, `provider`, `single`, `status`, `configuration`,
  `weight`. Auto-created jobs default to crontab `*/15 * * * *`. Admin permission `administer simple cron`.
- Per-job run state lives in State API key `simple_cron.state.<id>` (`last_run`, `next_run`); job lock
  name is `simple_cron:<id>`.
- Services: `simple_cron.cron_job_manager` (`CronJobManager`), `plugin.manager.simple_cron`
  (`SimpleCronPluginManager`). Core `cron` service class is replaced with `Drupal\simple_cron\SimpleCron`.
- Plugin type: annotation `@SimpleCron` (id/label/weight), discovered in `Plugin/SimpleCron`, base class
  `SimpleCronPluginBase`, alter hook `hook_simple_cron_info`. Built-in plugins: `cron`, `queue`.
- Routes: `simple_cron.settings`; entity routes `entity.simple_cron_job.collection`
  (`/admin/config/system/cron/jobs`), `.edit_form`, `.enable`, `.disable`, `.unlock`, `.run`.
- Permissions: `administer simple cron` (restrict access), `view simple cron jobs`, `run simple cron jobs`.
- Drush: `simple-cron <id> [--force]` (aliases `scron`, `simple-cron`), `simple-cron:list [--status=]`
  (aliases `scron:list`, `simple-cron:list`).
- Per-job URL: `/cron/<system.cron_key>?job=<id>` (add `&force=1` to skip the schedule check).
