<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Memberships, group lookups and access

## The `og_membership` entity

Content entity `og_membership`, bundle entity `og_membership_type` (default bundle `default`,
constant `OgMembershipInterface::TYPE_DEFAULT`). Base fields:

| Field | Type | Notes |
|---|---|---|
| `id`, `uuid` | | |
| `type` | entity_reference → og_membership_type | the membership bundle |
| `uid` | entity_reference → user | the member (memberships always link a **user** to a group) |
| `entity_type`, `entity_bundle`, `entity_id` | string | the group being joined |
| `state` | list_string | `active` \| `pending` \| `blocked` |
| `roles` | entity_reference → og_role | multi-value |
| `created`, `changed`, `language` | | |

Because it is fieldable you can add your own fields (join reason, expiry, …) per membership type.
The module also ships the `og_membership_request` field on the `default` bundle.

```php
use Drupal\og\Og;
use Drupal\og\Entity\OgRole;
use Drupal\og\OgRoleInterface;
use Drupal\og\OgMembershipInterface;

$membership = Og::createMembership($group, $user);   // optional 3rd arg: membership type id
$membership->save();                                  // state defaults to active

$membership->setState(OgMembershipInterface::STATE_PENDING)->save();
$membership->addRole(OgRole::loadByGroupAndName($group, OgRoleInterface::ADMINISTRATOR))->save();
$membership->revokeRoleById('node-club-administrator')->save();

$membership->getRolesIds();   // ['node-club-member', 'node-club-administrator']
$membership->isActive(); $membership->isPending(); $membership->isBlocked(); $membership->isOwner();
$membership->hasRole('node-club-administrator');
$membership->hasPermission('manage members');
```

A `UniqueOgMembership` constraint prevents two memberships for the same user+group, and
`ValidOgRole` prevents attaching a role that belongs to a different group type.

## `og.membership_manager` (`MembershipManagerInterface`)

```php
$mm = \Drupal::service('og.membership_manager');

$mm->getUserGroupIds($uid, $states = [STATE_ACTIVE]);      // ['node' => [1, 5]]
$mm->getUserGroups($uid);                                   // loaded entities
$mm->getUserGroupsByRoleIds($uid, ['node-club-administrator'], $states, $require_all_roles = TRUE);
$mm->getMemberships($uid);                                  // OgMembership[]
$mm->getMembership($group, $uid);                           // ?OgMembership
$mm->isMember($group, $uid); $mm->isMemberPending(...); $mm->isMemberBlocked(...);
$mm->getGroupMembershipCount($group, $states);
$mm->getGroupMembershipIdsByRoleNames($group, ['administrator']);
$mm->getGroupMembershipsByRoleNames($group, ['administrator']);
$mm->createMembership($group, $user, $membership_type = NULL);

// group content → groups
$mm->getGroupIds($group_content);            // ['node' => [delta => group_id]]
$mm->getGroups($group_content);              // loaded group entities
$mm->getGroupCount($group_content);
// group → group content
$mm->getGroupContentIds($group, ['node']);
```

`Drupal\og\Og` is a thin static facade over the same things (`Og::getMembership()`,
`Og::getGroupMemberships()`, `Og::isMember()`, `Og::isMemberPending()`, `Og::isMemberBlocked()`,
`Og::getMemberships()`), plus `Og::groupTypeManager()` and `Og::reset()`.

## `og.group_type_manager` (`GroupTypeManagerInterface`)

`isGroup()`, `isGroupContent()`, `getGroupBundleIdsByEntityType()`,
`getAllGroupContentBundleIds()`, `getAllGroupContentBundlesByEntityType()`,
`getGroupBundleIdsByGroupContentBundle()`, `getGroupContentBundleIdsByGroupBundle()`,
`addGroup()`, `removeGroup()`, `get/set/removeGroupDefaultMembershipType()`, `getGroupMap()`,
`reset()`, `resetGroupMap()`, `resetGroupRelationMap()`.

## `og.access` (`OgAccessInterface`)

All four return a cacheable `AccessResultInterface`:

```php
$og_access = \Drupal::service('og.access');

$og_access->userAccess($group, 'manage members', $user);            // fastest — you know the group
$og_access->userAccessEntity('manage members', $entity, $user);      // entity may be group OR group content
$og_access->userAccessEntityOperation('update', $group_content, $user);
$og_access->userAccessGroupContentEntityOperation('update', $group, $group_content, $user);
```

Constants on `Drupal\og\OgAccess`: `ADMINISTER_GROUP_PERMISSION` (`administer group`),
`UPDATE_GROUP_PERMISSION` (`update group`), `DELETE_GROUP_PERMISSION` (`delete group`), and
`OPERATION_GROUP_PERMISSION_MAPPING` (maps entity operations to group permissions).

Because OG implements the entity access hooks, `$group_content->access('update', $user)` already
routes through `userAccessEntityOperation()`. Access is granted when at least one group grants
it; an explicit **deny** from an event subscriber is a hard deny across all groups — use
`userAccessGroupContentEntityOperation()` per group if that matters.

Short-circuits inside `userAccess()`: user 1, the global permission
`administer organic groups`, `og.settings:group_manager_full_access` for the group owner, and
any role with `is_admin: TRUE`.

## Group context

`og.context` (`OgContextInterface`, also a `context_provider`) resolves "the current group" by
running the `OgGroupResolver` plugins listed in `og.settings:group_resolvers`, in order:

```php
$group = \Drupal::service('og.context')->getGroup();
```

Cache contexts OG registers: `og_group_context`, `og_membership_state`, `og_role`,
`og_permissions` — use them in `#cache['contexts']` when output varies per group/membership.

## Subscribe / unsubscribe

Routes `og.subscribe` (`group/{entity_type_id}/{group}/subscribe/{og_membership_type}`) and
`og.unsubscribe`. The `og_group_subscribe` field formatter on the group-type field renders the
link; `deny_subscribe_without_approval` and the `subscribe` /
`subscribe without approval` permissions decide whether the new membership is `active` or
`pending`.
