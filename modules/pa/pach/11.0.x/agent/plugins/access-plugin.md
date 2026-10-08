<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# pach — writing an access control plugin

pACH swaps each entity type's access handler for its own, which runs every registered access plugin.

## Define a plugin
Create `src/Plugin/pach/MyHandler.php` in your module:

```php
namespace Drupal\my_module\Plugin\pach;

use Drupal\Core\Access\AccessResultInterface;
use Drupal\Core\Access\AccessResult;
use Drupal\Core\Entity\EntityInterface;
use Drupal\Core\Session\AccountInterface;
use Drupal\pach\Attribute\AccessControlHandler;
use Drupal\pach\Plugin\AccessControlHandlerBase;

#[AccessControlHandler(id: 'my_node', type: 'node', weight: 0)]
class MyHandler extends AccessControlHandlerBase {

  public function applies(EntityInterface|AccountInterface \$entity, string \$operation, ?AccountInterface \$account = NULL): bool {
    return \$entity->getEntityTypeId() === 'node';
  }

  public function access(AccessResultInterface &\$access, EntityInterface \$entity, string \$operation, ?AccountInterface \$account = NULL): void {
    if (\$operation === 'update') {
      // Combine with the running result; ->andIf / ->orIf as needed.
      \$access = \$access->orIf(AccessResult::allowedIfHasPermission(\$account, 'my custom perm'));
    }
  }

  public function createAccess(AccessResultInterface &\$access, \$entity_bundle = NULL, ?AccountInterface \$account = NULL, array \$context = []): void {}
  public function fieldAccess(AccessResultInterface &\$access, string \$operation, \$field_definition, ?AccountInterface \$account = NULL, \$items = NULL): void {}
}
```

- `type` = the entity type id the plugin controls; optional `weight` orders plugins (lower runs first).
- `applies()` gates whether the plugin runs for this entity/operation/account — return early to stay out of unrelated checks.
- Each `access`/`createAccess`/`fieldAccess` method receives the current `AccessResult` **by reference** — mutate it and combine with `andIf()`/`orIf()` so you cooperate with other plugins and core rules.
- The legacy `@AccessControlHandler` annotation still resolves but is **deprecated in pACH 11.0.0** and removed in Drupal 12; use the attribute.

## Discovery
`plugin.manager.pach` finds plugins under `Plugin/pach` and sorts them by `weight`. No routing or config; enabling the providing module is enough. See the `pach_examples` submodule (`BlockExample`, `NodeExample`) for full examples.

## Caution
Returning `AccessResult::allowed()` broadens access. Prefer `allowedIf...`/`forbiddenIf...` and never grant more than intended — this code runs on every access check for the entity type. Set cacheability on your `AccessResult` (e.g. `->cachePerPermissions()`, `->addCacheableDependency($entity)`) so results vary correctly.
