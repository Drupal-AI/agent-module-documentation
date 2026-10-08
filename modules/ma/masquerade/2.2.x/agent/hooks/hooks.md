# Hooks

Declared in `masquerade.api.php`.

### `hook_masquerade_access(UserInterface $user, UserInterface $target_account)`
Control whether `$user` may masquerade **as** `$target_account`. Return:
- `FALSE` — explicitly deny (a single denial wins; no other module can override).
- `TRUE` — grant (access needs at least one grant and no denials).
- `NULL` / nothing — abstain (if nobody grants, access is denied).

```php
function mymodule_masquerade_access(\Drupal\user\UserInterface $user, \Drupal\user\UserInterface $target_account) {
  if ($target_account->id() == 1) {
    return FALSE; // never allow impersonating UID 1 here
  }
  if ($target_account->label() === 'demo') {
    return TRUE;  // anyone may become the demo user
  }
  // else: abstain
}
```

Invoked alongside the permission checks by `Access\SwitchAccessCheck` when resolving the
`_masquerade_switch_access` route requirement.
