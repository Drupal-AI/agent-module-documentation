<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# aia_task entity, history & rollback

## Entity
`aia_task` (`src/Entity/AiaTask.php`, `#[ContentEntityType]`, base table `aia_task`, SQL storage, `admin_permission: administer aia`, collection `/admin/reports/aia`). It is the audit log: one row per applied action. Schema is installed in `aia_install()`; `AiaTaskListBuilder` renders the history table.

### Base fields
- `action_type` (string) — the executed plugin ID.
- `payload` (string_long JSON) — the validated payload that was applied (`getPayload()`/`setPayload()` JSON-encode).
- `result` (string_long JSON) — the apply result (may carry e.g. a created `block_id`).
- `success` (bool, default FALSE).
- `rolled_back` (bool, default FALSE).
- `created` (created timestamp).
- `uid` (entity_reference → user; defaults to current user).
- `session_id` (string, ≤128) — UUID grouping steps of one pipeline run; NULL for standalone tasks.

## Logging
`AiaTaskLogger` (`aia.task_logger`) writes a task on apply: called from `AiaExecuteForm::executeSubmit()`, `AiaCommands::execute()`, and `AiaPipeline::applyAll()` (the pipeline passes the shared `sessionId`). `markRolledBack($taskId)` flips the `rolled_back` flag.

## Task history UI
Route `aia.tasks` → `/admin/reports/aia` (`_entity_list: aia_task`). Rows show action, user, timestamp, session grouping, and status, with a rollback link per successful, not-yet-rolled-back task. CLI equivalent: `drush aia:tasks`.

## Rollback
Route `aia.task_rollback` → `/admin/reports/aia/task/{aia_task}/rollback` (`AiaTaskRollbackForm`, a confirm form — POST, CSRF-protected) or `drush aia:rollback <id>`. Both delegate to `AiaRollbackService::rollback($taskId)` (`src/Service/AiaRollbackService.php`), which:
1. Loads the task; refuses if missing, already rolled back, or not successful.
2. `match`es on `action_type` and deletes what was created:
   - `generate_content_type` → deletes the `node_type` and its `field_config`s.
   - `add_field` → deletes the `field_config`, and the `field_storage_config` if now orphaned (`isDeletable()`).
   - `generate_taxonomy` → deletes the vocabulary and its terms.
   - `generate_view` → deletes the `views.view.*` config entity.
   - `generate_block` → deletes the `block_content` by stored `block_id` (falls back to `info` label).
   - other action types → reported as "rollback not supported".
3. On success, marks the task rolled back and logs to the `aia` channel.

Pipeline steps share a `session_id` but are rolled back individually by task id; there is no single-call "roll back the whole session".
