# Events

Event name constants live in `Drupal\external_entities\Event\ExternalEntitiesEvents`. Dispatched via
the core `event_dispatcher`; subscribe with a normal `EventSubscriberInterface` service. Each event
class exposes getters/setters to read and replace the payload.

| Constant | Event name | Fired / lets you alter |
|---|---|---|
| `TRANSFORM_RAW_DATA` | `external_entity.transform_raw_data` | Raw source data before it is mapped to an entity |
| `MAP_RAW_DATA` | `external_entity.map_raw_data` | The external entity just after mapping |
| `EXTRACT_RAW_DATA` | `external_entity.extract_raw_data` | Raw data extracted from an entity (before save to source) |
| `GET_MAPPABLE_FIELDS` | `external_entity.get_mappable_fields` | The list of mappable Drupal fields |
| `GET_EDITABLE_FIELDS` | `external_entity.get_editable_fields` | The list of editable fields |
| `GET_REQUIRED_FIELDS` | `external_entity.get_required_fields` | The required fields (defaults `id`, `title`) |
| `GET_SAVABLE_FIELDS` | `external_entity.get_savable_fields` | The savable fields and their order |
| `TRANSLITERATE_DRUPAL_FILTERS` | `external_entity.transliterate_drupal_filters` | Filters after a storage client transliterates Drupal→source |
| `TRANSLITERATE_DRUPAL_SORTS` | `external_entity.transliterate_drupal_sorts` | Sorts after transliteration |
| `TEST_DRUPAL_FILTER` | `external_entity.test_drupal_filter` | Add support for Drupal-side filter operators |
| `EXTERNAL_ENTITY_BASE_DEFINITION` | `external_entity.base_definition` | The base entity-type definition when a type is built |
| `EXTERNAL_ENTITY_TOKEN` | `external_entity.token` | Token replacement content |

Example subscriber:

```php
use Drupal\external_entities\Event\ExternalEntitiesEvents;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;

class MySubscriber implements EventSubscriberInterface {
  public static function getSubscribedEvents(): array {
    return [ExternalEntitiesEvents::MAP_RAW_DATA => 'onMap'];
  }
  public function onMap($event) { /* $event->getEntity(); ... */ }
}
```

The `xntt_views` submodule ships its own `ExternalEntitiesSubscriber` using these events to integrate
external entities with Views queries.
