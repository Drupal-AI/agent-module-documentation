<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field Guard — services & programmatic API

Three services, registered in `field_guard.services.yml`. All are `final` classes in
`src/`. There is no `.api.php` and no hooks for other modules to implement; you consume
these services directly.

## `field_guard.field_map` — `ProtectedFieldMap`

`Drupal\field_guard\ProtectedFieldMap` (constructed with `@config.factory`). Reads the
`field_guard.settings:protected` map and answers what is guarded. Implements
`CacheableDependencyInterface`: `getCacheTags()` returns the settings config object's tags
(`config:field_guard.settings`), `getCacheContexts()` is `[]`, max-age is permanent — add it
as a cacheable dependency on any verdict derived from the map.

- `requiredPermission(string $entityTypeId, ?string $bundle, string $fieldName, string $operation): ?string`
  — the permission guarding that operation, or NULL when unprotected. Returns NULL for a NULL
  bundle, for an operation other than `view`/`edit` (`OPERATIONS`), and for an empty-string
  permission (treated as unset, not a total denial).
- `viewExemptsOwnSubject(string $entityTypeId, ?string $bundle, string $fieldName): bool` — TRUE
  only when `view_exempt_own_subject === TRUE` for the field.
- `isProtected(string $entityTypeId, ?string $bundle, string $fieldName): bool` — TRUE when the
  field is guarded for `view` or `edit`. The intended seam for an audit consumer deciding whether
  a read is worth recording.
- `guardedFields(string $entityTypeId, ?string $bundle = NULL): array` — per bundle and field, the
  permission each operation requires (NULL when that operation is unguarded) and the
  `view_exempt_own_subject` flag. Applies the same rules as `requiredPermission()`; a field with no
  guarded operation is omitted even if it carries the own-subject flag. Used by the MCP list tool.

```php
$map = \Drupal::service('field_guard.field_map');
$permission = $map->requiredPermission('node', 'article', 'field_salary', 'view'); // string|null
$guarded = $map->guardedFields('node', 'article'); // [bundle][field] => [view, edit, view_exempt_own_subject]
```

## `field_guard.explicit_permission_checker` — `ExplicitPermissionChecker`

`Drupal\field_guard\ExplicitPermissionChecker` (constructed with `@entity_type.manager`).
New in 1.3.x: the explicit-permission rule extracted from the hook so the access hook, the MCP
tools, and other callers share one implementation.

- `hasExplicitPermission(AccountInterface $account, string $permission): bool` — loads the
  account's roles via `user_role` storage, **skips `is_admin` roles** (`RoleInterface::isAdmin()`),
  and returns TRUE only when a remaining non-admin role's own permission list holds the permission.
  This deliberately does **not** use `AccountInterface::hasPermission()`, which returns TRUE for
  every permission on an `is_admin` role or uid 1.

The procedural wrapper `_field_guard_has_explicit_permission($account, $permission)` remains for
existing callers and now delegates to this service. A post-update
(`field_guard_post_update_register_explicit_permission_checker`) is intentionally empty: running
any update rebuilds the container so the service is registered before the access hook asks for it —
run database updates after deploying 1.3.x.

## `field_guard.host_chain_walker` — `HostChainWalker`

`Drupal\field_guard\HostChainWalker` (no constructor arguments). Supports the own-subject view
exemption.

- `chain(EntityInterface $entity): ?array` — returns the chain from `$entity` to its root host
  (root last), following duck-typed `getParentEntity()`. Returns NULL when the root cannot be
  established: a cycle (tracked in `$seen`), the depth cap (`MAX_DEPTH = 8`), or a parent accessor
  returning a non-entity. An entity with no `getParentEntity()` method, or one reporting no parent
  (an orphan), returns the partial chain so cacheability metadata still covers every entity
  consulted — an orphan simply has no user root and therefore exempts nothing.

The hook helper `_field_guard_chain_is_own_subject(?array $chain, AccountInterface $account)`
returns TRUE only when the chain's root is a `UserInterface` whose id equals the acting account's,
and the account is authenticated — a NULL chain or anonymous returns FALSE (fail closed).

See [../configure/settings.md](../configure/settings.md) for the config map these services read
and how `field_guard_entity_field_access()` composes them into a verdict.
