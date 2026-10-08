<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The Content workflow

## States (`workflows.workflow.content`)

`draft` (Draft), `review` (Ready for Review), `approved` (Approved). Default state `draft`, default
transition `new_draft`.

## Transitions

| ID | Label | From → To | Flags |
|---|---|---|---|
| `new_draft` | New draft | (none) → draft | access_callback |
| `submit_for_review` | Submit for Review | draft → review | log, action_link |
| `approve` | Approve | review → approved | log, action_link |
| `back_to_draft` | Back to Draft | review/approved → draft | log, action_link |
| `approve_immediately` | Approve immediately | draft/review → approved | log (required), action_link, additional callback |

Config install (`config/install/workflows.workflow.content.yml`) sets
`access_callback: entity_workflow_content_transition_access` on every transition;
`approve_immediately` additionally lists `additional_access_callbacks:
[entity_workflow_content_can_not_approve]`. `defaultConfiguration()` in
`src/Plugin/WorkflowType/EntityWorkflowContent.php` mirrors this and
`entity_workflow_content_entity_workflow_type_alter()` (`entity_workflow_content.module`) back-fills
the callback and applies defaults at load time.

## Permissions

`EntityWorkflowContent::getPermissions()` generates `use all content transitions` and, per transition,
`use content transition <id>` (e.g. `use content transition approve`). These surface through the base
module's permission callback (`entity_workflow.permissions.yml` →
`WorkflowType\Permissions::getPermissions()`).

## Access callback

`entity_workflow_content_transition_access($entity, $workflow, $transition_id, $account, $workspace)`:

1. Returns FALSE unless the account has `use <workflow_id> transition <transition_id>` OR
   `use all <workflow_id> transitions`.
2. If the transition has `additional_access_callbacks`, each is invoked (array form `[callback,
   [valid_states]]` runs only when the entity is in one of those states) and the results are combined
   with `orIf` (`_entity_workflow_content_process_access_hook_results()`); grants access if any allows
   and none denies.

`entity_workflow_content_can_not_approve()` returns allowed only when the normal `approve` transition
is NOT valid for the user — so "Approve immediately" appears only as a fallback.

## Cascade & workspace state

`onPostTransition()` collects the transitioned node's `path_alias` and `menu_link_content` entities
that the active workspace tracks and system-transitions them to the same target state, then invalidates
the workspace cache tags. Separately, the workspace submodule's event subscriber lowers the workspace
state to the lowest content state after a content transition.

## Workspace requirement

`type_settings.exclude_from_workspace_requirement` (schema: sequence of entity type → bundles) lets
entity types/bundles bypass the "must be in a workspace" rule. `Routing\RouteEnhancer::enhance()`
checks this list and, for content-workflow entity types with no active workspace, swaps the route
controller to `WorkspaceSwitcherController::switcher()`; when the active workspace's state is
closed/locked it swaps to `closed()` / `locked()`. `entity_workflow_content_form_alter()` hides Views
bulk-operations widgets when editing on Live (no active workspace).
