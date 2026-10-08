<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Advanced Queue Runner — configuration, runner script & operation

Everything the module does, grounded in source. It has no entities, no permissions of its own, no
plugin types, and (despite a `composer.json` `extra.drush` stanza) no Drush command class on disk.

## Install / enable

- `composer require drupal/advancedqueue_runner` then enable `advancedqueue_runner`. Requires the
  **`advancedqueue`** module (`advancedqueue_runner.info.yml` `dependencies`) and pulls the ReactPHP
  libraries `react/event-loop` (^1.2) and `react/child-process` (^0.6.5) via Composer.
- The runner shells out to the site's **Drush** binary; the host must allow the web/PHP user to
  `exec()`/spawn processes and run Drush.

## Config object `advancedqueue_runner.settings`

Schema: `config/schema/advancedqueue_runner.schema.yml` (type `config_object`). Install defaults:
`config/install/advancedqueue_runner.settings.yml`. Keys:

| Key | Type | Meaning |
| --- | --- | --- |
| `drush_path` | string | Absolute path to the Drush executable (e.g. `/var/www/html/vendor/drush/drush/drush`). |
| `root_path` | string | Drupal root path passed as `--root`. |
| `base_url` | string | Site URI passed as `--uri`; captured from global `$base_url` via a hidden form field. |
| `queues` | sequence(string) | Advanced Queue queue ids the daemon watches. |
| `interval` | integer | Seconds between polling ticks (default 5). |
| `limit-jobs-running` | integer | Max jobs running at a time (`-1` = no limit). Per-queue, unless the next key is on. |
| `enforce-limit-jobs-all-queues` | integer | `1` = apply the limit to the total across all queues. |
| `auto-restart-in-cron` | integer | `1` = `hook_cron` restarts the daemon if its PID is dead. |
| `started_at` | integer | Unix time the runner was started (display only). |
| `runner-pid` | integer | PID of the running daemon; presence means "running". |

## Route, menu, access

- Route `advancedqueue_runner.runner_config_form` — `path: /admin/config/advancedqueue/runner`,
  `_form: Form\RunnerConfigForm`, `options._admin_route: TRUE`, requirement
  **`_permission: 'access administration pages'`** (`advancedqueue_runner.routing.yml`).
- Menu link `advancedqueue_runner.runner_config_form` under `system.admin_config_system`
  (`advancedqueue_runner.links.menu.yml`).

## The form — `Form\RunnerConfigForm` (extends `ConfigFormBase`)

`getEditableConfigNames()` → `['advancedqueue_runner.settings']`; `getFormId()` → `runner_config_form`.
Constructed with `entity_type.manager` + `messenger` (`create()`).

`buildForm()` is stateful on `runner-pid`:
- **Runner running** (PID set and `Runner::status()` true): renders a read-only status table (PID,
  watched queues, interval, job limit, the Drush environment — `drush_path` / `root_path` / `HOME` —
  start time, and "Active") and a **Stop** submit button.
- **PID set but process gone**: clears `runner-pid`, saves, shows an error message, returns.
- **Not running**: lists Advanced Queue queues via
  `entityTypeManager->getStorage('advancedqueue_queue')->getQuery()->execute()` (each option links to
  its Advanced Queue jobs page), and renders required fields — Drush path, root path, queue checkboxes,
  interval, auto-restart-in-cron checkbox, job limit, enforce-limit-all-queues checkbox — plus a
  **Run** submit button.

`submitForm()`:
- Calls `advancedqueue_runner_set_environment_home()` (sets `HOME` env var from `base_url` if empty —
  works around a missing `$HOME` under some web SAPIs), then writes the submitted `base_url`,
  `drush_path`, `root_path`, `auto-restart-in-cron`, `enforce-limit-jobs-all-queues` into config.
- If **no** `runner-pid`: saves `queues` (`array_filter` of the checkboxes), `interval`,
  `limit-jobs-running`, `started_at = time()`, then `new Runner('php ' . __DIR__ . '/../Scripts/jobs.php')`
  starts the daemon; on success stores its PID in `runner-pid`.
- If a `runner-pid` **exists**: `new Runner()` + `setPid()` + `stop()` (kills the daemon).

## Process helper — `Classes\Runner` (`src/Class/Runner.php`)

`include`d directly by `advancedqueue_runner.module`; namespace `Drupal\advancedqueue_runner\Classes`.
- `__construct($cl)` — if a command string is passed, immediately `runCom()`.
- `runCom()` — `exec('nohup ' . $this->command . ' > /dev/null 2>&1 & echo $!')`; captures the echoed
  PID. The command here is always the fixed `php <module>/src/Scripts/jobs.php`.
- `statusByPid($pid)` — BusyBox-aware liveness check: `test -h /proc/<pid>/exe` under BusyBox, else
  `ps -p <pid>`. `stop()` → `kill <pid>`.

## The daemon — `src/Scripts/jobs.php`

Standalone CLI script (not a route). It `require`s `$_SERVER['PWD'] . '/../vendor/autoload.php'`, builds
a synthetic `<none>` request, boots a `DrupalKernel('prod', …)`, then reads
`advancedqueue_runner.settings` and starts a ReactPHP `Loop` periodic timer at `interval` seconds. Each
tick reads the live job limits and, per watched queue, counts pending jobs and running jobs against the
Drupal `database` service and — when there is work under the limit — calls `drush_advancedqueue()`,
which launches a `React\ChildProcess\Process` running
`<drush_path> --root=<root_path> --uri=<base_url> advancedqueue:queue:process <queue>`. Process
stdout/stderr `error` events are logged to the `advancedqueue_runner` logger channel. With
`enforce-limit-jobs-all-queues = 1` the running-job count is measured across all queues; otherwise it is
per-queue.

## Cron auto-restart — `hook_cron`

`advancedqueue_runner_cron()`: if `auto-restart-in-cron == 1` and a `runner-pid` is stored but
`Runner::statusByPid()` reports it dead, it re-runs `advancedqueue_runner_set_environment_home()`, starts
a fresh `Runner('php <module>/src/Scripts/jobs.php')`, and saves the new PID (logs an error if the
restart fails).

## Service & helper

- `advancedqueue_runner.default` → `DefaultService` (`src/DefaultService.php`, interface
  `DefaultServiceInterface`), injected with `entity_type.manager` + `messenger`. `countJob(string $queue)`
  loads the `advancedqueue_queue` entity and returns `getBackend()->countJobs()['queued']`.
- `logger.channel.advancedqueue_runner` — the module's logger channel.
- Theme hook `advancedqueue_runner` (`hook_theme`, template `templates/advancedqueue-runner.html.twig`).

## Operating notes

- Start/stop and see status only from `/admin/config/advancedqueue/runner`. "Running" is inferred from
  the stored PID being alive; there is no external supervisor — a `runner-pid` may go stale if the box
  restarts, which is what the cron auto-restart option addresses.
- `drush_path` / `root_path` / `base_url` must be correct absolute values for the daemon's Drush calls
  to succeed; they are shown in the status table's environment column.
- The repo ships a stray `src/Scripts/nohup.out`; the active `runCom()` redirects to `/dev/null`.
