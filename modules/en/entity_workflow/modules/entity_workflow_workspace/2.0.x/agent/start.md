<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Workflow Workspace (entity_workflow_workspace) — agent index

Submodule of **entity_workflow**. Provides the default **Workspace** workflow (Draft → Ready for
Review → Approved → Published) whose Publish/Unpublish transitions publish and revert the workspace via
WSE. Version-dir **2.0.x** (release `2.0.0-beta8`). Core `^11.3 || ^12`. Depends on
`entity_workflow:entity_workflow` and `wse:wse` (`entity_workflow_workspace.info.yml`).

## What it provides (from source)

- **WorkflowType plugin** `entity_workflow_workspace` —
  `src/Plugin/WorkflowType/EntityWorkflowWorkspace.php`. `required_states`
  draft/review/approved/published; forms `configure`/`transition` from the base module plus
  `state` = `Form\WorkspaceStateForm` (edits per-state `locked` + open/closed `status`). Uses
  `src/WorkspaceState.php` value object (`getStatus()`, `isLocked()`).
- **Config**: installs `workflows.workflow.workspace`
  (`config/install/workflows.workflow.workspace.yml`); schema
  `config/schema/entity_workflow_workspace.schema.yml` reuses the base `type_settings`.
- **Permissions** (plugin `getPermissions()`): `use all workspace transitions`,
  `use workspace transition <id>`, and `publish workspaces always`.
- **Access** `entity_workflow_workspace_transition_access()` + `hook_ENTITY_TYPE_access()`
  (`entity_workflow_workspace_workspace_access`) enforce transition permissions on the `workspace`
  entity, block publishing until all tracked content is `approved`, block transitions on empty
  workspaces, and restrict `unpublish` to the last-published workspace.
- **Transition side effects** `EntityWorkflowWorkspace::onPreTransition()` sets the workspace
  open/closed status; `EventSubscriber\EntityWorkflowWorkspaceEventSubscriber` publishes the workspace
  on a transition to `published`, reverts on `unpublish`, cascades the workspace state to the lowest
  content state after content transitions, and seeds workflow state on field-storage creation.
- **Constraint** `Plugin\Validation\Constraint\LockedWorkspace(+Validator)` blocks editing content of a
  locked workspace (added to workspace-supported entity types via `hook_entity_type_alter()`).
- **UI**: `EntityWorkflowWorkspaceListBuilder` (custom operations/switcher),
  `hook_ENTITY_TYPE_view_alter()` shows the state, `hook_form_alter()` embeds the WSE publish form into
  the workflow form for the Publish transition. `Routing\RouteSubscriber` + `src/Hook/HookOrder.php`.

## Solution docs

- The Workspace workflow: states/status, transitions, publish/unpublish wiring, access rules →
  [workflow/workspace-workflow.md](workflow/workspace-workflow.md)

Base engine is documented in the parent:
[../../../2.0.x/agent/start.md](../../../2.0.x/agent/start.md).
