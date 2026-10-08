<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Event: SetIndexedValue

Class `Drupal\facets_content_type_or_other\Event\SetIndexedValue` (`src/Event/SetIndexedValue.php`),
extends `Drupal\Component\EventDispatcher\Event`.

- Event name constant: `SetIndexedValue::EVENT_NAME = 'facets_content_type_or_other_set_indexed_value'`.
- Dispatched by the Search API processor `ContentTypeOrOther::addFieldValues()` **once per field per node,
  at index time**, immediately before the computed value is written to the index.

## API

- `__construct(EntityInterface $entity, string $value)` — the node being indexed and the value the module
  computed (label override / bundle label / `'Other'`).
- `getEntity(): EntityInterface` — the node entity being indexed (public property `$entity`).
- `getValue(): string` — the current value.
- `setValue(string $value)` — override the value that will be indexed.

The processor reads `$event->getValue()` back after dispatch, so a subscriber's `setValue()` replaces the
indexed string.

## Trust source

This is an **index-time** event driven by content being indexed; the entity is the node being processed and
the value is a server-side computed string — it does not carry request/HTTP input. Subscribers should treat
the resulting string as a facet display value (returned to the escaped Facets render pipeline).

## Example subscriber

```php
class AlterIndexedValueSubscriber implements EventSubscriberInterface {
  public static function getSubscribedEvents() {
    return [SetIndexedValue::EVENT_NAME => 'onSetIndexedValue'];
  }
  public function onSetIndexedValue(SetIndexedValue $event) {
    $entity = $event->getEntity();
    $value = $event->getValue();
    if ($entity->bundle() == 'page') {
      $value = 'Page';
    }
    $event->setValue($value);
  }
}
```

Register the subscriber as a tagged `event_subscriber` service. Re-index content for changes to apply. Note:
if a subscriber sets a value not present in `first_order_config`, the sort processor
([../plugins/facets-sort-processor.md](../plugins/facets-sort-processor.md)) cannot position it among the
configured order.
