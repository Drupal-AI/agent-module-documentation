<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `batch_op_log` content entity

Source: `src/Entity/BatchOpLog.php`, `src/Entity/BatchOpLogInterface.php`,
`src/Entity/BatchOpLogViewsData.php`, `src/BatchOpLogAccessControlHandler.php`,
`src/BatchOpLogViewBuilder.php`, `config/install/views.view.batch_operation_logs.yml`.

## Definition

`@ContentEntityType(id = "batch_op_log")`, base table `batch_op_log`, not translatable,
`admin_permission = "view codit batch operations log"`. Handlers: SQL storage, custom
`BatchOpLogViewBuilder`, `BatchOpLogViewsData`, a `delete` form
(`Form\BatchOpLogDeleteForm`), core `AdminHtmlRouteProvider`, and the custom
`BatchOpLogAccessControlHandler`. Links: canonical / delete-form / collection under
`/admin/config/development/batch_operations/log`. One log entity represents **one run** of one
script (keyed by the script FQCN in the `name` field). Users never create logs directly — the
runner creates them.

## Base fields (`baseFieldDefinitions()`)

- `id`, `uuid` — standard.
- `name` (string, max 300, required) — the script FQCN; the run's identity.
- `executor` (list_string) — how it ran: `ui`, `drush`, `hook_update`, `post_update`, `deploy`
  (allowed values defined on the field).
- `user_id` (entity_reference → user) — "Run by".
- `created` (created) — start time; `last` (timestamp) — last log entry / completion time.
- `completed` (boolean) — whether the run finished fully.
- `total_items`, `last_item_processed` (integer) — progress counters (added in `_update_10001`).
- `memory_use`, `max_memory` (integer, MB) — recorded on each log append.
- `log`, `errors` (string_long) — the appended run log and any caught errors.

## Interface / behavior (`BatchOpLogInterface`, `BatchOpLog`)

- `appendLog($msg)` / `appendError($msg)` — append a line and refresh `last` + memory stats.
- `setCompleted(bool)` / `getCompleted()`, `hasErrors()` / `getErrors()`, `setExecutor()`,
  `setOwnerId()` / `getOwner()`.
- `canSave()` / `setDoNotSave()` — a guard so a refused run (e.g. a "run-once" script that already
  completed) does not persist an empty log; `save()` is a no-op when do-not-save is set.
- `getUrl()` — returns the canonical URL, saving the log first if it has no id yet (covers a
  first-iteration error needing a link).
- Query helpers: `getBatchOpLogIds($name)`, `getMostRecentBatchOpLog($name)`,
  `getRelatedBatchOpLogs($name)` — all use the entity query on the `name` field with
  `accessCheck(TRUE)`.

## Access (`BatchOpLogAccessControlHandler`)

`checkAccess()` — `view` → requires `view codit batch operations log`; `delete` → requires
`delete codit batch operations log`; any other operation → neutral. `checkCreateAccess()` →
neutral (logs are never user-created). So viewing/deleting run history is gated by the two
non-restricted permissions, while running scripts is gated by the restricted permissions in
[../config/settings.md](../config/settings.md).

## Views

`config/install/views.view.batch_operation_logs.yml` installs a **"Batch Operation Logs"** view
(base table `batch_op_log`) listing all log entities; `BatchOpLogViewsData` supplies the Views data.
This backs the collection route / admin log list.
