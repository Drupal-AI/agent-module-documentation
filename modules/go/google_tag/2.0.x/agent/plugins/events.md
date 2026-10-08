# GoogleTagEvent plugin type

The module defines a plugin type for dataLayer/analytics events.

- **Manager**: service `plugin.manager.google_tag_event` →
  `Drupal\google_tag\GoogleTagEventManager` (extends `DefaultPluginManager`, injects `@token`).
- **Discovery**: `Plugin/GoogleTag/Event/`, annotation
  `Drupal\google_tag\Annotation\GoogleTagEvent`, interface `GoogleTagEventInterface`
  (extends `ContextAwarePluginInterface`, `ConfigurableInterface`), base class `EventBase`.
- **Collection/flush**: `EventCollector` (`google_tag.event_collector`) gathers active events
  (using `@session`) and `ResponseSubscriber` pushes them to the browser dataLayer.

Annotation fields:
```php
/**
 * @GoogleTagEvent(
 *   id = "my_event",
 *   event_name = "my_event",            // name sent to gtag/dataLayer
 *   label = @Translation("My event"),
 *   description = @Translation("…"),
 *   dependency = "commerce",            // optional module gate
 *   context_definitions = { … }         // optional context (entity, etc.)
 * )
 */
```

Implement one:
```php
namespace Drupal\my_module\Plugin\GoogleTag\Event;

use Drupal\google_tag\Plugin\GoogleTag\Event\EventBase;

/** @GoogleTagEvent(id="my_event", event_name="my_event", label=@Translation("My event")) */
final class MyEvent extends EventBase {
  public function getData(): array {
    return ['value' => $this->configuration['value'] ?? 0];
  }
}
```

- `getName()` returns `event_name`; `getData()` returns the event payload (`array_filter`ed
  configuration by default). Extend `ConfigurableEventBase` for events with a settings form.
- Bundled plugins: `LoginEvent`, `SignUpEvent`, `Search`, `GenerateLeadEvent`, `CustomEvent`,
  and Commerce events under `Event/Commerce/` (`AddToCartEvent`, `BeginCheckoutEvent`,
  `PurchaseEvent`, `RefundEvent`, `ViewItemEvent`, …), plus `WebformPurchase`. Commerce/Search
  API/Webform plugins are gated by `dependency` and fired by matching event subscribers.
- Enabled events and their config are stored on each container's `events` key.
