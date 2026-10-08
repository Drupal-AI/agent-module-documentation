<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ExternalRolesAccessPolicy + cache context

## Access policy

File: `src/ExternalRolesAccessPolicy.php`
Class: `Drupal\external_roles\ExternalRolesAccessPolicy` (`final`, extends `Drupal\Core\Session\AccessPolicyBase`).
Service: `access_policy.external_roles`, tagged `{ name: access_policy }`, constructor arg `@external_roles`.

This is a core **Access Policy API** plugin (Drupal 10.3+). Core's `AccessPolicyProcessor` runs every tagged
access policy to build a user's `CalculatedPermissions`.

- `calculatePermissions(AccountInterface $account, string $scope): RefinableCalculatedPermissionsInterface`
  Calls `parent::calculatePermissions()`, then fetches `$this->externalRoles->getPermissions($account)`
  (see [service.md](service.md)) and appends them as one `CalculatedPermissionsItem($external_permissions)`.
  The item carries no scope/identifier args, so the permissions apply in the (default) scope core requests.
- `getPersistentCacheContexts(): array` returns `['user.external_roles']`. Core keys the cached calculated
  permissions by this context (unioned with the other policies' contexts), so the external-role contribution
  is cached per external-role set.

The policy adds only what the service returns; it grants nothing on its own and defines no
`applies()` override (so it applies in the standard scope). To change *what* permissions a role maps to,
change the repository ([repository.md](repository.md)), not this class.

## Cache context

File: `src/Cache/Context/ExternalRolesCacheContext.php`
Class: `Drupal\external_roles\Cache\Context\ExternalRolesCacheContext` (implements `CacheContextInterface`).
Service: `cache_context.user.external_roles`, tagged `{ name: cache.context }`, args
`@current_user`, `@external_roles`. Context id: **`user.external_roles`**.

- `getLabel()` → `t('User External Roles')`.
- `getContext()` → `implode(',', $this->externalRoles->getExternalRoles($currentUser->getAccount()))`
  — the current user's external roles (already sorted by the service's query) joined into a string.
- `getCacheableMetadata()` → adds the current account as a cacheable dependency (so the context is
  invalidated when that user is saved).

Because the Access Policy API relies on caching, **a cache rebuild (`drush cr`) is required whenever the
role→permission definition changes** (the definition is not itself a cache-context input, so changing it
does not auto-invalidate cached permissions). Assigning/removing a user's external roles saves the user
entity, which invalidates that user via the context's cacheable dependency.
