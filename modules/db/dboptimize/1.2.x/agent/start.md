<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DB Optimize (dboptimize) — agent index

MySQL/MariaDB table maintenance for Drupal: **OPTIMIZE / ANALYZE / CHECK / REPAIR TABLE**, plus a
database Overview and a `mysqldump` backup download. Runs from an admin UI, cron (direct or via
queue workers), and Drush. Version dir `1.2.x` (shipped `1.2.2`). Core `^9 || ^10 || ^11 || ^12`.
No PostgreSQL support.

- **Dependencies:** none (core only). No composer requirements beyond `drupal/core`. No submodules.
- **Permission:** every route requires core `administer site configuration` (module defines none of its own).
- **Config object:** `dboptimize.settings` (created in `hook_install`; no shipped config schema).
- **Configure route:** `dboptimize.optimize_form` (`/admin/config/system/dboptimize/optimize`).

## What it provides
- **Forms** (`src/Form/`): `DbOptimizeForm` (optimize picker) → `DbOptimizeConfirmForm`;
  `DbOptimizeBaseOptimizeForm` + `DbOptimize{Check,Analyze,Repair}Form` → `DbOptimizeDb{Check,Analyze,Repair}ConfirmForm`;
  `DbOptimizeSettingsForm` (cron config); `DbOptimizeResultsForm`; `DbOptimizeDbBackupForm` (mysqldump).
- **Batch** (`src/Batch/DbOptimizeBatch`): `process()` runs `"<OP> TABLE \`<table>\`"`; `DbOptimizeConfirmForm::optimizeTable()` for the optimize path.
- **Controllers** (`src/Controller/`): `DbOptimizeOverviewController::overview` (size summary + largest tables),
  `CommandsInfoController::overview` (Drush help page). `DatabaseMaintenanceResultsController` exists but its routes are not registered.
- **Cron services** (`src/Cron/`, tagged `cron`): `DbOptimizeCron`, `DbAnalyzeCron`, `DbRepairCron`, `DbCheckCron`; orchestrated by `dboptimize_cron()` in `dboptimize.module` per `execution_method` (`cron` vs `queue`).
- **Queue workers** (`src/Plugin/QueueWorker/`): `OptimizeQueueWorker`, `AnalyzeQueueWorker`, `RepairQueueWorker`, `CheckQueueWorker` — delegate to the matching cron service.
- **Drush** (`src/Commands/`): `DbOptimizeCommands` (`dboptimize:optimize|analyze|check|repair`), `DbOptimizeDrushCommands` (`dboptimize:cron-*`).
- **Logger channel:** `dboptimize` (writes to dblog).

## Solution docs
- Operations, routes & batch flow: [agent/operations/tasks.md](operations/tasks.md)
- Cron, queue & settings config: [agent/config/settings.md](config/settings.md)
- Drush commands: [agent/drush/commands.md](drush/commands.md)
