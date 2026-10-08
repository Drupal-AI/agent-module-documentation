# Plugins implemented

The module implements plugins of existing core/Webform plugin types (it does **not** define new plugin
managers).

## Workflow type — `webform_workflows_element`

`src/Plugin/WorkflowType/WebformWorkflowsElement` (`@WorkflowType`, extends `WorkflowTypeBase`).
Config form `Form/WebformWorkflowsElementConfigureForm`. Adds `getInitialState()` (reads
`configuration['initial_state']`). Create workflows of this type in the core Workflows UI; states and
transitions are stored in the workflow config (schema `workflow.type_settings.webform_workflows_element`).

## Webform element — `webform_workflows_element`

`src/Plugin/WebformElement/WebformWorkflowsElement` (the Webform element plugin) + the render element
`src/Element/WebformWorkflowsElement` (`getInfo()` composite of `workflow_state`,
`workflow_state_previous`, `workflow_state_label`, `transition`, and a `workflow_fieldset` with
`log_public` / `log_admin`). The element:
- Binds to a workflow via `#workflow`.
- Renders the current state and the available transitions (respecting per-transition access).
- Supports `#hide_if_no_transitions`, `#require_transition_if_available`, `#transition_element_type`,
  and a preset transition from `?transition=` / `?workflow_element=` query args.
- Defines the large `access_*` property set consumed by `WebformWorkflowsManager` (see configure/setup.md).

## Webform handler — `workflows_transition_email`

`src/Plugin/WebformHandler/StateChangeEmailWebformHandler` (extends core webform `EmailWebformHandler`,
label "Workflow transition email", `tokens = TRUE`). Overrides `postSave()` to send only when a
configured transition actually changed state: for each workflow element it checks the submission's
`transition` and that `element_id:transition` is in the handler's `states`, and that
`workflow_state_previous !== workflow_state`. `getBodyDefaultValues()` falls back to
`webform_workflows_element.settings` `mail.default_body_text/html`. Schema
`webform.handler.workflows_transition_email` (extends `webform.handler.email`). Added via the
`entity.webform.handler.add_workflow_email` action (needs `webform.update`).

## Webform Action — `webform_workflow_transition`

`src/Plugin/Action/WebformWorkflowTransition` (`@Action`, type `webform_submission`, label "Perform
workflow transition on submissions"). Config: `workflow`, `transition`, `element`, `log_public`
(schema `action.configuration.webform_workflow_state_change:*`). Runs a chosen transition in bulk over
selected submissions (from a webform submissions View / VBO-style bulk ops), matching the target
`element` and `workflow`.

## Also (not plugins, related)

- `TransitionEventSubscriber` + `WebformSubmissionWorkflowTransitionEvent` (see api/api.md).
- Maestro engine-task plugins and a Views filter plugin live in the two submodules.
