# PreCacheEvent — alter remote CSV content before it is cached

When a **remote** CSV is fetched, `Connection::fetchContent()` dispatches a `PreCacheEvent` just
before writing the body to cache, letting other modules transform the raw CSV text (e.g. rewrite
columns, strip rows, fix encoding) so the transformed version is what gets cached and parsed.

- Class: `Drupal\views_csv_source\Event\PreCacheEvent` (`src/Event/PreCacheEvent.php`).
- Event name constant: `PreCacheEvent::VIEWS_CSV_SOURCE_PRE_CACHE` = `'views_csv_source.pre_cache'`.
- Dispatched only on the remote path, and only when caching is enabled (`cache_ttl > 0`). Local
  files and `cache_ttl: 0` never dispatch it.

Methods:

| Method | Purpose |
|---|---|
| `getCacheId(): string` | The per-request cache id passed with the event. |
| `getData(): string` | The current CSV body (raw HTTP response text). |
| `setData(string $data): void` | Replace the CSV body; the returned value is what gets cached. |

## Subscriber example

```php
use Drupal\views_csv_source\Event\PreCacheEvent;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;

class MyCsvRewriter implements EventSubscriberInterface {

  public static function getSubscribedEvents(): array {
    return [PreCacheEvent::VIEWS_CSV_SOURCE_PRE_CACHE => 'onPreCache'];
  }

  public function onPreCache(PreCacheEvent $event): void {
    $csv = $event->getData();
    // ... transform $csv ...
    $event->setData($csv);
  }

}
```

Register the subscriber as a tagged `event_subscriber` service in your module's `*.services.yml`.
