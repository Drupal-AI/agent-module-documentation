# Programmatic API — entities & services

## The `group` entity — `Drupal\group\Entity\GroupInterface`

```php
$group = \Drupal::entityTypeManager()->getStorage('group')
  ->create(['type' => 'team', 'label' => 'My team']);
$group->save();

$group->addMember($user, $values = []);              // add a member (creates a group_relationship)
$group->removeMember($user);
$group->getMember($account);                          // Drupal\group\Entity\GroupMembership|false
$group->getMembers($roles = NULL);                    // GroupMembership[]

$group->addRelationship($entity, $plugin_id, $values = []); // relate any entity
$group->getRelationships($plugin_id = NULL);          // GroupRelationship[]
$group->getRelationshipsByEntity($entity, $plugin_id = NULL);
$group->getRelatedEntities($plugin_id = NULL);        // the target entities

$group->hasPermission('edit group', $account);        // per-group permission check (bool)
$group->getGroupType();
```

## Memberships — `Drupal\group\Entity\GroupMembership`

`GroupMembership` is a bundle class of `group_relationship` (the `group_membership` relation).
Load via its **static** methods (the old `group.membership_loader` service and its
`GroupMembershipLoaderInterface` are **deprecated** since 3.2.0):

```php
use Drupal\group\Entity\GroupMembership;

GroupMembership::loadSingle($group, $account);        // one membership or FALSE
GroupMembership::loadByGroup($group, $roles = NULL);  // members of a group
GroupMembership::loadByUser($account = NULL, $roles = NULL); // a user's memberships (NULL = current user)
```

Instance methods: `getRoles($include_synchronized = TRUE)`, `addRole($role_id)`,
`removeRole($role_id)`, `hasPermission($permission)`, `getGroup()`, `getGroupContent()`.

## Permission checking services

- `group_permission.checker` (`GroupPermissionCheckerInterface`) —
  `hasPermissionInGroup($permission, $account, $group)`. This is what `$group->hasPermission()`
  uses under the hood.
- `group_permission.calculator` (`GroupPermissionCalculator`) — wraps the
  `flexible_permissions` chain calculator to build a user's calculated group permissions.
- `group_permission.hash_generator` — generates the permissions hash used for cache contexts.
- `group.permissions` (`GroupPermissionHandler`) — discovers the full list of group permissions
  (sitewide-style, from relation plugins' permission providers).

Two calculators feed the flexible_permissions chain (tagged
`flexible_permission_calculator`): `IndividualGroupPermissionCalculator` (individual-scope
roles from memberships) and `SynchronizedGroupPermissionCalculator` (outsider/insider roles
synchronized from global roles).

## Relation plugins at runtime

```php
$manager = \Drupal::service('group_relation_type.manager');
$manager->getInstalledIds($group_type);               // plugin ids installed on a group type
$manager->getPluginIdsByEntityTypeId('node');         // relation plugins for an entity type
```

## Cache contexts

`route.group`, `user.group_permissions`, `user.is_group_member` — use these on render arrays
that vary by the current group or the user's group membership/permissions.

## Deprecated service (do not use in new code)

`group.membership_loader` (`GroupMembershipLoader` / `GroupMembershipLoaderInterface`) —
replaced by the static `GroupMembership::load*` methods above.
