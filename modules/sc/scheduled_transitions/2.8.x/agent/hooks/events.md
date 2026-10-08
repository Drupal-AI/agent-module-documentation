<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Events

Scheduled Transitions has no procedural hooks to implement; it exposes **one event** (see
`scheduled_transitions.api.php`).

## `ScheduledTransitionsEvents::NEW_REVISION` (`'scheduled_transitions.new_revision'`)

Dispatched by `ScheduledTransitionsRunner::runTransition()` to decide **which revision** gets
transitioned. The default subscriber (`EventSubscriber\ScheduledTransitionsNewRevision`) picks
the sensible revision; subscribe with higher priority and `stopPropagation()` to override.

```php
use Drupal\scheduled_transitions\Event\ScheduledTransitionsEvents;
use Drupal\scheduled_transitions\Event\ScheduledTransitionsNewRevisionEvent;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;

class MySubscriber implements EventSubscriberInterface {
  public function newRevision(ScheduledTransitionsNewRevisionEvent $event): void {
    $scheduledTransition = $event->getScheduledTransition();
    $entity = $scheduledTransition->getEntity();
    $event->setNewRevision($entity); // choose the revision to transition
    $event->stopPropagation();
  }
  public static function getSubscribedEvents(): array {
    return [ScheduledTransitionsEvents::NEW_REVISION => ['newRevision']];
  }
}
```

Register the class as a tagged `event_subscriber` service.
