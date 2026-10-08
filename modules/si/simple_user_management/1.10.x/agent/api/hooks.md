# Hook: bypass the delete delegation check

Declared in `simple_user_management.api.php`; invoked from `UserDeleteForm::buildForm()`.

```php
/**
 * Allow bypassing the role-delegation guard for deletion.
 *
 * @param bool $bypass_role_delegation_check  Set TRUE to allow deletion regardless of delegation.
 * @param array $context  ['current_user' => AccountProxyInterface, 'target_user' => UserInterface]
 */
function hook_simple_user_management_delete_role_delegation_check_alter(bool $bypass_role_delegation_check, array &$context) {
  // Example: allow deleting users whose only "blocking" role is synced externally.
  if (in_array('external_sync', $context['target_user']->getRoles(), TRUE)) {
    $bypass_role_delegation_check = TRUE;
  }
  return $bypass_role_delegation_check;
}
```

Notes:
- Only the **delete** form fires this alter; approve/deactivate/change-password do not.
- Implementation: `$this->moduleHandler->alter('simple_user_management_delete_role_delegation_check', $bypass_role_delegation_check, $context)`. The by-value `$bypass_role_delegation_check` is passed as
  the alterable subject; set it inside your implementation (Drupal's `alter()` passes the first argument
  by reference) to grant the bypass.
- Deletion proceeds if EITHER the normal delegation guard passes OR the bypass flag is set.
