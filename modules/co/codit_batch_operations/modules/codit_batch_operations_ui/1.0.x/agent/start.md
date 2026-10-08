<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Codit: Batch operations UI (codit_batch_operations_ui) — agent index

Submodule of **codit_batch_operations** that adds a web UI to list and run BatchOperation scripts.
Depends on `codit_batch_operations:codit_batch_operations`. Package `Development`. Core
`^10 || ^11`. No config, no permissions of its own (it uses the parent's), no Drush. License
GPL-2.0-or-later.

- **The UI routes, controllers, run/confirm forms, access & how execution happens** →
  [ui/operations.md](ui/operations.md)
- Parent framework (how a script is written and what runs it) →
  [../../../1.0.x/agent/api/batch-operations.md](../../../1.0.x/agent/api/batch-operations.md)

## What it provides (from source)

- **3 routes** (`codit_batch_operations_ui.routing.yml`), all gated by the parent permission
  **`execute codit batch operations in ui`** (`restrict access: TRUE`):
  - `codit_batch_operations_ui.operations` → `OperationsList::listOperations` — the script list.
  - `codit_batch_operations_ui.operation` → `OperationPage::renderOperation` — one script's detail +
    run form + run history.
  - `codit_batch_operations_ui.operation.confirm` → `OperationPage::renderOperationConfirmation` —
    the confirm form.
- **Controllers**: `OperationsBase` (shared DI + row formatting), `OperationsList`, `OperationPage`
  (both use the parent's `BatchOperationsFilesTrait` for script discovery).
- **Forms**: `BatchOperationRun` (`FormBase`; pick skip/fail, redirect to confirm),
  `BatchOperationRunConfirmation` (`ConfirmFormBase`; validates the class is a real
  `BatchOperations` + `BatchScriptInterface`, checks the run lock, then `batch_set()` the static
  callbacks `BatchOperations::runBatchByUi` / `finishedBatchByUi`).
- **Menu link** `codit_batch_operations_ui.operations` under the parent's admin landing.

The `{batch_operation_name}` URL parameter is validated against on-disk scripts
(`isBatchOperation()`) before use, so only discovered scripts can be targeted; running is a
token-protected confirm-form POST, not a GET side effect.
