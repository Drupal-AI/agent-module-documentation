# Query access API

Extends permission enforcement from single-entity checks to **queries, Views, list
builders, and JSON:API collections**, so users never see rows they lack access to. Enable by
declaring the handler in your entity type annotation:

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
  permission conditions), for entity types with custom access models. The module auto-assigns
  this handler (`hook_entity_type_alter`) to every SQL-stored content entity type that lacks
  one, so the `QueryAccessEvent` fires everywhere.

Behavior of the built handlers (`QueryAccessHandlerBase::buildConditions`):
- Holders of the admin permission get an empty (unrestricted) condition group.
- Owner-aware types split into "any" (no owner condition) vs "own" (`owner`/`uid` = current
  user); non-owner types match on bundle permissions only.
- For a `view` operation on a publishable type, existing conditions are restricted to
  published rows, OR'd with an "own + unpublished" group when the user holds
  `view own unpublished $entity_type`.
- If the user has access to nothing, the group is set `alwaysFalse()` so the query returns
  no rows (`EntityQueryAlter`/`ViewsQueryAlter` emit `1 = 0`).
- Throws `\RuntimeException` if an owner-aware type lacks an `owner`/`uid` key, or a
  publishable type lacks a `published` key.

## JSON:API collections
`hook_jsonapi_entity_filter_access` maps the same `view` query-access conditions onto JSON:API
filter access: it grants `JSONAPI_FILTER_AMONG_PUBLISHED` / `JSONAPI_FILTER_AMONG_OWN` only
when the built conditions reduce to a simple published-only and/or owner-only match. Any
`alwaysFalse` result, nested condition group, or unsupported condition maps to **no** filter
access (the conservative default), so a JSON:API client is never granted broader collection
access than the query-access conditions describe.

## Alter conditions with an event
Every access build dispatches a `QueryAccessEvent` twice — once under the generic name
`entity.query_access` and once under `entity.query_access.<entity_type_id>`:

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
