# Event: alter each media before it is saved

`Drupal\media_bulk_zip_upload\Event\MediaBulkZipUploadPreSaveEvent` is dispatched once **per
extracted file**, inside `MediaBulkZipUploadForm::processOneFile`, after the media entity has
been built and validated but **before** `$media->save()`. Subscribers can mutate the media
(set fields, retitle, unpublish, add metadata) and the result is what gets saved.

- Dispatched by **class name** (Symfony contracts dispatcher):
  `\Drupal::service('event_dispatcher')->dispatch($event)` — there is no string event-name
  constant; subscribe on `MediaBulkZipUploadPreSaveEvent::class`.
- Accessors: `getMedia(): MediaInterface` and `setMedia(MediaInterface $media): static`. After
  dispatch the form calls `$event->getMedia()`, so a subscriber that swaps in a different object
  must call `setMedia()`; mutating the object in place also works.

## Subscribe

```php
// src/EventSubscriber/MyMediaSubscriber.php
namespace Drupal\my_module\EventSubscriber;

use Drupal\media_bulk_zip_upload\Event\MediaBulkZipUploadPreSaveEvent;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;

class MyMediaSubscriber implements EventSubscriberInterface {

  public static function getSubscribedEvents(): array {
    return [MediaBulkZipUploadPreSaveEvent::class => ['onPreSave', 100]];
  }

  public function onPreSave(MediaBulkZipUploadPreSaveEvent $event): void {
    $media = $event->getMedia();
    $media->setUnpublished();
    // Or set a field, owner, moderation state, etc.
    $event->setMedia($media);
  }

}
```

Register the class as a service tagged `event_subscriber` (autoconfigured if your
`services.yml` uses `autoconfigure: true`). The module's own test module
(`media_bulk_zip_upload_test`) ships exactly this pattern (`MbzuTestEventSubscriber` unpublishes
each created media), which is the canonical example to copy.
