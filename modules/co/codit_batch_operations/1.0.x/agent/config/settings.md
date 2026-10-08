<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Install, configuration, routes, permissions & Drush

Source: `codit_batch_operations.info.yml`, `codit_batch_operations.routing.yml`,
`codit_batch_operations.permissions.yml`, `codit_batch_operations.services.yml`,
`codit_batch_operations.install`, `config/schema/codit_batch_operations.schema.yml`,
`src/Form/CoditBatchOperationsConfigForm.php`, `src/Form/CoditBatchOperationsDeleteLogsForm.php`,
`src/Form/CoditBatchOperationsRunningResetForm.php`,
`src/Drush/Commands/CoditBatchOperationsCommands.php`.

## Install

`ddev drush en codit_batch_operations -y`. Core deps: `views`, `options`. `hook_schema` creates the
`codit_batch_operations_cron` table (cron last-run tracking). `hook_uninstall` deletes the module's
`cbo_*` state keys and reports the dropped table. Update hooks: `_update_10001` adds the
`total_items` / `last_item_processed` base fields to `batch_op_log`; `_update_10002` creates the
cron table on existing sites.

## Settings — config object `codit_batch_operations.settings`

Edited via `CoditBatchOperationsConfigForm` (`ConfigFormBase`) at
`/admin/config/development/batch_operations/settings` (route
`codit_batch_operations.config_form`). Schema (`config/schema/…`) declares only the object label
(`type: config_object`) — no per-key schema. Keys written by `submitForm()`:

- `script_location` (string) — machine name of the local module holding your scripts in
  `<module>/src/cbo_scripts/`. Empty → only the bundled `Test*` scripts are listed.
- `default_user` (int) — UID attributed to entity saves during a run (see the framework doc; falls
  back to UID 1 if empty).
- `cron_enabled` (bool) — master switch for cron processing of scripts that define
  `getCronTiming()`. Read by `BatchOperations::isCronEnabled()`; `codit_batch_operations_cron()`
  bails if `FALSE`.

The settings form also surfaces two caution links: reset-running (only when a lock is present) and
delete-all-logs.

## Routes & permissions (`*.routing.yml` / `*.permissions.yml`)

| Route | Path | Permission |
|---|---|---|
| `codit_batch_operations.base` | `/admin/config/development/batch_operations` | `administer codit batch operations` **+** `view codit batch operations log` (menu block landing) |
| `codit_batch_operations.config_form` | `…/settings` | `administer codit batch operations` |
| `codit_batch_operations.delete_log_form` | `…/settings/delete-all-logs` | `administer codit batch operations` |
| `codit_batch_operations.running_reset_form` | `…/settings/reset-running` | `administer codit batch operations` |
| `entity.batch_op_log.collection` | `…/log` | `view codit batch operations log` |
| `entity.batch_op_log.canonical` | `…/log/{batch_op_log}` | `view codit batch operations log` |

Permissions:
- `administer codit batch operations` — **`restrict access: TRUE`** (warning: it sets script
  locations and the default execution user; "Give to only the most trusted").
- `execute codit batch operations in ui` — **`restrict access: TRUE`** (used by the UI submodule;
  warning that scripts can be risky). Defined here so the UI module can stay disabled until needed.
- `view codit batch operations log`, `delete codit batch operations log` — not restricted; enforced
  by the entity access handler (see [../entities/batch-op-log.md](../entities/batch-op-log.md)).

The BatchOpLog entity's `admin_permission` is `view codit batch operations log`.

## Confirm forms (all `ConfirmFormBase`, CSRF-protected)

- `CoditBatchOperationsDeleteLogsForm` — batch-deletes every `batch_op_log` (entity query, batched
  deletion via Batch API), then redirects to settings. Deleting all logs re-enables any
  "run-once" scripts.
- `CoditBatchOperationsRunningResetForm` — clears the `cbo_running_script` state lock.

## Drush commands (`CoditBatchOperationsCommands`, Drush ≥ 9)

- `codit-batch-operations:run <script> [--allow-skip]` (alias `batch-op-run`) — validates the class
  exists and implements `BatchScriptInterface` (`checkScriptClass()`), then loops `run(…, 'drush', …)`
  until finished; prints skipped items and logged errors. `--allow-skip` continues past errors.
- `codit-batch-operations:list [--tests]` (alias `batch-op-list`) — lists available scripts (and
  their titles); `--tests` includes the bundled `Test*` scripts.
- `codit-batch-operations:running [--reset]` (alias `batch-op-running`) — shows the current run lock;
  `--reset` clears it.

## Admin menu (`*.links.menu.yml`)

Landing `Codit: Batch Operations` under *Configuration → Development*, with child links to the log
list and settings. `hook_help` renders `README.md` on `help.page.codit_batch_operations` (via the
optional `markdown` module, else HTML-escaped).
