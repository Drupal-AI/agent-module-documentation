<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The Workspace workflow

## States (`workflows.workflow.workspace`)

Each state adds `locked` and `status` (open/closed, constants `WSE_STATUS_OPEN` / `WSE_STATUS_CLOSED`):

| State | Label | locked | status |
|---|---|---|---|
| `draft` | Draft | false | open |
| `review` | Ready for Review | false | open |
| `approved` | Approved | true | open |
| `published` | Published | true | closed |

Default state `draft`, default transition `new_draft`. State config is edited with
`Form\WorkspaceStateForm` and read via the `WorkspaceState` value object.

## Transitions

`new_draft` (→draft), `submit_for_review` (draft→review), `approve` (review→approved),
`back_to_draft` (review/approved→draft), `publish` (approved→published),
`unpublish` (published→draft). All get `access_callback:
entity_workflow_workspace_transition_access` (from config install +
`entity_workflow_workspace_entity_workflow_type_alter()`); most set `transition_log` + `action_link`.

`EntityWorkflowWorkspace::onPreTransition()` sets `$entity->set('status', $to_state->getStatus())` so
the workspace open/closed flag tracks the target state.

## Publish / unpublish wiring

`EventSubscriber\EntityWorkflowWorkspaceEventSubscriber` (priority 50 on
`INITIATE_TRANSITION`, before the base subscriber):

- transition **to `published`** → `$workspace->publish()` (WSE publish);
- transition **`unpublish`** → `wse.workspace_reverter`/`Drupal\wse\WorkspaceReverter::revert()`.

`postTransition()` (on the `content` workflow) recomputes the lowest content state across tracked
entities and system-transitions the workspace to it (`entity_workflow_get_entity_states()` +
`entity_workflow_system_transition()`), unless the transition was cascaded or bulk.
`onFieldStorageDefinitionCreate()` seeds workspace workflow state (draft/published) from existing WSE
open/closed status when the field is installed. `onLastPublishedWorkspaceChange()` invalidates cache
tags when the last-published workspace changes (WSE pre-publish / post-revert events).

## Access rules

`entity_workflow_workspace_transition_access()` — requires `use workspace transition <id>` OR
`use all workspace transitions`, then defers to `$entity->access($transition_id)`.

`entity_workflow_workspace_workspace_access()` (`hook_ENTITY_TYPE_access`) handles workspace ops whose
name matches a transition ID:

- deny without the transition permission;
- deny transitions other than `new_draft`/`unpublish` on an empty workspace;
- `unpublish` allowed only for the last-published workspace (matches WSE revert; a `drupal_static`
  caches the last-published id, reset by the event subscriber);
- `publish` allowed only when no tracked content is in a non-`approved` state
  (`entity_workflow_has_not_entity_state('content', …, 'approved')`);
- otherwise `AccessResult::allowedIfHasPermission(... 'use workspace transition <op>')`.

`publish workspaces always` is an extra permission for bypassing the workflow when publishing.

## Locking & UI

`Plugin\Validation\Constraint\LockedWorkspaceConstraint(+Validator)` (added to workspace-supported
types by `hook_entity_type_alter()`) blocks editing content while the workspace is locked.
`EntityWorkflowWorkspaceListBuilder` customises workspace operations/switcher;
`entity_workflow_workspace_workspace_view_alter()` shows the current state;
`entity_workflow_workspace_form_alter()` embeds `WseWorkspacePublishForm` into the workflow /
simple-transition form when the chosen transition is `publish`, wiring its validate handlers.
