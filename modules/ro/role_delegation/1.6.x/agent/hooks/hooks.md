# Role Delegation hooks

One alter hook (see `role_delegation.api.php`):

## `hook_role_delegation_assignable_roles_alter(&$assignable_roles, &$all_roles, $account)`
Filter the list of roles a given account is allowed to assign, after Role Delegation has built
it from permissions.

- `$assignable_roles` — array keyed by role machine name → label; **modify this** to add/remove.
- `$all_roles` — all roles in the system (reference).
- `$account` — the `AccountInterface` whose assignable set is being computed.

```php
function my_module_role_delegation_assignable_roles_alter(array &$assignable_roles, array &$all_roles, \Drupal\Core\Session\AccountInterface $account): void {
  // Never let anyone delegate the 'editor' role via the UI.
  unset($assignable_roles['editor']);
}
```
Invoked from the `delegatable_roles` service, so it affects the per-user Roles form, the user
add/edit form, the bulk actions and the entity-reference selection alike.
