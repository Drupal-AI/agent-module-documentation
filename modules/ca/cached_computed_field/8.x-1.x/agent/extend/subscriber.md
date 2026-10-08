<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Refreshing cached computed fields

The module stores the value but does **not** know how to compute it — you supply that in an event subscriber.

## 1. Add a field
Add a field of type e.g. `cached_computed_integer` (or string/text/decimal/float/boolean) to your entity. Each item stores `{value, expires}`.

## 2. Subscribe to the refresh event
Cron drives `CachedComputedFieldManager`: it finds items whose `expires` has passed, queues them, and dispatches `RefreshExpiredFieldsEvent` for each `ExpiredItem`.

```php
use Drupal\cached_computed_field\EventSubscriber\RefreshExpiredFieldsSubscriberBase;
use Drupal\cached_computed_field\Event\RefreshExpiredFieldsEventInterface;

class MyRefresher extends RefreshExpiredFieldsSubscriberBase {
  public static function getSubscribedEvents(): array {
    return [RefreshExpiredFieldsEventInterface::EVENT_NAME => 'refresh'];
  }
  public function refresh(RefreshExpiredFieldsEventInterface $event): void {
    foreach ($event->getExpiredItems()->getItemsForFieldType('cached_computed_integer') as $item) {
      if (!$this->fieldNeedsRefresh($item)) { continue; }
      $value = my_expensive_compute($this->getEntity($item));
      $this->updateFieldValue($item, $value);   // writes value + new expires
    }
  }
}
```

Register it as a tagged `event_subscriber` service. Base-class helpers: `getEntity()`, `getFieldDefinition()`, `getExpiredFieldValue()`, `fieldNeedsRefresh()`, `updateFieldValue()`. Refresh cadence = cron frequency + the field's max-age; without a subscriber the field simply keeps its last value.
