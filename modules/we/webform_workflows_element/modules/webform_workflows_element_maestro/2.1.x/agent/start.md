# Webform Workflows Element Maestro — agent index

Maestro engine tasks that let a Maestro business process drive/branch on a webform submission's
workflow state. Depends on the parent `webform_workflows_element` and on `maestro`. Provides config
schema; no permissions, Drush, or plugin types. Enable with `drush en webform_workflows_element_maestro -y`.

- **The two engine-task plugins + hooks/route override** → [plugins/tasks.md](plugins/tasks.md)

Key facts:
- `MaestroTransitionWebformWorkflowTask` (id same; extends `MaestroInteractiveTask`) — interactive task
  presenting the workflow element's available transitions so an assignee can change submission state.
- `MaestroWebformWorkflowStateIfTask` (extends `MaestroIfTask`) — conditional/branch task on current
  workflow state.
- `MaestroWebformWorkflowsTrait::getSubmission($queueID)` — shared helper to resolve the submission.
- `Hook/MaestroHooks`: `hook_task_console_interactive_link_alter` (link label, default
  "Review and change workflow"), `hook_execute_title` (execute-page title = submission's webform label).
- `Routing/RouteSubscriber` overrides `maestro.execute` `_title_callback` →
  `webform_workflows_element_maestro_execute_title`.
