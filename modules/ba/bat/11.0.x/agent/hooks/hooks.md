# BAT base hooks

Documented in `bat.api.php`.

## `hook_bat_entity_access(EntityInterface $entity, $operation, AccountInterface $account)`

Invoked by `bat_entity_access()` for **non-view** operations (create/update/delete) on the BAT
entity types, *before* role-permission checks. Semantics:

- Return `FALSE` to **blanket-deny** the operation for this user on this entity (any `FALSE` wins).
- If no implementation returns `FALSE` but at least one returns `TRUE`, the operation is **allowed
  even without the role-based permission**.
- If none return `FALSE` and none return `TRUE`, normal BAT permission checking applies.

```php
function mymodule_bat_entity_access(\Drupal\Core\Entity\EntityInterface $entity, $operation, \Drupal\Core\Session\AccountInterface $account) {
  // Example: forbid deleting a unit that has bookings.
  if ($entity->getEntityTypeId() === 'bat_unit' && $operation === 'delete' && mymodule_has_bookings($entity)) {
    return FALSE;
  }
}
```

Because a single `TRUE` can grant an operation without the normal permission, implement this hook
carefully — prefer returning nothing (fall through) or `FALSE` unless you deliberately want to widen
access.

## Related query-alter hooks

`bat_entity_access_query_alter()` fires `hook_bat_entity_access_<op>_condition_<type>_alter()` and
`hook_bat_entity_access_<op>_condition_alter()` so modules can add DB conditions to the listing
access filter (see [../api/framework.md](../api/framework.md)). `bat_event` additionally invites
`hook_bat_event_target_entity_types()`, `hook_bat_event_constraints_info[/_alter]()`, and
`hook_bat_facets_search_results_alter()` — documented under `bat_event`.
