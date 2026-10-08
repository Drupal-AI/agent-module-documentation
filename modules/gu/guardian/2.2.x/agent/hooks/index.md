<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Guardian — extension hooks

Guardian defines two alter/info hooks (see `guardian.api.php`). Both are invoked by `GuardianManager`.

## `hook_guardian_guarded_users(): array`

Return additional guarded accounts as `[uid => email]`. Guardian always guards uid 1 (from `$settings['guardian_mail']`); this hook adds more. Each returned entry is kept only if the **uid is numeric and >= 2** and the **email is valid** (`GuardianManager::getGuardedUsers()`), so you cannot use it to override or unguard uid 1, nor add anonymous.

```php
/**
 * Guard every account with the 'administrator' role.
 */
function mymodule_guardian_guarded_users(): array {
  $guarded = [];
  $admins = \Drupal::entityTypeManager()->getStorage('user')
    ->loadByProperties(['roles' => 'administrator']);
  foreach ($admins as $uid => $admin) {
    $guarded[(int) $uid] = $admin->getEmail();
  }
  return $guarded;
}
```

Once guarded, these accounts also get mail/password revert on save, the disabled edit form, and the access restriction.

The list is memoised in a static; after installing a module that implements this hook within the same request (e.g. tests), call `\Drupal::service('guardian.manager')->resetGuardedUsers()`.

## `hook_guardian_add_metadata_to_body_alter(array &$body)`

Append extra lines to Guardian's notification and password-reset mail bodies. Guardian itself already adds client IP, host and (on CLI) the terminal user via `GuardianManager::addMetadataToBody()`; this alter runs at the end.

```php
function mymodule_guardian_add_metadata_to_body_alter(array &$body) {
  if (!empty($_SERVER['HTTP_USER_AGENT'])) {
    $body[] = t('User agent: @ua', ['@ua' => $_SERVER['HTTP_USER_AGENT']]);
  }
}
```

## Related core hooks Guardian implements (not for you to call)

`hook_user_presave` (credential revert), `hook_form_user_form_alter` (disable fields), `hook_ENTITY_TYPE_access` for user (restrict view/edit), `hook_mail` / `hook_mail_alter` (notifications), `hook_cron`, `hook_requirements`, `hook_install` / `hook_uninstall`.
