# Extend acquia_contenthub via events

There is **no hook API / `*.api.php`**. Integration happens by registering an
`EventSubscriber` service (tag `event_subscriber`) on constants in
`\Drupal\acquia_contenthub\AcquiaContentHubEvents`. Event classes live in `src/Event/`.
The base module itself is built almost entirely as subscribers (see `acquia_contenthub.services.yml`).

## Most useful events
| Constant | Event class | Use it to… |
|---|---|---|
| `GET_SETTINGS` | `AcquiaContentHubSettingsEvent` | Supply connection `Settings` (credential source; priority matters — see configure/settings.md) |
| `CREATE_CDF_OBJECT` | `CreateCdfEntityEvent` | Add/replace CDF documents for an entity being exported |
| `SERIALIZE_CONTENT_ENTITY_FIELD` / `UNSERIALIZE_CONTENT_ENTITY_FIELD` | `SerializeCdfEntityFieldEvent` / `UnserializeCdfEntityFieldEvent` | Customize how a field is written to / read from CDF |
| `EXCLUDE_CONTENT_ENTITY_FIELD` | `ExcludeEntityFieldEvent` | Drop a field from export entirely |
| `PARSE_CDF` | `ParseCdfEntityEvent` | Build a local entity from an incoming CDF document |
| `ENTITY_DATA_TAMPER` | `EntityDataTamperEvent` | Mutate/normalize imported data before it is saved |
| `PRE_ENTITY_SAVE` | `PreEntitySaveEvent` | Adjust an entity right before save on the subscriber (e.g. pathauto/redirect handling) |
| `ENTITY_IMPORT_NEW` / `ENTITY_IMPORT_UPDATE` | `EntityImportEvent` | React to new vs updated imports |
| `IMPORT_FAILURE` | `FailedImportEvent` | Handle/recover failed imports (e.g. create stubs) |
| `PRUNE_CDF` / `PRUNE_PUBLISH_CDF_ENTITIES` | `PruneCdfEntitiesEvent` / `PrunePublishCdfEntitiesEvent` | Remove entities from a CDF payload before send/import |
| `HANDLE_WEBHOOK` | `HandleWebhookEvent` | Respond to an incoming (already HMAC-validated) webhook and set the HTTP response |
| `ACH_UNREGISTER` | `AcquiaContentHubUnregisterEvent` | Clean up when the site disconnects (orphaned filters/entities) |
| `BUILD_CLIENT_CDF` / `CLIENT_METADATA` | `BuildClientCdfEvent` / `ClientMetaDataEvent` | Add attributes to this client's CDF/metadata |
| `POPULATE_CDF_ATTRIBUTES` | `CdfAttributesEvent` | Add attributes (tags, channels, languages, hash, url…) to a CDF |
| `CLEANUP_STUBS` | `CleanUpStubsEvent` | Post-import stub cleanup |

## Skeleton
```php
// mymodule.services.yml
//   mymodule.tamper:
//     class: Drupal\mymodule\EventSubscriber\MyTamper
//     tags: [{ name: event_subscriber }]
use Drupal\acquia_contenthub\AcquiaContentHubEvents;
use Drupal\acquia_contenthub\Event\EntityDataTamperEvent;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;

class MyTamper implements EventSubscriberInterface {
  public static function getSubscribedEvents(): array {
    return [AcquiaContentHubEvents::ENTITY_DATA_TAMPER => 'onTamper'];
  }
  public function onTamper(EntityDataTamperEvent $event): void {
    // Inspect/modify $event->getCdf() / entities before save.
  }
}
```
Look at the shipped subscribers in `src/EventSubscriber/**` for concrete signatures per event.
