<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DB Optimize — cron, queue & settings

Settings form: `DbOptimizeSettingsForm` at `dboptimize.settings_form`
(`/admin/config/system/dboptimize/settings`), a `ConfigFormBase` editing the single config object
**`dboptimize.settings`**. No config schema ships with the module (there is no `config/schema/`);
the object is created in `dboptimize_install()`.

## `dboptimize.settings` keys
- `execution_method` — global, `cron` (run inside `hook_cron`) or `queue` (enqueue to a queue worker). Default `cron`.
- Per operation `<op>` in {`optimize`, `analyze`, `repair`, `check`}:
  - `enabled_<op>` (bool) — run this op on cron. Default: optimize `TRUE`, others `FALSE`.
  - `cron_frequency` / `cron_frequency_analyze` / `cron_frequency_repair` / `cron_frequency_check`
    (int seconds) — one of hourly 3600, daily 86400, weekly 604800, monthly 2629746,
    trimester 7889238, semester 15778476, yearly 31556952. `hook_install` seeds all four to 86400.
  - `cron_tables` / `cron_tables_analyze` / `cron_tables_repair` / `cron_tables_check`
    (array of table names) — the tables to process; **empty = all tables**.

The settings form also shows, per op, the last run time / duration / last error read from **state**
(not config): `dboptimize.last_run.<op>`, `dboptimize.last_duration.<op>`, `dboptimize.last_error.<op>`.
The "Reset operation statistics" button (`resetOperationStates()`) deletes those state keys.
`validateForm()` normalises an optional `start_after` value if present.

`hook_uninstall()` deletes `dboptimize.settings`. Updates: `dboptimize_update_9001` adds the three
extra `cron_frequency_*` keys; `9002` initialises `execution_method` to `cron` on existing sites.

## Cron orchestration (`dboptimize_cron()` in `dboptimize.module`)
For each op with `enabled_<op>` truthy:
- **`execution_method === 'queue'`**: creates a queue named `dboptimize_<op>` and enqueues one item
  `['op' => <op>, 'tables' => <configured tables>]`.
- **otherwise (`cron`)**: fetches service `dboptimize.cron.<op>` and calls `__invoke()` (falls back to
  `run()`). Wrapped in try/catch; failures are logged to the `dboptimize` channel.

## Cron services (`src/Cron/`, `dboptimize.services.yml`, tag `cron`)
`DbOptimizeCron`, `DbAnalyzeCron`, `DbRepairCron`, `DbCheckCron` — each service id `dboptimize.cron.<op>`.
`run()` (also exposed as `__invoke()`):
1. Frequency gate — returns early if `now - state('dboptimize.last_run.<op>') < cron_frequency*`.
2. Resolves tables from `cron_tables*` config, or `SHOW TABLES` when empty.
3. For each existing table (`tableExists()` uses a parameterised `SHOW TABLES LIKE :name`), runs the
   op's raw statement (e.g. `OPTIMIZE TABLE \`<table>\``) and, for optimize, computes freed MB from
   `Data_free`. Emits CLI progress when run under Drush/CLI.
4. In `finally`, writes `last_run` / `last_duration` / `last_error` state keys.

## Queue workers (`src/Plugin/QueueWorker/`)
`OptimizeQueueWorker` (id `dboptimize_optimize`), `AnalyzeQueueWorker`, `RepairQueueWorker`,
`CheckQueueWorker` — each `@QueueWorker` with `cron = {"time" = 0}`. `processItem()` delegates to the
matching `dboptimize.cron.<op>` service's `run()`, or logs a warning if that service is unavailable.

Note: `dboptimize.services.yml` passes a 4th `@logger.channel.dboptimize` argument to the cron
services, but their constructors accept only three parameters, so the injected logger property is not
set — a latent bug that can fatal when a cron service tries to log; operate the ops via the UI/Drush
paths if cron logging misbehaves.
