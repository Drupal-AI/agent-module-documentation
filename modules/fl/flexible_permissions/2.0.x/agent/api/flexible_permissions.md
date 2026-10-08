# Programmatic API — services, value objects, scopes, caching

## Check a permission — `flexible_permissions.checker`

`Drupal\flexible_permissions\PermissionChecker` (interface `PermissionCheckerInterface`).

```php
/** @var \Drupal\flexible_permissions\PermissionCheckerInterface $checker */
$checker = \Drupal::service('flexible_permissions.checker');

// hasPermissionInScope($permission, $scope, $identifier, AccountInterface $account): bool
$allowed = $checker->hasPermissionInScope('view foo', 'my_scope', 42, $account);
```

Internally it calls the chain calculator, fetches the item for `$scope`/`$identifier`, and
returns `$item && $item->hasPermission($permission)`.

## The chain calculator — `flexible_permissions.chain_calculator`

`Drupal\flexible_permissions\ChainPermissionCalculator` (interface
`ChainPermissionCalculatorInterface extends PermissionCalculatorInterface`). Runs every
registered calculator and returns an immutable `CalculatedPermissions`.

```php
$chain = \Drupal::service('flexible_permissions.chain_calculator');

// CalculatedPermissionsInterface for one account within one scope:
$permissions = $chain->calculatePermissions($account, 'my_scope');

$chain->getCalculators();                       // all collected calculators
$chain->getPersistentCacheContexts('my_scope'); // merged, statically cached contexts
$chain->addCalculator($calculator);             // normally done via the service tag
```

`calculatePermissions()` two-pass flow: build (each calculator adds items, merged), then
`disableBuildMode()` + alter pass (calculators implementing
`PermissionCalculatorAlterInterfaceV2`/`PermissionCalculatorAlterInterface`). It tags the result
with the `flexible_permissions` cache tag. A calculator returning a scope other than the one
requested triggers `CalculatedPermissionsScopeException`.

## `CalculatedPermissions` / `RefinableCalculatedPermissions` value objects

`CalculatedPermissions` is the immutable result (implements `CalculatedPermissionsInterface`,
which extends `CacheableDependencyInterface`). `RefinableCalculatedPermissions` is the mutable
builder used while calculating (adds `RefinableCacheableDependencyInterface`).

Read methods (`CalculatedPermissionsInterface`):

```php
$permissions->getItem($scope, $identifier);   // CalculatedPermissionsItemInterface|FALSE
$permissions->getItems();                      // all items, any scope
$permissions->getItemsByScope($scope);         // items for one scope
$permissions->getScopes();                     // scope names in use
$permissions->toCore();                         // -> core CalculatedPermissionsInterface
CalculatedPermissions::fromCore($core_object);  // core -> FP (static)
```

Mutating methods (`RefinableCalculatedPermissionsInterface`, only after `disableBuildMode()` for
removal/overwrite):

```php
$refinable->addItem($item, $overwrite = FALSE); // merge (or overwrite) an item
$refinable->removeItem($scope, $identifier);
$refinable->removeItemsByScope($scope);
$refinable->removeItems();
$refinable->merge($other);                       // merge items + cacheable metadata
$refinable->disableBuildMode();                  // @internal; unlock remove/overwrite
```

## `CalculatedPermissionsItem`

A single entry (`CalculatedPermissionsItemInterface`).

```php
use Drupal\flexible_permissions\CalculatedPermissionsItem;

// __construct($scope, $identifier, $permissions, $is_admin = FALSE)
$item = new CalculatedPermissionsItem('my_scope', 42, ['view foo', 'edit foo']);

$item->getScope();            // 'my_scope'
$item->getIdentifier();       // 42
$item->getPermissions();      // ['view foo', 'edit foo']  (empty array when isAdmin)
$item->isAdmin();             // bool — admin grants everything in the scope
$item->hasPermission('view foo'); // TRUE if isAdmin() OR permission is present
$item->toCore();              // core CalculatedPermissionsItemInterface
CalculatedPermissionsItem::fromCore($core_item);
```

When `$is_admin` is TRUE the permission list is stored empty and `hasPermission()` always
returns TRUE for that scope.

## Scopes

A **scope** is just a string namespace for permissions; an **identifier** locates one entity
within it. Each calculator decides which scopes it answers for. There is no central registry —
scopes are conventional. The Group module, for example, uses `group_outsider`, `group_insider`
and `group_individual`. Your "regular" Drupal permissions can be thought of as a `default` scope.
The chain rejects any calculator that returns a scope other than the one requested during build.

## Caching (VariationCache)

Calculated permissions are cached so conditional/expensive calculations aren't repeated. The
chain calculator is wired (see `flexible_permissions.services.yml`) with:

- `variation_cache.flexible_permissions` — persistent VariationCache (bin `flexible_permissions`).
- `variation_cache.flexible_permissions_memory` — in-request static VariationCache.
- `cache.flexible_permissions_memory` — regular memory cache for the merged cache-context list.
- `@account_switcher` — lets it compute a cache ID for an account other than the current user by
  switching to that account around cache get/set.

Cache keys are `['flexible_permissions', $scope]`. The result varies by the **persistent cache
contexts** every calculator declares in `getPersistentCacheContexts()` — this is why office-hours
or per-user conditional permissions cache correctly. All entries carry the `flexible_permissions`
cache tag, so invalidating that tag flushes every calculated permission set.

## Core Access Policy bridge (2.0.x)

`Drupal\flexible_permissions\AccessPolicy` (service `access_policy.flexible_permissions`, tagged
`access_policy`) extends core's `AccessPolicyBase` and forwards to the chain calculator, so FP
calculators participate in Drupal core's Access Policy API. `toCore()`/`fromCore()` on the value
objects convert between the FP and core representations.

To implement a calculator, see [plugins/flexible_permissions.md](../plugins/flexible_permissions.md).
