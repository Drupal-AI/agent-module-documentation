# The state field API + services

The current state is stored in a `state` field item implementing
`Drupal\state_machine\Plugin\Field\FieldType\StateItemInterface`. **Never set the raw value** —
apply a transition so validation and events run.

```php
/** @var \Drupal\state_machine\Plugin\Field\FieldType\StateItemInterface $state */
$state = $entity->get('field_state')->first();

$state->getId();                 // current state id, e.g. 'fulfillment'
$state->getLabel();              // human label of current state
$state->getOriginalId();         // state id before this request's change
$state->getWorkflow();           // WorkflowInterface|FALSE
$state->getTransitions();        // allowed WorkflowTransition[] from current state
$state->isTransitionAllowed('fulfill');

$state->applyTransitionById('fulfill');   // throws InvalidArgumentException if not allowed
// or: $state->applyTransition($transition);
$entity->save();                          // events fire here (see extend/events.md)
```

Entities often expose a getter (`$order->getState()->applyTransitionById('fulfill')`). Because
the `to` id is resolved from the transition, the same transition id works across workflows that
share it.

## Workflow / group services
```php
$workflow = \Drupal::service('plugin.manager.workflow')->createInstance('default');
$workflow->getStates();                       // WorkflowState[]
$workflow->getState('completed');
$workflow->getTransitions();
$workflow->getAllowedTransitions('new', $entity);  // runs guards for $entity
$workflow->getPossibleTransitions('new');          // ignores guards

$groups = \Drupal::service('plugin.manager.workflow_group')->getGroups('commerce_order');
```

## Validation & Views
- `StateConstraint` (`state_machine_state`) rejects a submitted state that isn't reachable via an
  allowed transition — useful for REST/JSON:API writes.
- A Views filter (`state_machine_state`) is auto-wired onto state fields via
  `hook_field_views_data()`.
