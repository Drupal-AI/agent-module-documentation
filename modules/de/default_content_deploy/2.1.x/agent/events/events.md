# Events

Constants live in `Drupal\default_content_deploy\Event\DefaultContentDeployEvents`.
Each constant's value **is the event class name** (dispatch/subscribe by class), the
Symfony-events convention.

| Constant | Class | Fired | Use it to |
| --- | --- | --- | --- |
| `PRE_SERIALIZE` | `PreSerializeEvent` | Export, before an entity is serialized. | Alter, replace (`setEntity()`), or remove (`unsetEntity()` / `setEntity(NULL)`) the entity from the export. |
| `POST_SERIALIZE` | `PostSerializeEvent` | Export, after serialization. | Rewrite the serialized JSON (`getContent()`/`setContent()`, or `getContentDecoded()`/`setContentDecoded()`); return `''` to skip writing the file. |
| `PRE_SAVE` | `PreSaveEntityEvent` | Import, before `$entity->save()`. | Inspect/mutate the entity before it is written. |
| `POST_SAVE` | `PostSaveEntityEvent` | Import, after save. | React to the saved entity. |
| `IMPORT_BATCH_FINISHED` | `ImportBatchFinishedEvent` | After the whole import batch. | Post-import cleanup; read `getSuccess()` / `getResults()`. |

Event object accessors:

- `PreSerializeEvent(ContentEntityInterface $entity, string $mode, string $folder)` — `getEntity(): ?ContentEntityInterface`, `setEntity(?ContentEntityInterface)`, `unsetEntity()`, `getMode()`, `getFolder()`.
- `PostSerializeEvent(ContentEntityInterface $entity, string $content, string $mode, string $folder)` — `getEntity()`, `getContent()`, `setContent(string)`, `getContentDecoded(): array`, `setContentDecoded(array)`, `getMode()`, `getFolder()`.
- `PreSaveEntityEvent` / `PostSaveEntityEvent` extend `SaveEntityEvent(ContentEntityInterface $entity, array $data, bool $correction, array $context)` — `getEntity()`, `getData()`, `isCorrection()`, `getContext()`.
- `ImportBatchFinishedEvent(bool $success, array $results)` — `getSuccess()`, `getResults()`.

`PreSerializeEvent`, `PostSerializeEvent`, and `ImportBatchFinishedEvent` extend
`IndexAwareEvent` (implements `IndexAwareEventInterface`: `getIndexId()` /
`setIndexId()`) — the `search_api_default_content_deploy` submodule tags each export
with the Search API index that triggered it.

## Subscriber skeleton

```php
use Drupal\default_content_deploy\Event\DefaultContentDeployEvents;
use Drupal\default_content_deploy\Event\PreSerializeEvent;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;

class MySubscriber implements EventSubscriberInterface {
  public static function getSubscribedEvents(): array {
    return [DefaultContentDeployEvents::PRE_SERIALIZE => 'onPreSerialize'];
  }
  public function onPreSerialize(PreSerializeEvent $event): void {
    if ($event->getEntity()->getEntityTypeId() === 'user') {
      $event->unsetEntity(); // exclude users from this export
    }
  }
}
```
