<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DB Optimize — UI operations, routes & batch flow

Install/enable: `drush en dboptimize`. No dependencies. All routes below live under
`/admin/config/system/dboptimize` and require the core permission `administer site configuration`
(`dboptimize.routing.yml`). Menu link: Configuration → System → DB Optimize (`dboptimize.links.menu.yml`);
local tabs in `dboptimize.links.task.yml`.

## The four maintenance operations
Each maps to a raw MySQL statement:

| Operation | Statement | Purpose |
|-----------|-----------|---------|
| Optimize  | `OPTIMIZE TABLE` | reclaim free space / defragment |
| Analyze   | `ANALYZE TABLE`  | refresh optimizer statistics |
| Check     | `CHECK TABLE`    | verify data/index integrity |
| Repair    | `REPAIR TABLE`   | fix corruption found by Check |

MySQL/MariaDB only. There is no config schema; behaviour is driven by code and the
`dboptimize.settings` config object (see `agent/config/settings.md`).

## Routes (all `_permission: administer site configuration`)
- `dboptimize.optimize_form` `/optimize` → `DbOptimizeForm`
- `dboptimize.confirm` `/optimize/confirm` → `DbOptimizeConfirmForm`
- `dboptimize.analyze_form` `/analyze` → `DbOptimizeAnalyzeForm`; `dboptimize.analyze_confirm` `/analyze/confirm`
- `dboptimize.check_form` `/check` → `DbOptimizeCheckForm`; `dboptimize.check_confirm` `/check/confirm`
- `dboptimize.repair_form` `/repair` → `DbOptimizeRepairForm`; `dboptimize.repair_confirm` `/repair/confirm`
- `dboptimize.settings_form` `/settings` → `DbOptimizeSettingsForm`
- `dboptimize.results` `/results` → `DbOptimizeResultsForm`
- `dboptimize.backup_form` `/backup` → `DbOptimizeDbBackupForm`
- `dboptimize.overview` `/overview` → `DbOptimizeOverviewController::overview`
- `dboptimize.commands` `/help` → `CommandsInfoController::overview`

(`DatabaseMaintenanceResultsController` references routes `dboptimize.database_maintenance*` that
are not declared in `dboptimize.routing.yml`, so it is effectively unreachable.)

## Optimize flow
1. `DbOptimizeForm::buildForm()` runs `SHOW TABLE STATUS`, builds a sortable `tableselect`
   (name/rows/size MB/free MB) with a client-side search filter (library `dboptimize/dboptimize`).
2. `submitForm()` stores selected table names in the session key `selected_tables` and redirects
   to `dboptimize.confirm`.
3. `DbOptimizeConfirmForm` (a `ConfirmFormBase`) lists the tables and, on confirm, builds a Batch
   whose per-table op is `DbOptimizeConfirmForm::optimizeTable()`: reads `Data_free` via
   `SHOW TABLE STATUS LIKE`, runs `OPTIMIZE TABLE`, computes freed MB, and reports the total in
   `optimizeFinished()`, redirecting back to the optimize form.

## Analyze / Check / Repair flow
All three extend `DbOptimizeBaseOptimizeForm` (only `getOperation()` differs):
1. `buildForm()` lists tables from `SHOW TABLES` in a `tableselect`.
2. `submitForm()` redirects to `dboptimize.<op>_confirm` with the chosen tables in the `tables`
   query string.
3. The confirm form (`DbOptimizeDb{Check,Analyze,Repair}ConfirmForm`) reads `tables`, and on submit
   instantiates the base form and calls `runBatch()`, which queues
   `DbOptimizeBatch::process($OPERATION, $table)` per table. `process()` runs
   `"<OP> TABLE \`<table>\`"`, collects `Msg_type`/`Msg_text` rows, and `finished()` writes an HTML
   summary to `\Drupal::state()->set('dboptimize.results', …)` then redirects to `dboptimize.results`.
   `DbOptimizeResultsForm` renders and then deletes that state value.

## Overview & Backup
- `DbOptimizeOverviewController::overview` iterates `SHOW TABLE STATUS`, sums
  `Data_length + Index_length`, buckets tables by name regex (node/media/taxonomy/paragraph/block/
  comment/cache/other), and renders total size, a per-group percentage table, and the top-10 largest
  tables.
- `DbOptimizeDbBackupForm::submitForm` shells out to `mysqldump` (path from `which mysqldump`) using
  the site's DB connection options, with `--single-transaction` and an SSL flag (`--ssl-mode=DISABLED`
  then `--skip-ssl` fallback), writes to a temp `.sql` file, optionally gzips it, and streams it as a
  `BinaryFileResponse` attachment (`deleteFileAfterSend(TRUE)`). Warns it may fail on very large DBs
  due to PHP memory/time limits. Admin-only.
