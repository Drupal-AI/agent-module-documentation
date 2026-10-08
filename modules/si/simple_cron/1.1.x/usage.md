<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Simple Cron is a lightweight cron manager that turns cron work into individually configurable jobs. It replaces the core cron service so each job — including every module's hook_cron and each cron queue worker — gets its own crontab schedule, enable/disable state, weight and lock, runnable from the UI, a per-job URL, or Drush.

---

Simple Cron replaces Drupal's core `cron` service with a plugin-driven manager. Every unit of cron work becomes a `simple_cron_job` config entity backed by a `@SimpleCron` plugin, with its own crontab expression, enable/disable toggle, execution weight and lock. Global settings can expose each module's `hook_cron` implementation as a separate `cron.<module>` job and each cron-enabled queue worker as a `queue.<worker>` job, so a slow or failing task no longer blocks the rest of the run. Jobs run on schedule during the normal cron run, on demand from the admin list (with a `run simple cron jobs` permission), via a single-job URL that carries the site cron key, or through the `simple-cron` / `simple-cron:list` Drush commands. Developers add custom jobs by dropping a plugin into `src/Plugin/SimpleCron`, optionally spawning several jobs from one plugin and adding per-job configuration fields. Requires `dragonmantank/cron-expression` and conflicts with Ultimate Cron.

---

- Give each module's hook_cron its own schedule.
- Run a single cron job on demand from the UI.
- Split cron into independently scheduled jobs.
- Set a crontab expression per job.
- Process specific queue workers as separate jobs.
- Force-run a job ignoring its schedule.
- Disable a misbehaving cron job without touching others.
- Grant an operator permission to run jobs but not configure them.
- Trigger one job via a per-job URL and the site cron key.
- Run a job from the command line with Drush.
- List all cron jobs and filter by enabled/disabled status.
- Unlock a job whose previous run is stuck.
- Reorder job execution with drag-and-drop weights.
- Cap cron execution time and lock timeout globally.
- Monitor last-run / next-run times per job.
- Get a status-report warning when jobs fall behind schedule.
- Define a custom cron task as a `@SimpleCron` plugin.
- Spawn multiple jobs from one plugin via type definitions.
- Add a configuration form to a custom cron job.
- Keep cron work running as anonymous for consistent permissions.
- Skip a job in the default run and expose it only by URL.
- Replace a monolithic hook_cron with discrete, observable jobs.
- Audit which module each cron job belongs to.
- Alter discovered cron plugins with `hook_simple_cron_info`.
- Migrate away from Ultimate Cron to a lighter manager.
