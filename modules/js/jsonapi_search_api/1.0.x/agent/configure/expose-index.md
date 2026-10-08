<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Exposing an index and extending the response meta

## Exposing an index

There is nothing to configure in this module — it exposes **every enabled Search API index**
automatically. To make an index available at `/jsonapi/index/<id>`:

1. The index must have a **server** and be **enabled** (`status: true`). Search API forces an
   index without a server to be disabled, and disabled indexes are not exposed.
2. Rebuild routes (a cache rebuild, or `\Drupal::service('router.builder')->rebuild()`), so
   `Routes::routes()` re-runs and registers `jsonapi_search_api.index_<id>`.

Programmatic check that an index is exposed (without a full router rebuild) — instantiate the
route generator and inspect its collection:

```php
$routes = \Drupal::service('class_resolver')
  ->getInstanceFromDefinition(\Drupal\jsonapi_search_api\Routing\Routes::class)
  ->routes();
$exposed = $routes->get('jsonapi_search_api.index_' . $index_id) !== NULL;
```

Enable an index programmatically:
```php
$index = \Drupal\search_api\Entity\Index::load('my_index');
$index->setServer(\Drupal\search_api\Entity\Server::load('my_server'))->setStatus(TRUE)->save();
```

The response respects entity/query access; the route requirement itself is `_access: TRUE`.

## Adding to the response `meta`

Subscribe to `jsonapi_search_api.add_search_meta` (constant
`\Drupal\jsonapi_search_api\Event\Events::ADD_SEARCH_META`). The event
`\Drupal\jsonapi_search_api\Event\AddSearchMetaEvent` exposes `getQuery()`, `getResults()`,
`getMeta()` and `setMeta($key, $value)`:

```php
class MySearchMetaSubscriber implements EventSubscriberInterface {
  public static function getSubscribedEvents(): array {
    return [\Drupal\jsonapi_search_api\Event\Events::ADD_SEARCH_META => 'addMeta'];
  }
  public function addMeta(\Drupal\jsonapi_search_api\Event\AddSearchMetaEvent $event): void {
    $event->setMeta('generated_at', time());
  }
}
```

This is exactly how `jsonapi_search_api_facets` adds `meta.facets`. There are no other hooks,
services, or config surfaces to override.
