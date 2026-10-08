# Event: ExtendedLoggerLogEvent

`Drupal\extended_logger\Event\ExtendedLoggerLogEvent` (extends
`Drupal\Component\EventDispatcher\Event`) is dispatched by `ExtendedLogger::doLog()` **after** the
entry is built and **before** it is persisted — unless `extended_logger.settings:skip_event_dispatch`
is `true`. It is the extension point for enriching, redacting, or dropping a log entry.

Public properties (all mutable):

| Property | Type | Notes |
|---|---|---|
| `entry` | `ExtendedLoggerEntry` | The entry to be written. Replace/mutate it; the logger uses `$event->entry` after dispatch. |
| `level` | mixed | RFC log level (int). |
| `message` | mixed | The original message string. |
| `context` | array | The original log context. |

After dispatch the logger checks `entry->isEmpty()` and skips persistence if empty — so a
subscriber can suppress an entry by clearing its data.

There is no event-name constant; subscribe to the class name.

```php
use Drupal\extended_logger\Event\ExtendedLoggerLogEvent;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;

class LogEnricherSubscriber implements EventSubscriberInterface {

  public static function getSubscribedEvents(): array {
    return [ExtendedLoggerLogEvent::class => 'onLog'];
  }

  public function onLog(ExtendedLoggerLogEvent $event): void {
    // Add a field.
    $event->entry->set('tenant_id', $this->tenant->id());

    // Redact a field.
    $event->entry->delete('ip');

    // Drop the entry entirely.
    // $event->entry->setData([]);
  }

}
```

Register the subscriber as a tagged `event_subscriber` service in your module's `*.services.yml`.
Note: if you rely on subscribers, keep `skip_event_dispatch` off.
