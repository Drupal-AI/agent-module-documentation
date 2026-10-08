<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Executing & reading transitions programmatically

## Reading the current state

Global helpers in `workflow.module`:

```php
workflow_node_current_state($entity, $field_name);   // current state id (sid)
workflow_node_previous_state($entity, $field_name);  // previous sid
workflow_node_creation_state($entity, $field_name);  // the (creation) sid
$entity->{$field_name}->value;                        // the raw stored sid
```

`WorkflowManager` (service `workflow.manager`, `WorkflowManagerInterface`) finds workflow fields:
`getFieldMap($entity_type_id)`, `getWorkflowFieldDefinitions(...)`, `getPossibleFieldNames(...)`.
Convenience wrapper: `workflow_get_workflow_manager()`.

## Executing a transition

An executed transition is a `workflow_transition` content entity (table
`workflow_transition_history`). Create → set values → execute:

```php
use Drupal\workflow\Entity\WorkflowTransition;

/** @var \Drupal\workflow\Entity\WorkflowTransitionInterface $transition */
$transition = WorkflowTransition::create([$from_sid, 'field_name' => $field_name]);
$transition->setTargetEntity($entity);
$transition->setValues(
  $to_sid,          // new state id
  $uid,             // author (defaults to current user)
  \Drupal::time()->getRequestTime(),
  'Approved by editor'   // comment
);
$new_sid = $transition->executeAndUpdateEntity($force = FALSE);   // saves entity + history
```

Shorthands:
- `workflow_execute_transition($transition, $force)` ⇒ `$transition->executeAndUpdateEntity($force)`.
- `$transition->execute()` runs the transition **without** re-saving the host entity (use
  `executeAndUpdateEntity()` when you also want the entity's field updated & saved).
- `$force = TRUE` bypasses the "is this transition allowed for this user/role" check
  (`$transition->isAllowed($user, $force)`).

## Scheduling a transition

Set a future timestamp and mark it scheduled; cron (`workflow_cron`) executes due ones:

```php
$transition->schedule(TRUE);
$transition->setTimestamp($future_ts);
$transition->save();     // stored as workflow_scheduled_transition (table workflow_transition_schedule)
```

## Events & the transition lifecycle

Dispatched around every execution (subscribe in a normal `EventSubscriber`):

- `WorkflowEvents::PRE_TRANSITION` = `'workflow.pre_transition'`
- `WorkflowEvents::POST_TRANSITION` = `'workflow.post_transition'`

Both carry a `WorkflowTransitionEvent` (`$event->getTransition()`). The legacy hook
`hook_workflow('transition pre' | 'transition post', $transition, $user)` fires too — see
[../hooks/hooks.md](../hooks/hooks.md). Returning FALSE from a `pre` handler vetoes the transition.

## Options lists (for widgets / allowed values)

`WorkflowState::getOptions($entity, $field_name, $account, $force)` returns the target states a
user may move to from the current state. `workflow_state_allowed_values()` is the field's
allowed-values callback (do not hardcode allowed values on a workflow field).
