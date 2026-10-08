# Maestro engine tasks

Two Maestro engine-task plugins (`src/Plugin/EngineTasks/`) plus a shared trait. Both implement
`MaestroEngineTaskInterface, ContainerFactoryPluginInterface`.

## `MaestroTransitionWebformWorkflowTask` (interactive)

Extends `MaestroInteractiveTask`. Presents the webform workflow element's available transitions to the
assigned user inside a Maestro flow so they can review the submission and change its state.
- `getExecutableForm()` builds the transition options for the configured element (options keyed
  `elementId:transitionId`); `handleExecuteSubmit()` applies the chosen transition.
- `getTaskEditForm()` / `prepareTaskForSave()` / `performValidityCheck()` — template-builder config
  (which webform/element, button text, etc.).
- `getTaskColours()`, `shortDescription()`, `description()` — template-builder metadata.
- Uses `MaestroWebformWorkflowsTrait::getSubmission($queueID)` to resolve the submission from the queue.

## `MaestroWebformWorkflowStateIfTask` (conditional)

Extends `MaestroIfTask`. Branches the process based on a submission's current workflow state.
- `execute()` evaluates the submission's state and returns the true/false branch for Maestro to follow.
- `getTaskEditForm()` / `prepareTaskForSave()` / `performValidityCheck()` — configure which state(s)
  to test.

## Hooks & routing (`src/Hook/MaestroHooks`, `src/Routing/RouteSubscriber`)

- `hook_task_console_interactive_link_alter()` — sets the task-console link text for
  `MaestroTransitionWebformWorkflowTask` (from `data.button_text`, default "Review and change workflow").
- `hook_execute_title()` — titles the Maestro execute page "Review submission: <webform label>".
- `RouteSubscriber::alterRoutes()` overrides the `maestro.execute` route's `_title_callback` to
  `webform_workflows_element_maestro_execute_title`.

Config schema for the task settings is in `config/schema/webform_workflows_element_maestro.schema.yml`.
Add these tasks in the Maestro template builder; no module-specific permissions are introduced.
