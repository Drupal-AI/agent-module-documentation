# Hooks this submodule implements

This submodule adds no new hook API of its own; it customizes the parent module by implementing
these hooks. Understanding them tells you how to override or coexist with it.

## `hook_email_registration_name_alter()` — full-email username + sync

```php
function email_registration_username_email_registration_name_alter(string &$newAccountName, UserInterface $account) {
  $accountName = $account->getAccountName();
  if (empty($accountName) || str_starts_with($accountName, 'email_registration_')) {
    // New account: username becomes the FULL email address.
    $newAccountName = $account->getEmail();
  }
  elseif (!$account->isNew()
    && $account->getEmail() !== $account->original->getEmail()
    && $account->original->getEmail() === $account->original->getAccountName()) {
    // Existing account whose username was in sync with the old email:
    // re-sync to the new email. Otherwise leave a custom username alone.
    $newAccountName = $account->getEmail();
  }
}
```

Both `email_registration` and this submodule implement `hook_email_registration_name_alter()`, so
if your own module also implements it, mind **module hook execution order** to make your value win.

## `hook_user_format_name_alter(&$name, AccountInterface $account)` — display-name override

Applies the `username_display_override_mode` setting when rendering a user's display name:
`disabled` returns unchanged; `email_registration` sets `$name` to
`email_registration_strip_mail_and_cleanup($account->getEmail())` (part before `@`); `custom` runs
`\Drupal::token()->replace($username_display_custom, ['user' => $account])`. It **returns early
without overriding** for the current user if they have the `view user email addresses` permission.

## `hook_action_info_alter(&$definitions)` — swap the bulk action

Rewrites the `email_registration_update_username` action's class to
`UpdateUsernameWithMailAction` (writes the full email as the username). See
[../configure/email_registration_username.md](../configure/email_registration_username.md).

## `hook_form_user_admin_settings_alter()` / `hook_install()`

Adds the display-override fields to the Account settings form and disables the parent's
`login_with_username` checkbox; on install forces that setting to false.
