# The decoration pattern (a reference example)

group_support_revisions is the canonical example of **decorating a Group relation handler** to
change behaviour across every relation plugin at once. Study it when writing your own handler
decorator (see the parent module's [extend doc](../../../../3.3.x/agent/extend/group.md)).

## The service

```yaml
# group_support_revisions.services.yml
services:
  group.relation_handler_decorator.permission_provider.support_revisions:
    class: 'Drupal\group_support_revisions\Plugin\Group\RelationHandler\SupportRevisionsPermissionProvider'
    decorates: 'group.relation_handler.permission_provider'
    decoration_priority: 50
    arguments: ['@group.relation_handler_decorator.permission_provider.support_revisions.inner']
```

## The class

```php
class SupportRevisionsPermissionProvider implements PermissionProviderInterface {
  use PermissionProviderTrait { init as defaultInit; }

  public function __construct(PermissionProviderInterface $parent) {
    $this->parent = $parent;
  }

  public function init($plugin_id, GroupRelationTypeInterface $group_relation_type) {
    $this->defaultInit($plugin_id, $group_relation_type);
    $this->implementsRevisionableInterface =
      $this->entityType->entityClassImplements(RevisionableInterface::class);
  }

  public function getPermission($operation, $target, $scope = 'any') {
    // Handle the extra revision operations here...
    // else delegate:
    return $this->parent->getPermission($operation, $target, $scope);
  }
}
```

Key techniques to copy:
- Implement `PermissionProviderInterface`, `use PermissionProviderTrait`, aliasing `init`
  so you can run the default init then add your own state.
- Store the decorated handler as `$this->parent` and **delegate** any operation you do not
  handle back to it, so the rest of the chain keeps working.
- In `buildPermissions()`, resolve the full provider chain via
  `$this->groupRelationTypeManager()->getPermissionProvider($this->pluginId)` instead of only
  this decorator, so downstream renames/removals are honoured.

The same `decorates:` approach works for the other five handler types
(`access_control`, `entity_reference`, `operation_provider`, `post_install`,
`ui_text_provider`).
