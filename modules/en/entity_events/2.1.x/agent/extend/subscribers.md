<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Writing an Entity Events subscriber

You consume Entity Events by **extending one of its abstract subscriber base classes** and
registering your subclass as an `event_subscriber` service. Each base class already implements
`getSubscribedEvents()` for you.

## The base classes (`Drupal\entity_events\EventSubscriber`)

| Base class | Abstract method you implement | Subscribes to |
|---|---|---|
| `EntityEventInsertSubscriber` | `onEntityInsert(EntityEvent $event)` | `event.insert` |
| `EntityEventUpdateSubscriber` | `onEntityUpdate(EntityEvent $event)` | `event.update` |
| `EntityEventPresaveSubscriber` | `onEntityPresave(EntityEvent $event)` | `event.presave` |
| `EntityEventDeleteSubscriber` | `onEntityDelete(EntityEvent $event)` | `event.delete` |
| `EntityEventPredeleteSubscriber` | `onEntityPredelete(EntityEvent $event)` | `event.predelete` |
| `EntityEventSubscriber` | any/all of the five `onEntity*()` (all have empty default bodies) | all five events |

The single-event base classes declare their `onEntity*()` **abstract** (you must implement it);
the combined `EntityEventSubscriber` provides empty implementations of all five so you override
only the ones you need. All subscribe at priority `800`.

## 1. Write the subscriber

```php
namespace Drupal\mymodule\EventSubscriber;

use Drupal\entity_events\Event\EntityEvent;
use Drupal\entity_events\EventSubscriber\EntityEventInsertSubscriber;

class NodeCreatedSubscriber extends EntityEventInsertSubscriber {

  public function onEntityInsert(EntityEvent $event) {
    $entity = $event->getEntity();
    if ($entity->getEntityTypeId() !== 'node') {
      return;
    }
    // Your reaction, e.g. log, notify, enqueue…
    \Drupal::logger('mymodule')->notice('Created @t @id', [
      '@t' => $entity->bundle(), '@id' => $entity->id(),
    ]);
  }

}
```

(Prefer constructor dependency injection over `\Drupal::` in real code; the example keeps it
short.)

## 2. Register it as a service

In `mymodule.services.yml`:

```yaml
services:
  mymodule.node_created_subscriber:
    class: Drupal\mymodule\EventSubscriber\NodeCreatedSubscriber
    tags:
      - { name: event_subscriber }
```

Rebuild the container (`drush cr`) and the subscriber fires on the next matching entity save.

## Notes

- Subscribers receive **every** entity type — always filter on
  `$event->getEntity()->getEntityTypeId()` (and `->bundle()`).
- On `event.presave` for a *new* entity the id is not yet assigned; use `event.insert` if you
  need the saved id.
- Because the base classes' `getSubscribedEvents()` already maps the event name to the method,
  you never write `getSubscribedEvents()` yourself unless you subclass `EntityEventSubscriber`
  and want to change priorities.
