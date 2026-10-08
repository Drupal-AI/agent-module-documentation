<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Routes, forms, access checks & menu links

There is **no `*.routing.yml`**. Routes are generated at runtime by
`src/Routing/RouteSubscriber.php` (`entity_workflow.route_subscriber`, `RoutingEvents::ALTER`
priority -160) for every entity type that `EntityWorkflowInfo::isEntityTypeSupported()` reports, using
the entity's `canonical` (or `edit-form`) link template as the base path. All routes set
`_admin_route: TRUE`.

## Generated routes

| Route name | Path suffix | Handler | Access requirement |
|---|---|---|---|
| `entity.<type>.workflow` | `/workflow/{workflow}` | `EntityWorkflowController::workflow` | `_custom_access: EntityWorkflowController::checkWorkflowAccess` |
| `entity.<type>.bulk_workflow` (not for `workspace`) | `/bulk-workflow/{workflow}` | `EntityWorkflowController::bulkWorkflow` | `_custom_access: EntityWorkflowController::checkBulkWorkflowAccess` |
| `entity.<type>.workflow_transition` | `/workflow/{workflow}/{transition_id}` | `_form: EntityWorkflowSimpleTransitionForm` | `_custom_access: EntityWorkflowSimpleTransitionForm::checkAccess` |
| `entity.workspace.bulk_workflow` | `workspace canonical + /bulk-workflow/{workflow}` | `EntityWorkflowController::bulkWorkflowWorkspace` | `_custom_access: EntityWorkflowController::checkBulkWorkflowWorkspaceAccess` |

`{workflow}` upcasts to a `workflow` config entity; `{<type>}` to the target entity.

## Controller & access checks (`src/Controller/EntityWorkflowController.php`)

- `workflow()` renders `EntityWorkflowForm` plus an embedded `workflow_transition_log` View
  (arguments = entity type + id) as the transition history.
- `checkWorkflowAccess()` → `AccessResult::allowedIf(EntityWorkflowInfo::isEntityInWorkflow($entity, $workflow_id))`
  (workspaces are always "in" a workflow; other entities must be tracked in the active workspace).
- `bulkWorkflow()` collects entities via `hook_entity_workflow_bulk_workflow_entities`, then renders
  `EntityWorkflowBulkTransitionForm`. `checkBulkWorkflowAccess()` requires `checkWorkflowAccess()` AND
  a module setting `$access = TRUE` through `hook_entity_workflow_has_bulk_workflow_alter` (default deny).
- `bulkWorkflowWorkspace()` builds the form over the workspace's tracked entities;
  `checkBulkWorkflowWorkspaceAccess()` → `$workspace->access('update')`.

## Forms (`src/Form/`)

- `EntityWorkflowForm` (`entity_workflow_form`, plain `FormBase`) — radios of
  `StateTransitionValidator::getValidTransitions()`, optional required log; `submitForm()` re-checks
  `isTransitionValid()` then calls `entity_workflow_transition()`.
- `EntityWorkflowSimpleTransitionForm` (`ConfirmFormBase`) — confirm form for one transition reached by
  action link; `checkAccess()` and `submitForm()` both verify `isEntityInWorkflow()` + `isTransitionValid()`.
- `EntityWorkflowBulkTransitionForm` (`entity_workflow_bulk_transition_form`) — tableselect of entities
  + a transition select; JS (`entity_workflow/bulk`, `js/entity-workflow-bulk.js`) enables only the
  entities valid for the chosen transition using `drupalSettings.entityWorkflowBulkTransitions`.
  `submitForm()` runs the transitions inside `WorkspaceManager::executeInWorkspace()`.
- `EntityWorkflowTransitionForm` / `EntityWorkflowConfigureForm` — plug into the core Workflows UI to
  edit a transition (action link / log / log-required) and the workflow itself.

All transition forms set `$form_state->set('workspace_safe', TRUE)` so the change is permitted inside a
workspace, and are standard Form API (POST + form token / confirm step), so no state-changing GET.

## Menu links

- Local task `entity_workflow.workflows` (`entity_workflow.links.task.yml`) via deriver
  `Plugin\Derivative\EntityWorkflowLocalTasks` — the per-entity "Workflow" tab.
- Local actions `entity_workflow.workflow_transitions` (`entity_workflow.links.action.yml`) via deriver
  `Plugin\Derivative\EntityWorkflowLocalActions` — one action link per transition whose config sets
  `action_link: TRUE`, pointing at `entity.<type>.workflow_transition` and shown on the entity's
  canonical page.
