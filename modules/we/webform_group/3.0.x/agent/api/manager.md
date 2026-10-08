# `WebformGroupManager` service

Service id `webform_group.manager` (`\Drupal\webform_group\WebformGroupManager`,
interface `WebformGroupManagerInterface`). Central helper for resolving the group relationship of
the current/target webform submission and the user's group roles. Used by every access hook and
the token file.

Constructor args: `@current_user`, `@config.factory`, `@entity_type.manager`, `@webform.request`,
`@webform.access_rules_manager`.

## Methods
| Method | Returns / does |
|---|---|
| `getCurrentGroupRelationship()` | The `GroupRelationship` for the current request's webform source entity (via `webform.request`), or FALSE. Cached per request. |
| `getCurrentGroupWebform()` | The current `Webform` if the request is on a group relationship, else NULL. |
| `getCurrentUserGroupRoles()` | Array of the current user's group roles (keyed = value) for the current group relationship (includes implied roles). |
| `getWebformSubmissionGroupRelationship($submission)` | The `GroupRelationship` for a submission's source entity, or NULL. |
| `getWebformSubmissionUserGroupRoles($submission, $account)` | An account's group roles for a submission's group. |
| `getAccessRules($webform)` | The webform's access rules merged with defaults, each augmented with a `group_roles` key (`configuration` rule removed). Cached per webform. |
| `isGroupRoleTokenEnabled($group_role_id)` | Whether a role is on the `mail.group_roles` allowlist. |
| `isGroupOwnerTokenEnable()` | Whether `mail.group_owner` is enabled. |

Group roles are loaded through `GroupRoleStorage::loadByUserAndGroup($account, $group, TRUE)`
(the `TRUE` includes implied outsider/insider/member roles), then returned as
`array_combine($ids, $ids)`.

## Usage
```php
$mgr = \Drupal::service('webform_group.manager');
$roles = $mgr->getCurrentUserGroupRoles();
$rules = $mgr->getAccessRules($webform);
if (array_intersect($rules['view_any']['group_roles'], $roles)) {
  // allowed
}
```
