# Query access API

Extends permission enforcement from single-entity checks to **queries, Views, and list
builders**, so users never see rows they lack access to. Enable by declaring the handler in
your entity type annotation:

```php
handlers = {
  "query_access" = "Drupal\entity\QueryAccess\QueryAccessHandler",
}
```

- `QueryAccessHandler` builds conditions from the generic permissions (view/update/delete,
  own/any, per bundle) and applies them via `EntityQueryAlter` (entity queries) and
  `ViewsQueryAlter` (Views).
- `UncacheableQueryAccessHandler` — pairs with the uncacheable permission provider.
- `EventOnlyQueryAccessHandler` — applies **only** event-supplied conditions (no built-in
  permission conditions), for entity types with custom access models.

## Alter conditions with an event
Every access build dispatches a `QueryAccessEvent` (event name = `entity.query_access.<entity_type_id>`):

```php
class MyQueryAccessSubscriber implements EventSubscriberInterface {
  public static function getSubscribedEvents() {
    return ['entity.query_access.my_entity' => 'onQueryAccess'];
  }
  public function onQueryAccess(QueryAccessEvent $event) {
    // $event->getOperation(), ->getAccount(), ->getEntityTypeId()
    $conditions = $event->getConditions(); // ConditionGroup
    $conditions->addCondition('field_owner', $event->getAccount()->id());
    // ->addCondition(new Condition(...)) or nested ConditionGroup; ->alwaysFalse();
  }
}
```

`ConditionGroup` (AND/OR) holds `Condition` objects (field, value, operator) and nested
groups; set `->alwaysFalse()` to deny all.
