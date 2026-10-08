# Scheduler events

During cron processing `SchedulerManager` dispatches Symfony events so other modules can react
to (or adjust) an entity as it is published/unpublished. Each supported entity type has its own
event class in `Drupal\scheduler\Event`, named `Scheduler{Type}Events`:

- `SchedulerNodeEvents`, `SchedulerMediaEvents`, `SchedulerTaxonomyTermEvents`,
  `SchedulerCommerceProductEvents`.
- Legacy aliases `Drupal\scheduler\SchedulerEvents` / `SchedulerEvent` still point at the Node
  event class for backwards compatibility.

## Event constants (per type class)
- `PRE_PUBLISH` = `scheduler.pre_publish`
- `PUBLISH` = `scheduler.publish`
- `PRE_UNPUBLISH` = `scheduler.pre_unpublish`
- `UNPUBLISH` = `scheduler.unpublish`
- `PRE_PUBLISH_IMMEDIATELY` = `scheduler.pre_publish_immediately`
- `PUBLISH_IMMEDIATELY` = `scheduler.publish_immediately`

(The `*_immediately` events fire when an entity with a past `publish_on` date is saved and
published there and then instead of waiting for cron.)

## Subscribe
The dispatched object is a `\Drupal\scheduler\Event\SchedulerEvent`; call `$event->getEntity()`
to read/modify the entity (changes made in `PRE_*` handlers are saved by Scheduler).

```php
use Drupal\scheduler\Event\SchedulerNodeEvents;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;

class MySubscriber implements EventSubscriberInterface {
  public static function getSubscribedEvents(): array {
    return [SchedulerNodeEvents::PUBLISH => 'onPublish'];
  }
  public function onPublish(\Drupal\scheduler\Event\SchedulerEvent $event): void {
    $node = $event->getEntity();
    // ...
  }
}
```

Register the subscriber with the `event_subscriber` service tag.
