<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Extension points: events and the one hook

OG exposes almost everything through Symfony events, not hooks. `og.api.php` documents a
single hook.

## Events

| `EVENT_NAME` constant | Event class | Purpose |
|---|---|---|
| `og.permission` (`PermissionEventInterface::EVENT_NAME`) | `PermissionEvent` | declare group-level and group-content-operation permissions |
| `og.default_role` (`DefaultRoleEventInterface::EVENT_NAME`) | `DefaultRoleEvent` | add extra roles created automatically for every new group type |
| `og.group_creation` (`GroupCreationEventInterface::EVENT_NAME`) | `GroupCreationEvent` | react when a bundle becomes a group |
| `og.group_content_entity_operation_access` (`GroupContentEntityOperationAccessEventInterface::EVENT_NAME`) | `GroupContentEntityOperationAccessEvent` | grant/deny CRUD on group content |
| `og.og_admin_routes` (`OgAdminRoutesEventInterface::EVENT_NAME`) | `OgAdminRoutesEvent` | add tabs to the per-group admin area |

OG's own implementation of the first three lives in
`Drupal\og\EventSubscriber\OgEventSubscriber`.

### Add a group-level permission

```php
use Drupal\og\Event\PermissionEventInterface;
use Drupal\og\GroupPermission;
use Drupal\og\OgRoleInterface;

public static function getSubscribedEvents(): array {
  return [PermissionEventInterface::EVENT_NAME => [['provideGroupLevelPermissions']]];
}

public function provideGroupLevelPermissions(PermissionEventInterface $event): void {
  $event->setPermission(new GroupPermission([
    'name' => 'set group privacy',
    'title' => $this->t('Set group privacy'),
    'description' => $this->t('…'),
    'default roles' => [OgRoleInterface::ADMINISTRATOR],
    'restrict access' => TRUE,
  ]));
}
```

For CRUD permissions use `GroupContentOperationPermission` instead, which carries
`entity_type`, `bundle`, `operation` and `owner`:

```php
new \Drupal\og\GroupContentOperationPermission([
  'entity_type' => 'node',
  'bundle' => 'article',
  'name' => 'delete own article content',
  'title' => $this->t('%type_name: Delete own content', ['%type_name' => 'article']),
  'operation' => 'delete',
  'owner' => TRUE,
]);
```

### Grant access to a group-content operation

```php
use Drupal\og\Event\GroupContentEntityOperationAccessEventInterface;

public function moderatorsCanManageComments(GroupContentEntityOperationAccessEventInterface $event): void {
  if ($event->getGroupContent()->getEntityTypeId() === 'comment'
      && $event->getUser()->hasPermission('edit and delete comments in all groups')) {
    $event->grantAccess();
  }
}
```

Semantics: access is granted if **any** subscriber (or any other rule) grants it, but a
`denyAccess()` is a **hard deny** that cannot be overruled — including across other groups the
entity belongs to. Prefer staying neutral unless you really mean to forbid.

## The hook

`hook_og_user_access_alter(array &$permissions, CacheableMetadata $cacheable_metadata, array $context)`
— alter the list of group-level permissions a user effectively has.
`$context` has `permission`, `group` and `user`. Add anything you read to
`$cacheable_metadata` so the access result caches correctly.

```php
function my_module_og_user_access_alter(array &$permissions, CacheableMetadata $cacheable_metadata, array $context): void {
  $config = \Drupal::config('my_module.settings');
  $group = $context['group'];
  if ($group instanceof EntityPublishedInterface && $group->isPublished()
      && !$config->get('delete_published_groups')) {
    if (($key = array_search(OgAccess::DELETE_GROUP_PERMISSION, $permissions)) !== FALSE) {
      unset($permissions[$key]);
    }
  }
  $cacheable_metadata->addCacheableDependency($config);
}
```

Called from `OgAccess::userAccess()` unless it is invoked with `$skip_alter = TRUE`.

## Other extension surfaces

- Decorate or replace the services `og.access`, `og.membership_manager`,
  `og.group_type_manager`, `og.permission_manager`, `og.role_manager`, `og.context`.
- Add an `OgGroupResolver` plugin and list it in `og.settings:group_resolvers`
  (see [../plugins/plugin-types.md](../plugins/plugin-types.md)).
- Access checks available to routes: `_og_user_access_group` (`Access\GroupCheck`) and
  `_og_membership_add_access` (`Access\OgMembershipAddAccessCheck`).
