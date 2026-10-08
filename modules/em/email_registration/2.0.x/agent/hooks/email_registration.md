# Hooks — customize the generated username

Documented in `email_registration.api.php`.

## `hook_email_registration_name_alter(string &$newAccountName, UserInterface $account): void`

The supported extension point (since 2.0). Alter `$newAccountName` by reference to control the
username that gets stored. Only takes effect if the value actually differs from the current name;
the module then guarantees uniqueness before saving.

```php
/**
 * Implements hook_email_registration_name_alter().
 */
function mymodule_email_registration_name_alter(string &$newAccountName, \Drupal\user\UserInterface $account): void {
  // Only override the auto-generated placeholder, not names a user chose:
  if (empty($newAccountName) || str_starts_with($newAccountName, 'email_registration_')) {
    // Ensure the result is a legal username; the module de-duplicates it after.
    $newAccountName = email_registration_cleanup_username('user_' . $account->getEmail());
  }
}
```

Both `email_registration` and the `email_registration_username` submodule implement this hook, so
mind **module hook execution order** if your override must win.

## `hook_email_registration_name(UserInterface $account): ?string` — DEPRECATED

Return a string to use as the username, or `NULL` to let the module generate it. **Deprecated in
email_registration:2.0.0, removed in 3.0.0** — migrate to `hook_email_registration_name_alter()`
(see drupal.org issue 3396028). Implementations must do their own uniqueness/validation, e.g. with
`email_registration_unique_username()`.

## Core user hooks

Username generation is driven from `hook_ENTITY_TYPE_presave()`
(`email_registration_user_presave`). Standard core `hook_user_presave` / `hook_user_insert` etc.
still fire normally if you need to react to accounts being created or renamed.
