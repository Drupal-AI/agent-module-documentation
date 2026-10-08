<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Processing internals

How a SAR/removal task is fulfilled, and the extension points.

## Services

- `gdpr_tasks.manager` — `TaskManager` (entity_type.manager, current_user, file_system):
  helper for task-related logic.
- `gdpr_tasks.anonymizer` — `Anonymizer` (database, entity_type.manager, current_user,
  config.factory, `gdpr_tasks.rtf_traversal`, file_system): performs the right-to-be-forgotten
  anonymization/removal using each field's GDPR Fields RTF setting + anonymizer plugin.
- Entity traversals (all built via `gdpr_fields`'s `EntityTraversalFactory`):
  - `gdpr_tasks.rta_traversal` → `RightToAccessEntityTraversal`
  - `gdpr_tasks.rta_display_traversal` → `RightToAccessDisplayTraversal`
  - `gdpr_tasks.rtf_traversal` → `RightToBeForgottenEntityTraversal`
  - `gdpr_tasks.rtf_display_traversal` → `RightToBeForgottenDisplayTraversal`

  These walk from the subject user across the relationships configured in GDPR Fields
  (`relationship` = follow/owner) to gather (RTA) or scrub (RTF) all of the subject's data.

## SAR export

The Subject Access Request export is assembled by the **queue worker**
`gdpr_tasks_process_gdpr_sar` (`Plugin\QueueWorker\GdprTasksSarWorker`); the finished export is
packaged as a zip (requires the PHP `zip` extension). The `gdpr_task_item` field type
(`Plugin\Field\FieldType\TaskLogItem`, widget/formatter `gdpr_task_item`) records the task log.

## Rules events

Defined in `gdpr_tasks.rules.events.yml`:
- `gdpr_tasks.rules_rta_complete` — "Data access request completed" (context: `user`, `link`
  to download the report).
- `gdpr_tasks.rules_rtf_complete` — "Right to be forgotten completed" (context: `email`).

Use these (with the Rules module) to react on completion, e.g. email the user a download link
or a confirmation.

## Templates / theme

`gdpr_task` theme hook + `gdpr-task-content-add-list` (the "add a task" list), templates in the
module's `templates/`. No hooks are invited beyond these; extend behaviour by configuring GDPR
Fields, adding task types, or subscribing to the Rules events.
