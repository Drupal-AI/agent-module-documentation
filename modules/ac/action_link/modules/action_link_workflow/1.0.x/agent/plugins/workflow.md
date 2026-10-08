<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# workflow State Action plugin (experimental)

`src/Plugin/StateAction/Workflow.php` — `#[StateAction(id: 'workflow', directions: [],
dynamic_parameters: ['entity'], deriver: WorkflowActionLinkDeriver::class)]`, extends
`StateActionBase`, `ContainerFactoryPluginInterface`. Deps: dynamic parameter upcaster,
`entity_type.manager`. `workflowId` is taken from the plugin derivative id.

## Deriver

`src/Plugin/Derivative/WorkflowActionLinkDeriver.php` derives one plugin per `workflow` config entity
(`entity_type.manager` → storage `workflow` → `loadMultiple()`), label `Workflow: <label>`. So the
usable plugin ids are `workflow:<workflow_id>`.

## Behaviour

- `getDirections()`: loads the workflow, returns `getTypePlugin()->getTransitions()` mapped to their
  labels (transition id ⇒ label). (There is dead code after the first `return`.)
- `getNextStateName($direction, $user, $entity)`: `$current_state = $entity->moderation_state->value`;
  finds transitions valid for that state; if the requested `$direction` (a transition id) is among
  them, returns `getTransition($direction)->to()->id()`, else NULL.
- `getLinkLabel()`: transition label.
- `getActionRoute()`: extends the base route and sets the `entity` parameter type — **hardcoded**
  `type: entity:node` (`@todo` derive from configuration).

## Known incompleteness

- `advanceState()` — empty stub (does not apply the transition).
- config form is only present as `XbuildConfigurationForm()` (effectively disabled).
- `getMessage()` returns a constant string.
- entity type fixed to node.

This plugin is a scaffold; a production workflow action would need `advanceState()` implemented (apply
the moderation transition and save), a configurable target entity type/field, and real per-transition
access logic. Route-level authorization/CSRF for any link still runs through the core
`ActionLinkController`.
