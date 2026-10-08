# Transition events

When a transition has been applied, the state field dispatches events on `$entity->save()`.
`pre_transition` fires **before** the save (you may still modify the entity); `post_transition`
fires **after**. Every listener receives a
`Drupal\state_machine\Event\WorkflowTransitionEvent`.

Three granularities, dispatched for each transition:

| Pattern | Example | Use for |
|---|---|---|
| `{group}.{transition}.{phase}` | `commerce_order.fulfill.post_transition` | a specific transition |
| `{group}.{phase}` | `commerce_order.post_transition` | any transition in the group (react by `to` state) |
| `state_machine.{phase}` | `state_machine.post_transition` | every transition site-wide (logging, metrics) |

`{phase}` is `pre_transition` or `post_transition`.

```php
// mymodule.services.yml -> tags: [{ name: event_subscriber }]
public static function getSubscribedEvents() {
  return ['commerce_order.fulfill.post_transition' => 'onFulfill'];
}

public function onFulfill(WorkflowTransitionEvent $event) {
  $event->getEntity();          // the ContentEntity
  $event->getTransition();      // WorkflowTransition ($->getToState(), getId())
  $event->getWorkflow();
  $event->getFieldName();       // state field name
  $event->getField();           // StateItemInterface (getOriginalId() = "from" state)
}
```

- In `pre_transition` you can still call `$event->getEntity()->set(...)`; changes persist with
  the save in progress.
- Determine the "from" state via `$event->getField()->getOriginalId()` (the older
  `getFromState()`/`getToState()` helpers are deprecated).
