# React to imports via events

Feeds has **no `feeds.api.php` hooks** — it extends through Symfony events. Subscribe with a
normal `EventSubscriberInterface` service tagged `event_subscriber`. Constants and payloads live
in `src/Event/` (`Drupal\feeds\Event\FeedsEvents`).

| Constant | Name | Event class | Fires |
|---|---|---|---|
| `FeedsEvents::INIT_IMPORT` | `feeds.init_import` | `InitEvent` | import begins |
| `FeedsEvents::FETCH` | `feeds.fetch` | `FetchEvent` | after fetch (raw result available) |
| `FeedsEvents::PARSE` | `feeds.parse` | `ParseEvent` | after parse (item list available) |
| `FeedsEvents::PROCESS` | `feeds.process` | `ProcessEvent` | per parsed item, before processing |
| `FeedsEvents::PROCESS_ENTITY_PREVALIDATE` | `feeds.process_entity_prevalidate` | `EntityEvent` | before entity validation |
| `FeedsEvents::PROCESS_ENTITY_PRESAVE` | `feeds.process_entity_presave` | `EntityEvent` | before entity save |
| `FeedsEvents::PROCESS_ENTITY_POSTSAVE` | `feeds.process_entity_postsave` | `EntityEvent` | after entity save |
| `FeedsEvents::CLEAN` | `feeds.clean` | `CleanEvent` | item no longer in source |
| `FeedsEvents::CLEAR` / `INIT_CLEAR` | `feeds.clear` | `ClearEvent` | items deleted |
| `FeedsEvents::EXPIRE` / `INIT_EXPIRE` | `feeds.expire` | `ExpireEvent` | old items expired |
| `FeedsEvents::REPORT` | `feeds.report` | `ReportEvent` | import reporting (used by Feeds Log) |
| `FeedsEvents::IMPORT_FINISHED` | `feeds.import_finished` | `ImportFinishedEvent` | import completes |
| `FeedsEvents::FEEDS_DELETE` | `feeds.delete_multiple` | `DeleteFeedsEvent` | feeds deleted |

`FeedsEvents::BEFORE` (10000) / `AFTER` (-10000) are priority constants for ordering.

```php
class MyFeedsSubscriber implements EventSubscriberInterface {
  public static function getSubscribedEvents() {
    return [FeedsEvents::PROCESS_ENTITY_PRESAVE => 'onPresave'];
  }
  public function onPresave(EntityEvent $event) {
    $entity = $event->getEntity();      // modify the entity before it is saved
    $item = $event->getItem();          // the parsed source item
    $feed = $event->getFeed();
  }
}
```

Standard entity/field hooks and the processor's own logic also run, so simple field tweaks can
go in `hook_entity_presave()` instead of subscribing here.
