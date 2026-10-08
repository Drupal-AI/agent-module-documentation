# Extend — decorate relation handlers & alter behaviour

Group splits each relation plugin's behaviour into six handler services. You change how *every*
relation behaves by **decorating** a default handler, or how *one* plugin behaves by supplying
a plugin-specific handler service.

## Decorate a default handler (affects all relations)

The `group_support_revisions` submodule is the canonical example — it decorates the permission
provider to add revision permissions:

```yaml
# my_module.services.yml
services:
  group.relation_handler_decorator.permission_provider.my_module:
    class: 'Drupal\my_module\Plugin\Group\RelationHandler\MyPermissionProvider'
    decorates: 'group.relation_handler.permission_provider'
    decoration_priority: 50
    arguments: ['@group.relation_handler_decorator.permission_provider.my_module.inner']
```

```php
use Drupal\group\Plugin\Group\RelationHandler\PermissionProviderInterface;
use Drupal\group\Plugin\Group\RelationHandler\PermissionProviderTrait;

class MyPermissionProvider implements PermissionProviderInterface {
  use PermissionProviderTrait;

  public function __construct(PermissionProviderInterface $parent) {
    $this->parent = $parent;
  }
  // Override getPermission() / buildPermissions() and delegate to $this->parent for the rest.
}
```

Decoratable default handler services (each `shared: false`):
`group.relation_handler.access_control`, `.entity_reference`, `.operation_provider`,
`.permission_provider`, `.post_install`, `.ui_text_provider`. Each has a matching
`*Interface` + `*Trait` under `Drupal\group\Plugin\Group\RelationHandler`, plus `Empty*`
implementations to start from.

## Plugin-specific handler (affects one plugin)

Register `group.relation_handler.<type>.<plugin_id>` — the manager prefers it over the default.
`group_membership` does this for all six handler types (e.g.
`group.relation_handler.permission_provider.group_membership` →
`GroupMembershipPermissionProvider`).

## Hooks

- `hook_group_relation_type_alter(&$definitions)` — alter discovered relation plugin definitions.
- `hook_group_operations_alter(array &$operations, GroupInterface $group)` — alter the links in
  the Group Operations block (defined in `group.api.php`).

## Bundle classes

Relation plugins may declare a `shared_bundle_class` so their `group_relationship` records use a
custom entity class — `group_membership` uses `Drupal\group\Entity\GroupMembership`. Extend a
relation by giving it (or subclassing) a bundle class with domain methods.
