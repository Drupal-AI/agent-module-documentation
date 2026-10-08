<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The run UI — routes, controllers, forms & execution

Source: `codit_batch_operations_ui.routing.yml`, `codit_batch_operations_ui.services.yml`,
`src/Controller/OperationsBase.php`, `src/Controller/OperationsList.php`,
`src/Controller/OperationPage.php`, `src/Form/BatchOperationRun.php`,
`src/Form/BatchOperationRunConfirmation.php`. (Static run callbacks live in the parent's
`BatchOperations`.)

## Install

`ddev drush en codit_batch_operations_ui -y`. Requires the parent module. Grant the parent
permission `execute codit batch operations in ui` (restrict access) to run from the UI.

## Routes (all `_permission: 'execute codit batch operations in ui'`)

| Route | Path | Handler |
|---|---|---|
| `codit_batch_operations_ui.operations` | `/admin/config/development/batch_operations/operations` | `OperationsList::listOperations` |
| `codit_batch_operations_ui.operation` | `…/operations/{batch_operation_name}` | `OperationPage::renderOperation` |
| `codit_batch_operations_ui.operation.confirm` | `…/operations/{batch_operation_name}/run/{skip}` | `OperationPage::renderOperationConfirmation` |

## Controllers

- `OperationsBase` (services `codit_batch_operations_ui.operations` / `.operation`) — shared DI
  (config, date formatter, entity managers, form builder, module handler, request stack, state) and
  helpers: `sortRows()`, `convertDuration()`, `convertDate()`, and `buildCompleteStatus()` (renders
  a status/progress cell from a run's `total_items` / `last_item_processed` / `completed` / errors).
- `OperationsList::listOperations()` — `getBatchOperations(FALSE)` (non-test scripts from the
  configured `script_location`), one row per script: name/description link, last-run date/method/by,
  run-instance count, and last-run status. TableSort on the header.
- `OperationPage::renderOperation($batch_operation_name)` — `throw NotFoundHttpException` unless
  `isBatchOperation()` matches a discovered script; then shows title, description, item count,
  "run once" flag, cron timing and next-run time, the run form, and a paged log-history table
  (`assembleRows()` → `getRelatedBatchOpLogs()`). Hides the run form if a run-once script already
  completed.
- `OperationPage::renderOperationConfirmation($name, $skip)` — 404 unless both `isBatchOperation()`
  and `isValidSkipOption()` (`skip`|`fail`) pass; renders the confirm form.

## Forms and the run flow

1. `BatchOperationRun` (`FormBase`, id `batch_operation_run`) — a radios choice (skip errors vs.
   fail on error, required) plus a hidden class name. `submitForm()` redirects to the confirm route
   with `batch_operation_name` + `skip`.
2. `BatchOperationRunConfirmation` (`ConfirmFormBase`, id `confirm_batch_operation_run`) —
   `buildForm()` resolves the script via `\Drupal::classResolver($fqcn)` and shows the item count.
   `validateForm()` refuses to run unless the resolved object is **both** an instance of
   `BatchOperations` and `BatchScriptInterface`, and unless the `cbo_running_script` lock is clear.
   `submitForm()` calls `batch_set()` with operations `[[$fqcn, 'runBatchByUi'], [$script, $skip]]`,
   `finished => [$fqcn, 'finishedBatchByUi']`.
3. Execution: `BatchOperations::runBatchByUi()` sets the operating user to the **current logged-in
   operator**, runs one pass of `run($sandbox, 'UI', $allow_skip)` per Batch API tick, and tracks
   counts/errors/log link in `$context['results']`. `finishedBatchByUi()` messages the outcome
   (including the `423` "run-once already ran" case) and redirects back to the operation page.

## Access & safety notes (mechanism)

- Every route requires the restrict-access parent permission; there is no anonymous or
  `access content` path to running.
- Actual execution is a confirm-form **POST** (CSRF token via `ConfirmFormBase`); the `{skip}` GET
  route only renders that form, it does not run anything.
- The `{batch_operation_name}` parameter is validated against `scandir`-discovered scripts before
  the class is resolved, and the confirm form re-checks the resolved class's type — so the URL can
  only target real BatchOperation scripts on disk, not arbitrary classes.
- Running any script is, by design, executing developer-authored PHP that mutates content at scale;
  the operate-as user is the operator (scripts may still `switchUser()`). Treat the run permission
  like `administer site configuration`.
