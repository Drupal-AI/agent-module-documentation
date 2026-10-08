# Entity Clone events

Entity Clone dispatches Symfony events (not classic hooks) around a clone. Constants in
`Drupal\entity_clone\Event\EntityCloneEvents`:

| Constant | Value | When |
|---|---|---|
| `PRE_CLONE` | `entity_clone.pre_clone` | Before the duplicate is saved. |
| `POST_CLONE` | `entity_clone.post_clone` | After the cloned entity is saved. |

The event object is `Drupal\entity_clone\Event\EntityCloneEvent`, exposing the original entity
and the (about-to-be / just) cloned entity plus optional properties.

## Subscribe
```yaml
# my_module.services.yml
services:
  my_module.clone_subscriber:
    class: Drupal\my_module\EventSubscriber\MyCloneSubscriber
    tags:
      - { name: event_subscriber }
```
```php
// src/EventSubscriber/MyCloneSubscriber.php
use Drupal\entity_clone\Event\EntityCloneEvents;
use Drupal\entity_clone\Event\EntityCloneEvent;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;

class MyCloneSubscriber implements EventSubscriberInterface {
  public static function getSubscribedEvents(): array {
    return [EntityCloneEvents::PRE_CLONE => 'onPreClone'];
  }
  public function onPreClone(EntityCloneEvent $event): void {
    $cloned = $event->getClonedEntity();
    // e.g. blank a field on the copy before it is saved.
    $cloned->set('field_publish_date', NULL);
  }
}
```
See `entity_clone.api.php` for the full example. Use PRE_CLONE to mutate the copy, POST_CLONE to
log/audit or trigger follow-up work.
