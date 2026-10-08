<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Advanced Queue Runner (advancedqueue_runner) — agent index

Daemonizes **Advanced Queue** job processing: an admin form starts a detached PHP process that polls
selected queues on an interval and shells out to `drush advancedqueue:queue:process <queue>` when jobs
are pending — so queues are worked without a cron job or a manual Drush run. Package `Custom`.
Depends on **`advancedqueue`** and the ReactPHP `react/event-loop` + `react/child-process` libraries.
Core `^8.8 || ^9 || ^10 || ^11`. Version **2.0.5**. License GPL-2.0-or-later.

- **Config object, schema, the settings/start-stop form, the ReactPHP runner script, the cron
  auto-restart hook, and the `DefaultService` helper** → [config/settings.md](config/settings.md)

## What it actually provides (from source)

- One route: `advancedqueue_runner.runner_config_form` (`/admin/config/advancedqueue/runner`,
  `advancedqueue_runner.routing.yml`) → `Form\RunnerConfigForm` (extends `ConfigFormBase`). Menu link
  under *Configuration → System* (`advancedqueue_runner.links.menu.yml`).
- One config object `advancedqueue_runner.settings` (schema `config/schema/`, defaults
  `config/install/`): `drush_path`, `root_path`, `base_url`, `queues` (sequence), `interval`,
  `limit-jobs-running`, `enforce-limit-jobs-all-queues`, `auto-restart-in-cron`, `started_at`,
  `runner-pid`.
- Process helper `Classes\Runner` (`src/Class/Runner.php`, `include`d by the `.module`): starts a
  detached process with `exec('nohup <cmd> > /dev/null 2>&1 & echo $!')`, tracks/checks/kills by PID
  (`status()`/`statusByPid()`/`stop()`).
- Daemon script `src/Scripts/jobs.php`: boots `DrupalKernel`, runs a ReactPHP periodic timer that
  reads config and launches `drush advancedqueue:queue:process <queue>` per watched queue.
- Service `advancedqueue_runner.default` → `DefaultService` (`countJob()` counts queued jobs via the
  advancedqueue backend) and a logger channel `logger.channel.advancedqueue_runner`.
- Hooks: `hook_help`, `hook_theme` (theme `advancedqueue_runner`), `hook_cron` (optional daemon
  restart). **No permissions, no plugin types, no Drush command classes** ship on disk.
