# Setup & configuration

## 1. Create a workflow

Add a workflow of type **Webform workflow** (`webform_workflows_element`) at
`/admin/config/workflow/workflows` (core Workflows UI). Define its states and transitions there.
The type plugin (`Plugin/WorkflowType/WebformWorkflowsElement`) stores `initial_state`, `states`,
`transitions` (schema `workflow.type_settings.webform_workflows_element`) and exposes `getInitialState()`.

## 2. Add the element to a webform

On a webform, add an element of type **Webform workflow** (`webform_workflows_element`) and set its
`#workflow` to the workflow from step 1. The element (configured via
`Plugin/WebformElement/WebformWorkflowsElement` + `Form/WebformWorkflowsElementConfigureForm`) records
in submission data: `workflow_state`, `workflow_state_previous`, `workflow_state_label`, `transition`,
`log_public`, `log_admin`. Useful element properties: `#hide_if_no_transitions`,
`#require_transition_if_available`, `#transition_element_type` (`select`/buttons), `log_public_setting`,
`log_admin_setting`.

## 3. Configure access (element *Access* tab)

Access is per **transition** and per **state**, stored as element properties and enforced via Webform's
access-rules manager in `WebformWorkflowsManager`:

- **Per transition** — `access_transition_<transitionId>_workflow_enabled` (allow the transition at all)
  plus `_roles` / `_users` / `_permissions`. Checked by
  `checkAccessForSubmissionAndTransition()` → `checkAccessForWorkflowAccessRules()`.
- **Per state (edit-while-at-state)** — `access_update_at_state_<stateId>_override` (only then does the
  state's rule apply), `_workflow_enabled`, `_roles` / `_users` / `_permissions`. Checked by
  `checkAccessToUpdateBasedOnState()` and surfaced through `hook_webform_submission_access` (update op).
- Element access defaults (`defineDefaultProperties`): `access_view_workflow_enabled = TRUE`,
  `access_update_workflow_enabled = TRUE` with `access_update_roles = ['authenticated']`,
  `access_create_workflow_enabled = FALSE`.

Both `false` and neutral results are handled explicitly (forbidden vs neutral) so a disabled toggle
forbids rather than silently allowing. There is no module-defined permission — everything is driven by
these element access rules plus core webform access.

## 4. Performing transitions

- On the submission edit form the element renders the current state and the transitions the user may run.
- A confirm route `entity.webform.transition`
  (`/admin/structure/webform/manage/{webform}/submission/{webform_submission}/workflow/{workflow_element}/{transition}`)
  runs a single transition; access via `WebformWorkflowTransitionConfirmForm::checkAccess` →
  `checkAccessForSubmissionAndTransition`.
- Query args `?transition=<id>&workflow_element=<id>` can preset the transition on the form.

## 5. Summary pages

- `entity.webform.workflows_summary` → `/admin/structure/webform/manage/{webform}/workflows-summary`
  and `webform_workflows_element.workflows_summary` → `/webform/{webform}/workflows`
  (controller `WorkflowsSummaryController`, both require `webform.update` entity access).

## 6. Admin email defaults

`webform_workflows_element.config.workflows` →
`/admin/structure/webform/config/workflows` (local task "Workflows" under Webform config,
permission `administer webform`; form `Form/AdminConfig/WebformAdminConfigWorkflowsForm`).
Config object `webform_workflows_element.settings`:
- `ui.color_options` — newline list of `Label|css-class` colour choices for states (see theming).
- `mail.default_body_text` / `mail.default_body_html` — default bodies for the transition email handler
  (tokens like `[webform_submission:values:workflow:workflow_state_label]`).

## 7. Transition email handler

Add the **Workflow transition email** handler to a webform (action link
`entity.webform.handler.add_workflow_email` → `.../handlers/add/workflow_email`, requires `webform.update`).
See [plugins/plugins.md](../plugins/plugins.md) for handler behaviour.

## Scripting notes

- Element access properties are plain webform element settings — set them in the webform's YAML
  (`elements`) or via the element config form. Keys follow the `access_transition_<id>_*` /
  `access_update_at_state_<id>_*` patterns above.
