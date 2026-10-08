<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Config entities, schema & permissions

## Install / enable

Enable `entity_workflow` plus at least one submodule that provides a workflow
(`entity_workflow_content` and/or `entity_workflow_workspace`). Requires core `workflows` and the
`workspaces` stack (the content submodule also needs `workspaces_ui`; the workspace submodule needs
`wse`). There is no settings form and no `configure` route — workflows are edited through the core
Workflows admin UI (`/admin/config/workflow/workflows`).

## Config entity: `workflow`

Entity Workflow does not define its own config entity type. It defines core **`WorkflowType`
plugins**, so each workflow is a standard core `workflows.workflow.*` config entity whose
`type_settings` follow the schema in `config/schema/entity_workflow.schema.yml`:

- `entity_workflow.type_settings` — `entity_types` (sequence keyed by entity type ID → list of
  bundle IDs; empty list = all bundles), `default_state`, `default_state_callback` (nullable),
  `default_transition`, `default_transition_log` (nullable), `states` (sequence), `transitions`
  (sequence).
- `entity_workflow.state` (`type: workflows.state`) — adds `locked` (bool) and `status` (string).
- `entity_workflow.transition` (`type: workflows.transition`) — adds `access_callback` (string),
  `transition_log` (bool), `transition_log_required` (bool), `action_link` (bool).

Submodule schema extends this: `entity_workflow_content.transition` adds
`additional_access_callbacks` (sequence of function names) and its `type_settings` add
`exclude_from_workspace_requirement`; `workflow.type_settings.entity_workflow_workspace` reuses the
base `type_settings` unchanged (see the submodule docs).

State/transition config is turned into value objects by `EntityWorkflowTypeBase::getState()` →
`EntityWorkflowState` and `getTransition()` → `EntityWorkflowTransition`. `EntityWorkflowTransition`
reads `access_callback`, `access_callback_arguments`, `transition_log`, `transition_log_required`,
`transition_confirmation`, `action_link` off the config array.

## Applying a workflow to entity types/bundles

`WorkflowType/EntityWorkflowTypeBase` stores `entity_types` in config. `getEntityTypes()`,
`getBundlesForEntityType()` and `appliesToEntityTypeAndBundle()` read it (empty bundle list = every
bundle). `entity_workflow_entity_bundle_info_alter()` (`entity_workflow.module`) writes
`entity_workflows[<workflow_id>] = label` onto each matching bundle, which the
`EntityWorkflowInfo` service (`entity_workflow.info`) queries via `getWorkflowsInfoForEntityType()` /
`getWorkflowsInfoForEntityTypeAndBundle()` / `isEntityTypeSupported()`.

## Base field lifecycle

When a workflow config entity is created/updated/deleted, `entity_workflow_workflow_insert/update/delete()`
(hooks in `entity_workflow.module`) install/uninstall the `entity_workflow_state` base field for each
target entity type (via `EntityDefinitionUpdateManager`), rebuild the router, and clear bundle caches.
`entity_workflow_entity_base_field_info()` / `entity_workflow_entity_bundle_field_info()` also declare
the field. `EventSubscriber\EntitySchemaSubscriber` (`entity_workflow.entity_schema_listener`) keeps
field storage in sync. `entity_workflow_field_info_alter()` provides a `workflow_state` BC alias.

## Permissions

`entity_workflow.permissions.yml` delegates to a permission callback
`WorkflowType\Permissions::getPermissions()`, which loops every entity workflow
(`EntityWorkflowInfo::getWorkflowEntities()`) and merges each plugin's `getPermissions()`. The base
`EntityWorkflowTypeBase::getPermissions()` returns `[]`; the submodules generate the real permissions
(e.g. `use all content transitions`, `use content transition <id>`, `use all workspace transitions`,
`use workspace transition <id>`, `publish workspaces always`). Which transition a permission gates is
enforced by the per-transition `access_callback` at runtime — see
[../api/transitions.md](../api/transitions.md).

## Default workflows shipped

- `entity_workflow_content` installs `workflows.workflow.content` (states draft/review/approved).
- `entity_workflow_workspace` installs `workflows.workflow.workspace` (states
  draft/review/approved/published, with `locked`/`status` per state).

Both are documented in their own doc trees; the config-install YAML sets an `access_callback` on
every transition.
