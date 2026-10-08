<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field type, transition API, events & access

## Field type `entity_workflow_state`

`src/Plugin/Field/FieldType/EntityWorkflowStateItem.php` (`@FieldType id = "entity_workflow_state"`,
widget `options_select`, formatter `list_default`, cardinality 1, list class
`EntityWorkflowStateFieldItemList`). Stores a single `value` (varchar 255 = state ID). Storage
settings `workflow` / `workflow_callback` bind the field to a workflow (`getWorkflow()` →
`Workflow::load()`). Implements `OptionsProviderInterface`; `getSettableOptions()` /
`getAllowedTransitions()` only offer states reachable by transitions that pass
`StateTransitionValidator::isTransitionValid()` for the current user. Validation constraint
`EntityWorkflowState` replaces core `AllowedValuesConstraint`.

Get the field/state from an entity: `entity_workflow_get_field($entity, $workflow_id)`,
`entity_workflow_get_entity_state($entity, $workflow_id)`, field name
`entity_workflow_get_field_name($workflow_id)` = `entity_workflow_<workflow_id>`
(`entity_workflow.module`).

## Applying a transition

Two procedural entry points in `entity_workflow.module`:

- `entity_workflow_transition($entity, $workflow_id, $transition_id, $log = '', $context = [])` —
  builds the transition and dispatches `InitiateTransitionEvent`
  (`EntityWorkflowEvents::INITIATE_TRANSITION`).
- `entity_workflow_system_transition($entity, $workflow_id, $to, $log = '', $context = [])` — uses the
  special `__system` transition (`SYSTEM_TRANSITION`, from-any to-any), applies it directly and saves
  with `_entityWorkflowEnforceNoNewRevision`.

`EventSubscriber\EntityWorkflowEventSubscriber` (`entity_workflow.event_subscriber`):

- `onInitiateTransaction()` — `entity_workflow_get_field(...)->applyTransition(...)`, sets
  `_entityWorkflowEnforceNoNewRevision`, `$entity->save()`, extends the PHP time limit.
- `preTransition()` / `postTransition()` — call the plugin's `onPreTransition()` / `onPostTransition()`
  and, when `context['log']` is set, write a `workflow_transition_log` entry.

`EntityWorkflowStateItem::applyTransition()` stores the target state, and on save
(`preSave()`/`postSave()`) dispatches `PreTransitionEvent` / `PostTransitionEvent` when the value
changed. `EntityWorkflowStateFieldItemList::preSave()` clears the state in the default (Live)
workspace and applies the workflow's `default_transition` when an entity first enters a workspace.
`entity_workflow_entity_presave()` enforces the no-new-revision flag.

## Events (`src/Event/`)

`EntityWorkflowEvents::INITIATE_TRANSITION` (constant), plus `InitiateTransitionEvent`,
`PreTransitionEvent`, `PostTransitionEvent`, `EntityWorkflowTransitionEvent` (base). Subscribe to
these to run side effects on state change (the workspace submodule uses them to publish/revert a
workspace and to cascade the workspace state).

## Access: `StateTransitionValidator`

Service `entity_workflow.state_transition_validation` (`src/StateTransitionValidator.php`).
`isTransitionValid($entity, $workflow, $transition_id, $user, $workspace = NULL)`:

1. `__system` transitions are always allowed.
2. Unknown transition ID → deny.
3. Requires an active workspace (unless the entity is a workspace).
4. Rejects invalid `from` states and self-transitions.
5. Reads the transition's `access_callback`; **if none exists, the transition is allowed**. Otherwise
   calls `$callback($entity, $workflow, $transition_id, $user, $workspace, ...access_arguments)`.

`getValidTransitions()` filters all transitions through this. The shipped workflows set an
`access_callback` on every transition, so those callbacks (in the submodule `.module` files) perform
the `hasPermission()` checks and any additional business rules; see the submodule docs.

## Hooks (`entity_workflow.api.php`)

- `hook_entity_workflow_type_alter(&$configuration, $plugin_id)` — alter a workflow plugin's config
  (also invoked from `EntityWorkflowTypeBase::setConfiguration()`).
- `hook_entity_workflow_has_bulk_workflow_alter(&$access, $workflow, $entity)` — grant access to the
  bulk workflow tab (default FALSE).
- `hook_entity_workflow_bulk_workflow_entities($workflow, $entity)` — return the entities shown on the
  bulk form (keyed `<entity_type>--<id>`).

## Transition log entity

`workflow_transition_log` (internal `@ContentEntityType`, `src/Entity/WorkflowTransitionLog.php`,
base table `workflow_transition_log`, storage `WorkflowTransitionLogStorage`,
storage-schema `WorkflowTransitionLogStorageSchema`). Fields: `workflow_id`, `workspace_id`,
`entity_type_id`, `entity_id` / `entity_id_string`, `entity_revision_id`, `state`, `previous_state`,
`transition`, `uid`, `created`, `log`. `writeLogEntry()` inserts directly into the base table and
invalidates the `workflow_transition_log_list` cache tag. Read history with
`entity_workflow_get_history()`; logs are cleaned up by `entity_workflow_entity_delete()` /
`entity_workflow_entity_revision_delete()`. Views argument `SourceEntityId`
(`src/Plugin/views/argument/`) handles numeric-or-string source IDs; the `workflow_transition_log`
View is installed from `config/install/`.
