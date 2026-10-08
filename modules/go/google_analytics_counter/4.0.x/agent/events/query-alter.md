# Event: alter the GA4 query

The module dispatches one event right before it runs each Google Analytics Data API query, so other
modules can change the request parameters or cache options.

| Constant | Value |
|---|---|
| `GoogleAnalyticsCounterEvents::QUERY_ALTER` | `google_analytics_counter.query_alter` |

- Event class: `Drupal\google_analytics_counter\Event\GoogleAnalyticsCounterQueryAlterEvent`
- Dispatched in `GoogleAnalyticsCounterAppManager::buildQuery()`, after the parameters are assembled and
  **before** `gacGetFeed()` calls `BetaAnalyticsDataClient::runReport()`. The manager reads
  `getParameters()` and `getCacheOptions()` back from the event after dispatch.

## Event accessors

| Getter / Setter | Holds |
|---|---|
| `getParameters()` / `setParameters(array)` | The GA4 request array (`property`, `dateRanges`, `dimensions`, `metrics`, `offset`, `limit`). |
| `getCacheOptions()` / `setCacheOptions(array)` | `cid`, `expire`, `refresh` for result caching. |
| `getStep()` / `setStep($int)` | Chunk index (from 0). |
| `getLimit()` / `setLimit($int)` | Result limit. |
| `getOffset()` / `setOffset($int)` | Result offset. |
| `getCurrentTimestamp()` / `setCurrentTimestamp($int)` | Timestamp used for dynamic date ranges. |

## Subscriber example

```php
namespace Drupal\my_module\EventSubscriber;

use Drupal\google_analytics_counter\Event\GoogleAnalyticsCounterEvents;
use Drupal\google_analytics_counter\Event\GoogleAnalyticsCounterQueryAlterEvent;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;

class MyGacSubscriber implements EventSubscriberInterface {

  public static function getSubscribedEvents(): array {
    return [GoogleAnalyticsCounterEvents::QUERY_ALTER => 'onQueryAlter'];
  }

  public function onQueryAlter(GoogleAnalyticsCounterQueryAlterEvent $event): void {
    $params = $event->getParameters();
    // e.g. add a dimensionFilter, change the property, tweak limits…
    $event->setParameters($params);
  }
}
```

Register it as a `event_subscriber`-tagged service.
