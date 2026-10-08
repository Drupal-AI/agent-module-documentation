<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Codit: Batch Operations (codit_batch_operations) — agent index

A developer **framework for running batch jobs**. You write a PHP class implementing
`BatchScriptInterface`; it gathers items, processes them one at a time, and records the run into a
`BatchOpLog` entity. The same script runs from `hook_update_N`, `hook_post_update`, `drush deploy`
hooks, cron, Drush, or the optional UI submodule. Package `Development`. Core `^10 || ^11`.
Depends on core **`views`** and **`options`**. Installed version 1.0.12. License GPL-2.0-or-later.

Not a Drupal plugin type — scripts are discovered by filename from a configured module's
`src/cbo_scripts/` directory (`scandir`) and loaded by `\Drupal::classResolver()`, not via an
annotated plugin manager.

## Solution docs

- **Write and run a BatchOperation script (the framework API): interface, base class, executors,
  resume/lock, cron, helper traits** → [api/batch-operations.md](api/batch-operations.md)
- **Install, settings config object, routes, permissions, Drush commands, run-lock & log
  cleanup** → [config/settings.md](config/settings.md)
- **The `batch_op_log` content entity: fields, access handler, Views log list** →
  [entities/batch-op-log.md](entities/batch-op-log.md)
- **Sub-module `codit_batch_operations_ui`** (its own tree) →
  [../../modules/codit_batch_operations_ui/1.0.x/agent/start.md](../../modules/codit_batch_operations_ui/1.0.x/agent/start.md)

## What it provides (from source)

- **Service** `codit_batch_operations.batch_operations` → `BatchOperations` (base class every script
  extends). Uses `BatchOperationsFilesTrait` (script discovery), `BatchOperationsNodeTrait`,
  `BatchOperationsVocabularyTrait` (content helpers).
- **Interface** `Drupal\codit_batch_operations\BatchScriptInterface` (methods a script must/should
  implement).
- **Content entity** `batch_op_log` (`src/Entity/BatchOpLog.php`) — the per-run log.
- **Config form** `codit_batch_operations.config_form` at
  `/admin/config/development/batch_operations/settings` (config object
  `codit_batch_operations.settings`).
- **4 permissions** (`codit_batch_operations.permissions.yml`): `administer codit batch operations`
  and `execute codit batch operations in ui` (both `restrict access: TRUE`), `view` / `delete codit
  batch operations log`.
- **Drush commands** (`CoditBatchOperationsCommands`): `codit-batch-operations:run|list|running`.
- **hook_cron** runs any script whose `getCronTiming()` is set, when cron is enabled in config.
- **hook_schema** table `codit_batch_operations_cron` (tracks cron last-run). State keys
  `cbo_<ScriptClass>` (resume position) and `cbo_running_script` (the run lock).
