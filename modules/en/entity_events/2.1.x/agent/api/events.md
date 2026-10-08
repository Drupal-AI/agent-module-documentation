<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Events — events and the `EntityEvent` object

Entity Events implements the five core entity hooks and dispatches an `EntityEvent` for each,
using the event names below. There is nothing to configure — enabling the module makes the
events fire for every entity save/delete.

## Event names (`Drupal\entity_events\EntityEventType` constants)

| Constant | Value | Fires from core hook |
|---|---|---|
| `EntityEventType::INSERT` | `event.insert` | `hook_entity_insert()` (after a new entity is saved) |
| `EntityEventType::UPDATE` | `event.update` | `hook_entity_update()` (after an existing entity is saved) |
| `EntityEventType::PRESAVE` | `event.presave` | `hook_entity_presave()` (before save) |
| `EntityEventType::DELETE` | `event.delete` | `hook_entity_delete()` (after delete) |
| `EntityEventType::PREDELETE` | `event.predelete` | `hook_entity_predelete()` (before delete) |

Subscribe using the constant or the literal string; they are equal. In
`getSubscribedEvents()` the base classes subscribe at priority `800`.

## The dispatched object

`Drupal\entity_events\Event\EntityEvent` (extends
`Drupal\Component\EventDispatcher\Event`) exposes exactly two getters:

```php
$event->getEntity();     // \Drupal\Core\Entity\EntityInterface — the affected entity
$event->getEventType();  // string — the event type it was constructed with (e.g. 'event.update')
```

There are no setters and no way to cancel the underlying save/delete from the event (presave/
predelete still run, but stopping propagation does not veto the operation — use standard entity
validation/access for that).

## How dispatch happens

`Drupal\entity_events\Hook\EntityEventsHooks` (autowired service, tagged as the hook
implementations via `#[Hook(...)]` attributes, with `#[LegacyHook]` shims in
`entity_events.module`) constructs a `new EntityEvent(EntityEventType::X, $entity)` and calls
`$this->eventDispatcher->dispatch($event, EntityEventType::X)` for each of the five hooks. Every
entity type flows through the same dispatch, so a subscriber must filter by entity type/bundle
itself:

```php
public function onEntityUpdate(EntityEvent $event) {
  $entity = $event->getEntity();
  if ($entity->getEntityTypeId() !== 'node' || $entity->bundle() !== 'article') {
    return;
  }
  // react to article updates…
}
```

To write and register a subscriber, see [../extend/subscribers.md](../extend/subscribers.md).
