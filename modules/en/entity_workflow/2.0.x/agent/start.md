<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Workflow (entity_workflow) — agent index

Attaches a **per-entity state-transition workflow** to content that lives inside a Drupal
**Workspace**. Built on core **Workflows** (`WorkflowType` plugins) + the contrib **Workspaces/WSE**
stack. Each workflow adds an `entity_workflow_state` base field to its target entity types; a
transition changes that field's value and dispatches events. Version-dir **2.0.x** (installed
release `2.0.0-beta8`, pre-release). Core `^11.3 || ^12`. License GPL-2.0-or-later.

Dependencies (`entity_workflow.info.yml`): `drupal:workflows`, `drupal:workspaces`. No composer.json.
Submodules ship the default workflows and pull in `workspaces_ui` / `wse`.

## What it provides (from source)

- **Field type** `entity_workflow_state` (`src/Plugin/Field/FieldType/EntityWorkflowStateItem.php`)
  with list class `EntityWorkflowStateFieldItemList` — one revisionable base field per workflow,
  named `entity_workflow_<workflow_id>` (`entity_workflow_get_field_name()`).
- **WorkflowType plugin base** `WorkflowType/EntityWorkflowTypeBase` (extends core `WorkflowTypeBase`)
  + interface/trait — concrete plugins live in the submodules. Custom state/transition value objects
  `EntityWorkflowState`, `EntityWorkflowTransition`.
- **Transition engine**: procedural API `entity_workflow_transition()` / `entity_workflow_system_transition()`
  (`entity_workflow.module`) → `InitiateTransitionEvent` → `EntityWorkflowEventSubscriber` applies it;
  pre/post events fire from the field item. Access is decided by `StateTransitionValidator`
  (service `entity_workflow.state_transition_validation`).
- **Content entity** `workflow_transition_log` (internal; `src/Entity/WorkflowTransitionLog.php`)
  written by `WorkflowTransitionLogStorage::writeLogEntry()`; history View `workflow_transition_log`
  (`config/install/`), custom Views argument `SourceEntityId`.
- **Routes** added dynamically by `Routing\RouteSubscriber` (no `*.routing.yml`): per-entity workflow
  tab, simple/confirm transition, and bulk transition forms; local tasks + action links via derivatives.
- **Permissions**: dynamic, via `WorkflowType\Permissions::getPermissions()` (permission callback).
- **Services** (`entity_workflow.services.yml`): `entity_workflow.info`,
  `entity_workflow.state_transition_validation`, route subscriber, event subscribers, entity-schema listener.

## Solution docs

- Config entities, states/transitions schema, default workflows, permissions →
  [config/workflows.md](config/workflows.md)
- Field type, transition API, events, validator/access callbacks, transition log →
  [api/transitions.md](api/transitions.md)
- Dynamic routes, forms, access checks, local tasks/action links →
  [routes/forms.md](routes/forms.md)

## Submodules (own doc trees)

- `entity_workflow_content` — Draft/Review/Approved workflow for content entities →
  [modules/entity_workflow_content/2.0.x/agent/start.md](../../modules/entity_workflow_content/2.0.x/agent/start.md)
- `entity_workflow_workspace` — Draft/Review/Approved/Published workflow for workspaces →
  [modules/entity_workflow_workspace/2.0.x/agent/start.md](../../modules/entity_workflow_workspace/2.0.x/agent/start.md)
