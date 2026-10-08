# Views Remote Data — the events

Namespace: `Drupal\views_remote_data\Events`. Dispatched by the `views_remote_data_query`
query plugin during `execute()`. Subscribe with a normal `EventSubscriberInterface`.

## `RemoteDataQueryEvent` (return your rows here)

Dispatched once per View execution. Getters:

| Getter | Returns | Notes |
|---|---|---|
| `getView()` | `ViewExecutable` | the running view. |
| `getConditions()` | `array` | filters + contextual filters. Each group has `conditions[]` of `['field' => explode('.', $field), 'value' => ..., 'operator' => ...]`. `field` is the property path split on `.`. |
| `getSorts()` | `array` | each `['field' => explode('.', $field), 'order' => 'ASC'|'DESC']`. |
| `getLimit()` | `int` | pager page size. |
| `getOffset()` | `int` | pager offset. |
| `addResult(ResultRow $row)` | void | **push each remote record** as a `ResultRow`. |
| `getResults()` | `ResultRow[]` | accumulated rows. |

The event also implements `RefinableCacheableDependencyInterface`, so you bubble cache
metadata straight onto it: `$event->addCacheTags([...])`, `addCacheContexts([...])`,
`addCacheableDependency($obj)`. The query plugin merges these into the View's cache metadata
(and always adds the tag `views_remote_data`).

### Subscriber skeleton

```php
use Drupal\views\ResultRow;
use Drupal\views_remote_data\Events\RemoteDataQueryEvent;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;

final class MySubscriber implements EventSubscriberInterface {

  public static function getSubscribedEvents(): array {
    return [
      RemoteDataQueryEvent::class => 'onQuery',
      RemoteDataLoadEntitiesEvent::class => 'onLoadEntities',
    ];
  }

  public function onQuery(RemoteDataQueryEvent $event): void {
    // Only handle views built on YOUR base table:
    $bases = array_keys($event->getView()->getBaseTables());
    if (!in_array('my_remote_source', $bases, TRUE)) {
      return;
    }
    // Translate $event->getConditions()/getSorts()/getLimit()/getOffset() into an API call…
    foreach ($this->api->fetch(/* … */) as $record) {
      // $record is any array/object; property_path handlers read into it.
      $event->addResult(new ResultRow($record));
    }
    $event->addCacheTags(['my_remote_source']);
  }
}
```

A `ResultRow` can wrap an associative array; the `views_remote_data_property` handlers read
nested keys from it by `property_path` (via `NestedArray::getValue()`-style access on the
`field` path array).

## `RemoteDataLoadEntitiesEvent` (attach entities, optional)

Dispatched after rows are set, to let you hydrate `$row->_entity`:

| Getter | Returns |
|---|---|
| `getView()` | `ViewExecutable` |
| `getResults()` | `ResultRow[]` (mutate in place) |

```php
public function onLoadEntities(RemoteDataLoadEntitiesEvent $event): void {
  foreach ($event->getResults() as $key => $row) {
    $row->_entity = MyEntity::create([...]);   // enables rendered_entity + entity fields
  }
}
```

When rows carry `_entity`, the query plugin's `getCacheTags()` also merges each entity's cache
tags, so entity edits invalidate the View.

## Gotchas

- Both events fire for **every** remote-data View; always guard on
  `$event->getView()->getBaseTables()` (or `id()`) so you only answer your own.
- `getConditions()` `field` and `getSorts()` `field` are **arrays** (the property path already
  `explode()`-ed on `.`), not strings.
- Paging is your responsibility: honour `getLimit()`/`getOffset()` and set total items via the
  pager (the plugin calls `$pager->getTotalItems()`), or return the full set and let Views page
  in PHP.
