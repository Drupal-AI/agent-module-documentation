# Add a permission calculator

Flexible permissions has **no annotation/attribute plugin type and no plugin manager**.
"Permission calculators" are plain **tagged services** collected by a `service_collector` into
the `ChainPermissionCalculator`. In 2.0.x the module also bridges to Drupal core's **Access
Policy API**, so new implementations are usually written as core Access Policies.

## Two ways to register a calculator

- **Legacy (still supported):** implement `PermissionCalculatorInterface` and tag the service
  `flexible_permission_calculator`. It is collected via
  `{ name: 'service_collector', call: 'addCalculator', tag: 'flexible_permission_calculator' }`
  on `flexible_permissions.chain_calculator`.
- **2.0.x preferred:** provide a core Access Policy — a class extending
  `Drupal\Core\Session\AccessPolicyBase`, tagged `access_policy`. The bundled
  `Drupal\flexible_permissions\AccessPolicy` (service `access_policy.flexible_permissions`,
  tagged `access_policy`) bridges every FP calculator into core; a native Access Policy plugs
  straight into core and interops with FP through `toCore()` / `fromCore()`.

## Legacy calculator (tagged service)

```php
namespace Drupal\my_module;

use Drupal\Core\Session\AccountInterface;
use Drupal\flexible_permissions\CalculatedPermissionsItem;
use Drupal\flexible_permissions\PermissionCalculatorBase;
use Drupal\flexible_permissions\RefinableCalculatedPermissions;

class MyCalculator extends PermissionCalculatorBase {

  // Build pass: add items for the REQUESTED scope only.
  public function calculatePermissions(AccountInterface $account, $scope) {
    $calculated = new RefinableCalculatedPermissions();
    $calculated->addCacheContexts($this->getPersistentCacheContexts($scope));

    if ($scope === 'my_scope') {
      // CalculatedPermissionsItem($scope, $identifier, $permissions, $is_admin = FALSE)
      $calculated->addItem(new CalculatedPermissionsItem('my_scope', 42, ['view foo'], FALSE));
    }
    return $calculated;
  }

  // Declare EVERY context the result varies by, unconditionally (security-critical).
  public function getPersistentCacheContexts($scope) {
    return ['user'];
  }
}
```

```yaml
# my_module.services.yml
services:
  my_module.my_calculator:
    class: Drupal\my_module\MyCalculator
    tags:
      - { name: flexible_permission_calculator }
```

`PermissionCalculatorBase` implements both `PermissionCalculatorInterface` and
`PermissionCalculatorAlterInterface`, defaulting `getPersistentCacheContexts()` to `[]` and
`alterPermissions()` to a no-op — override what you need.

## Rules the chain enforces

- **Return only the requested scope.** During the build pass a calculator may add items only for
  `$scope`. Returning any other scope throws `CalculatedPermissionsScopeException`. Returning an
  empty result is fine (the calculator had nothing to say).
- **Build pass then alter pass.** The chain first calls `calculatePermissions()` on every
  calculator and merges the results, then calls `disableBuildMode()` and runs the alter pass.
- **Declare all cache contexts up front.** Anything the permissions vary by MUST be returned by
  `getPersistentCacheContexts()` unconditionally — conditional contexts break the cache and risk
  privilege escalation. Never use a cache context that itself depends on calculated permissions
  (infinite loop).

## Altering the built permissions

Implement an alter interface to modify the complete set after the build pass:

- `PermissionCalculatorAlterInterfaceV2::alterPermissions(AccountInterface $account, $scope, RefinableCalculatedPermissionsInterface $calculated_permissions)` — preferred (has account + scope).
- `PermissionCalculatorAlterInterface::alterPermissions(RefinableCalculatedPermissionsInterface $calculated_permissions)` — legacy signature.

In the alter pass build mode is disabled, so you can `removeItem()`, `removeItemsByScope()`,
`removeItems()` and re-`addItem()` with `$overwrite = TRUE`.

See [api/flexible_permissions.md](../api/flexible_permissions.md) for the value objects and the
services that consume these calculators.
