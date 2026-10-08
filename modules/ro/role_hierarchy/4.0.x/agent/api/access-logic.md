<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Access logic and integration points

All decisions run through the **`role_hierarchy.helper`** service
(`Drupal\role_hierarchy\Service\RoleHierarchyHelper`).

## Service methods

- `getAccountHighestRole(AccountInterface): RoleInterface|NULL` — the account's most-powerful
  hierarchical role (lowest weight, or highest when `invert`), after excluding
  `non_hierarchical_roles`. NULL if the account has none.
- `getAccountRoleWeight(AccountInterface): int` — that role's weight, or `9999`/`-9999`
  (inverted) when the account has no hierarchical role.
- `getRoleWeight($role): int` — weight of a role (id or entity).
- `hasRoleEditAccess(AccountInterface, $edited_role): bool` — the core weight comparison
  (see the table in [../configure/hierarchy.md](../configure/hierarchy.md)); TRUE if the
  account holds `bypass role hierarchy`.
- `hasEditAccess(AccountInterface, User): bool` — whether the account may edit/delete the
  user. Always TRUE for user 1 (as editor), for self-edit, and for `bypass role hierarchy`;
  always FALSE when the **target** is user 1 (and editor is not user 1); otherwise defers to
  `hasRoleEditAccess()` against the target's highest role.

Call it from custom code:

```php
$helper = \Drupal::service('role_hierarchy.helper');
if ($helper->hasEditAccess(\Drupal::currentUser(), $some_user)) { /* allowed */ }
```

## Where it is enforced (in `role_hierarchy.module`)

1. **`role_hierarchy_user_access(User $entity, $operation, $account)`** — a
   `hook_ENTITY_TYPE_access()` for `user`. For `update`/`delete` it returns
   `AccessResult::forbiddenIf(!hasEditAccess(...))`; neutral for other operations.
2. **`role_hierarchy_form_user_form_alter()` / `_user_register_form_alter()`** — remove role
   checkboxes the current user cannot grant from `$form['account']['roles']['#options']`.
   Roles you already hold on your **own** account are never hidden. The roles element is shown
   if you have `edit user roles`.
3. **`role_hierarchy_action_info_alter()`** — replaces the classes of core's
   `user_add_role_action` and `user_remove_role_action` with
   `RoleHierarchyAddRoleUser` / `RoleHierarchyRemoveRoleUser`, whose `access()` wraps the
   parent action's access with `RoleHierarchyHelper::actionPluginAccess()` so bulk role
   grants/removes on the People listing respect the hierarchy. (These subclass core's Action
   plugins; the module defines no new plugin *type*.)

## Gotcha in the source

`RoleHierarchyHelper::getRoleWeight()` hard-codes `return 9999` for the role id
`workflow_author` (a site-specific special case). If you happen to use that role id, its weight
is forced to 9999 (weakest, non-inverted) regardless of its configured order.
