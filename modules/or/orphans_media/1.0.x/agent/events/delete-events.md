# Pre / post delete events (events)

When a media entity is deleted through the batch worker
(`OrphansMediaDeleteMediaEntityBatchProcess::delete()`), the module dispatches two events around the
`$media->delete()` call. Subscribe to them to log deletions, notify, or clean up related data.

## Event names & classes

Names are constants on the interface
`Drupal\orphans_media\Event\OrphansMediaDeleteMediaEntityEventInterface`:

| Constant | String value | Event object | Fired |
|---|---|---|---|
| `PRE_DELETE_EVENT` | `orphans_media.pre_delete_media_entity` | `OrphansMediaPreDeleteMediaEntityEvent` | **before** `$media->delete()` |
| `POST_DELETE_EVENT` | `orphans_media.post_delete_media_entity` | `OrphansMediaPostDeleteMediaEntityEvent` | **after** `$media->delete()` |

Both event objects extend Symfony's `Event` and expose the media as a public promoted property:

```php
public function __construct(public MediaInterface $media) {}
```

- Pre event: `$event->media` is the **live** media entity (still saved) — useful to read fields or
  files before removal.
- Post event: `$event->media` is a **clone captured before deletion** (`$mediaDeleted = clone $media;`
  is taken before `$media->delete()` and passed to the post event) — the entity no longer exists in
  storage, but its field values are still readable on the clone.

Note: `OrphansMediaPostDeleteMediaEntityEvent` implements the interface (so its constant is on the
object), while `OrphansMediaPreDeleteMediaEntityEvent` does not — reference the constant via the
interface name in both cases.

## Subscriber example

```php
namespace Drupal\my_module\EventSubscriber;

use Drupal\orphans_media\Event\OrphansMediaDeleteMediaEntityEventInterface as OmEvents;
use Drupal\orphans_media\Event\OrphansMediaPostDeleteMediaEntityEvent;
use Drupal\orphans_media\Event\OrphansMediaPreDeleteMediaEntityEvent;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;

class MediaCleanupSubscriber implements EventSubscriberInterface {

  public static function getSubscribedEvents(): array {
    return [
      OmEvents::PRE_DELETE_EVENT => 'onPreDelete',
      OmEvents::POST_DELETE_EVENT => 'onPostDelete',
    ];
  }

  public function onPreDelete(OrphansMediaPreDeleteMediaEntityEvent $event): void {
    // $event->media is the live media entity.
  }

  public function onPostDelete(OrphansMediaPostDeleteMediaEntityEvent $event): void {
    // $event->media is a clone of the just-deleted entity.
  }

}
```

Register it as a `event_subscriber`-tagged service in your module's `*.services.yml`. The events
fire only via the module's own delete batch (deletions made directly through core media routes do
not trigger them).
