<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `permissions_by_entity.access_checker` and the enforcement points

## Services

| Service id | Class | Notes |
|---|---|---|
| `permissions_by_entity.access_checker` | `Service\AccessChecker` | Extends `Drupal\permissions_by_term\Service\AccessCheck`, implements `AccessCheckerInterface`. |
| `permissions_by_entity.checked_entity_cache` | `Service\CheckedEntityCache` | Per-request list of already-visited entities; breaks circular references. |
| `permissions_by_entity.access_result_cache` | `Cache\AccessResultCache` | Backed by `cache.permissions_by_term`. |
| `permissions_by_entity.kernel_event_subscriber` | `EventSubscriber\PermissionsByEntityKernelEventSubscriber` | `KernelEvents::REQUEST` priority **28** (before `DynamicPageCacheSubscriber`). |
| `permissions_by_entity.remove_entity_from_view_event_subscriber` | `EventSubscriber\RemoveEntityFromViewEventSubscriber` | Strips denied referenced entities from a field. |

## `AccessCheckerInterface`

```php
$c = \Drupal::service('permissions_by_entity.access_checker');

$c->isAccessControlled(FieldableEntityInterface $entity, bool $clearCache = TRUE): bool;
$c->isAccessAllowed(FieldableEntityInterface $entity, $uid = FALSE): bool;
// plus everything inherited from permissions_by_term's AccessCheck,
// e.g. isAccessAllowedByDatabase($tid, $uid, $langcode), isAnyPermissionSetForTerm($tid, $langcode)
```

### `isAccessControlled()`

- `FALSE` immediately for `node` (the parent module owns nodes).
- Iterates `$entity->getFields()`; for an `entity_reference` field with
  `target_type === 'taxonomy_term'` it requires
  `count(array_intersect($field_handler_target_bundles, $settings['target_bundles'])) > 0`
  **and** `target_bundles` to be non-empty — then returns `TRUE` if `permission_mode` is on, else
  `TRUE` if any referenced term has a permission set.
- Recurses into referenced fieldable entities (`$field->entity`), guarded by `CheckedEntityCache`.

### `isAccessAllowed()`

- Starts `TRUE` when both `permission_mode` and `require_all_terms_granted` are off, else `FALSE`.
- For each taxonomy reference item: `isAccessAllowedByDatabase($tid, $uid, $entity->language()->getId())`.
  With `require_all_terms_granted` it returns on the first denial; without it, it returns on the
  first grant.
- Recurses into referenced fieldable entities and, on denial, dispatches
  `PermissionsByEntityEvents::ENTITY_FIELD_VALUE_ACCESS_DENIED_EVENT`.

## Enforcement

**`hook_entity_access()`** (`permissions_by_entity.module`) — for `view` on a saved, fieldable,
**non-node** entity: if `isAccessControlled()`, return `AccessResult::allowed()` /
`AccessResult::forbidden('Access revoked by permissions_by_entity module.')` from
`isAccessAllowed()`, caching the result per `uid`+entity. Otherwise `AccessResult::neutral()`.

**Kernel REQUEST subscriber** (priority 28) — takes the routed entity from the request attributes
`node` or `_entity`, skips it if already in `CheckedEntityCache`, and throws
`AccessDeniedHttpException('You are not allowed to view content of this entity type.')` when it is
controlled and not allowed. The high priority is deliberate: it must run **before** the dynamic
page cache would serve/store a response.

**`hook_entity_insert()` / `hook_entity_update()`** invalidate the cache tag
`permissions_by_entity:access_result_cache:<entity_type_id>:<entity_id>` for controlled entities.

## The event

```php
use Drupal\permissions_by_entity\Event\PermissionsByEntityEvents;   // ENTITY_FIELD_VALUE_ACCESS_DENIED_EVENT
use Drupal\permissions_by_entity\Event\EntityFieldValueAccessDeniedEvent;
// getField(): FieldItemListInterface, getEntity(): FieldableEntityInterface,
// getUid(): int, getIndex()/setIndex(): int
```

Event name string: `permissions_by_entity.entity_field_value_access_denied_event`.
The bundled `RemoveEntityFromViewEventSubscriber` reacts by unsetting the denied delta from the
field's value list (and decrementing the event index), so the inaccessible referenced entity
simply disappears from the render.

Subscribe to it yourself to log, replace the value with a placeholder, or redirect:

```php
public static function getSubscribedEvents(): array {
  return [PermissionsByEntityEvents::ENTITY_FIELD_VALUE_ACCESS_DENIED_EVENT => ['onDenied', -100]];
}
```

## Debugging

```bash
drush php:eval '
  $e = \Drupal::entityTypeManager()->getStorage("media")->load(1);
  $c = \Drupal::service("permissions_by_entity.access_checker");
  var_dump($c->isAccessControlled($e), $c->isAccessAllowed($e, 3));'
drush config:get permissions_by_term.settings target_bundles   # must be non-empty!
drush sql:query "SELECT * FROM permissions_by_term_role;"
```
