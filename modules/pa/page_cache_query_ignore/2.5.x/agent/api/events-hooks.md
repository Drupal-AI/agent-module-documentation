# Extend — alter hook + events

The configured `query_parameters` list is the static baseline. Three runtime extension points
let other modules adjust behavior per-site or per-request. All are consumed inside
`PageCacheIgnore` (the `http_middleware.page_cache` service).

## Alter hook

```php
/**
 * Implements hook_page_cache_query_ignore_parameters_alter().
 * Lives in MODULE.page_cache_query_ignore.inc (hook_info group
 * "page_cache_query_ignore"), NOT in MODULE.module.
 */
function mymodule_page_cache_query_ignore_parameters_alter(array &$parameters) {
  $parameters[] = 'gclid';           // add
  $parameters = array_diff($parameters, ['page']); // remove
}
```

`$parameters` is the flat list of names; it is altered *before* the exclude/include logic runs.
The module calls `moduleHandler->loadAll()` first, so implementations in the grouped
`.page_cache_query_ignore.inc` file are found.

## Events

`\Drupal\page_cache_query_ignore\Event\PageCacheQueryIgnoreEvents` (dispatched as Symfony
`GenericEvent`s):

| Constant | Value | When | Argument to mutate |
|---|---|---|---|
| `PARAMETERS` | `page_cache_query_ignore.parameters` | after the alter hook, while building the name list | `parameters` (string[]) |
| `QUERY` | `page_cache_query_ignore.query` | after the query has been exclude/include-filtered, before the key is built | `query` (parsed query array); also carries read-only `parts` (parsed URL) |

```php
use Symfony\Component\EventDispatcher\GenericEvent;
use Drupal\page_cache_query_ignore\Event\PageCacheQueryIgnoreEvents;

class MySubscriber implements \Symfony\Component\EventDispatcher\EventSubscriberInterface {
  public static function getSubscribedEvents(): array {
    return [
      PageCacheQueryIgnoreEvents::PARAMETERS => 'onParameters',
      PageCacheQueryIgnoreEvents::QUERY => 'onQuery',
    ];
  }
  public function onParameters(GenericEvent $event): void {
    $params = (array) $event->getArgument('parameters');
    $params[] = 'utm_id';
    $event->setArgument('parameters', $params);
  }
  public function onQuery(GenericEvent $event): void {
    // Normalize values inside bracket arrays, e.g. keep only facet prefixes.
    $query = (array) $event->getArgument('query');
    // ... mutate $query ...
    $event->setArgument('query', $query);
  }
}
```

`PARAMETERS` is the dynamic equivalent of the config list (good for environment- or
context-dependent names). `QUERY` is the only hook that can reach *inside* a parameter's value
(e.g. faceted-search `?f[0]=alias:value`), because it runs on the already-parsed query array.
Note the event dispatcher is an optional constructor arg — both events only fire when it is
available (it is, on a standard site).
