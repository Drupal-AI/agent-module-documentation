<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# PreCacheEvent — rewrite JSON before caching

The query dispatches one event so other modules can transform the fetched JSON payload
**before** it is stored in the cache and parsed into rows.

## Event

- Class: `Drupal\views_json_source\Event\PreCacheEvent`
- Name constant: `PreCacheEvent::VIEWS_JSON_SOURCE_PRE_CACHE`
  (`'views_json_source.pre_cache'`)
- Dispatched in `ViewsJsonQuery::fetchFile()` only on a **cache miss for a remote URL**
  (local files and cache hits do not fire it).
- Carries: the `ViewExecutable` (`getView()`) and the raw response string
  (`getViewData()` / `setViewData($string)`).

The value returned by `getViewData()` after the event is what gets cached (for `cache_ttl`
seconds) and subsequently JSON-decoded.

## Subscribe

```php
namespace Drupal\my_module\EventSubscriber;

use Drupal\views_json_source\Event\PreCacheEvent;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;

class JsonRewriter implements EventSubscriberInterface {

  public static function getSubscribedEvents(): array {
    return [PreCacheEvent::VIEWS_JSON_SOURCE_PRE_CACHE => 'onPreCache'];
  }

  public function onPreCache(PreCacheEvent $event): void {
    // Optionally scope to a specific view:
    // if ($event->getView()->id() !== 'my_json_view') { return; }
    $raw = $event->getViewData();
    $data = json_decode($raw, TRUE);
    // …mutate $data (unwrap an envelope, drop fields, normalise)…
    $event->setViewData(json_encode($data));
  }
}
```

Register it as a `event_subscriber`-tagged service in `my_module.services.yml`.

Use cases: unwrap an API envelope so `row_apath` is simpler, strip large/unused fields before
caching, or normalise inconsistent upstream shapes.
