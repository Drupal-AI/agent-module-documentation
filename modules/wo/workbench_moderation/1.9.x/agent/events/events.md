<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The state-transition event

On every moderated save that changes (or sets) an entity's moderation state,
`EntityOperations` dispatches:

- **Event name:** `WorkbenchModerationEvents::STATE_TRANSITION`
  = `'workbench_moderation.state_transition'`.
- **Event object:** `\Drupal\workbench_moderation\Event\WorkbenchModerationTransitionEvent`.

Event object methods:

| Method | Returns |
|---|---|
| `getEntity()` | the `ContentEntityInterface` being saved |
| `getStateBefore()` | previous moderation state id (may be empty for new content) |
| `getStateAfter()` | new moderation state id |

## Subscribe to it

```php
use Drupal\workbench_moderation\Event\WorkbenchModerationEvents;
use Drupal\workbench_moderation\Event\WorkbenchModerationTransitionEvent;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;

class MyModerationSubscriber implements EventSubscriberInterface {
  public static function getSubscribedEvents(): array {
    return [WorkbenchModerationEvents::STATE_TRANSITION => 'onTransition'];
  }
  public function onTransition(WorkbenchModerationTransitionEvent $event): void {
    if ($event->getStateAfter() === 'published') {
      // e.g. notify, purge cache, ping an external system…
      $entity = $event->getEntity();
    }
  }
}
```

Register the class as a `event_subscriber`-tagged service. This is the module's main code
extension point for reacting to publish/unpublish/workflow changes.
