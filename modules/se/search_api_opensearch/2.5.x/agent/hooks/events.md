<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Events & the index-param hook

Customisation is mostly done with Symfony events (subscribe via an event subscriber service),
plus one procedural hook. All event classes are in `src/Event/`.

## Dispatched events

| Event class | Use it to |
|---|---|
| `FieldMappingEvent` | change how a Search API field maps to an OpenSearch field mapping |
| `IndexParamsEvent` | alter the params sent when indexing documents |
| `QueryParamsEvent` | alter the OpenSearch query DSL before a search runs |
| `DeleteParamsEvent` | alter params for delete operations |
| `BaseParamsEvent` | base for param events (shared index/base params) |
| `AlterSettingsEvent` | alter index settings before they are applied |
| `BeforeIndexCreateEvent` | modify config just before an index is created |
| `IndexCreatedEvent` | react after an index has been created |
| `ClientOptionsEvent` | modify OpenSearch client options (timeouts, TLS, handlers) |
| `SupportsDataTypeEvent` | declare that a given Search API data type is supported |

Example subscriber (declaring geo support is exactly what the location submodule does):

```php
use Drupal\search_api_opensearch\Event\SupportsDataTypeEvent;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;

class MySubscriber implements EventSubscriberInterface {
  public static function getSubscribedEvents(): array {
    return [SupportsDataTypeEvent::class => ['onSupportsDataType']];
  }
  public function onSupportsDataType(SupportsDataTypeEvent $event): void {
    if ($event->getType() === 'my_type') { $event->setIsSupported(TRUE); }
  }
}
```

Register the class as a service tagged `event_subscriber` (the module uses `autoconfigure`).

## `hook_index_param_value_alter()`

Declared in `search_api_opensearch.api.php` — lets you post-process the generated field values
in the IndexParamBuilder before they are sent:

```php
function hook_index_param_value_alter(\Drupal\search_api\Item\FieldInterface $field, array &$original_values, array $context): void {
  if ($context['field_type'] !== 'my_type') { return; }
  // mutate $original_values by reference …
}
```

## Quieting the client logger

The OpenSearch PHP client is noisy. Override its channel in a `*.services.yml`:

```yaml
services:
  logger.channel.search_api_opensearch_client:
    class: Psr\Log\NullLogger
```
