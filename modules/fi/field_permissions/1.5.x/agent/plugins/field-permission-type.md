# FieldPermissionType plugin type

Defines the strategies offered on a field's "permission type" selector.

- Manager: `plugin.field_permissions.types.manager`
  (`Plugin\FieldPermissionType\Manager`, extends `DefaultPluginManager`).
- Discovery dir: `src/Plugin/FieldPermissionType/`.
- Annotation: `@FieldPermissionType` (`id`, `title`, `description`, `weight`).
- Interface: `FieldPermissionTypeInterface`; base class: `FieldPermissionType\Base`.
- Optional mixins: `CustomPermissionsInterface` (contribute named permissions),
  `AdminFormSettingsInterface` (add rows to the field settings form).
- Alter hook: `hook_field_permission_type_plugin_alter()`.

Built-in plugins: `private` (`PrivateAccess`) and `custom` (`CustomAccess`); "Public" is the
absence of a restricting plugin.

## Implement one
```php
namespace Drupal\my_module\Plugin\FieldPermissionType;

use Drupal\field_permissions\Plugin\FieldPermissionType\Base;
use Drupal\Core\Session\AccountInterface;
use Drupal\Core\Field\FieldItemListInterface;
use Drupal\Core\Field\FieldDefinitionInterface;

/**
 * @FieldPermissionType(
 *   id = "my_rule",
 *   title = @Translation("My rule"),
 *   description = @Translation("Custom field access strategy."),
 *   weight = 60,
 * )
 */
class MyRule extends Base {

  public function hasFieldAccess($operation, EntityInterface $entity, AccountInterface $account) {
    // 'view' | 'edit' — return TRUE/FALSE.
  }
}
```
Implement `CustomPermissionsInterface::getPermissions()` if the plugin should expose its own
named permissions on the People → Permissions page.
