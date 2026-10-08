<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Guardian hooks

Defined in `guardian.api.php`. Implement in `MYMODULE.module`.

## `hook_guardian_guarded_users(): array`
Guard accounts **beyond uid 1**. Return an array of guarded email addresses keyed by user id.
Guardian merges these with uid 1 (always guarded via `guardian_mail`) and enforces the same
password-null / edit-lockdown / session-timeout rules on them.

```php
function mymodule_guardian_guarded_users(): array {
  $guarded = [];
  $admins = \Drupal::entityTypeManager()->getStorage('user')
    ->loadByProperties(['roles' => 'administrator']);
  foreach ($admins as $uid => $user) {
    $guarded[$uid] = $user->getEmail();
  }
  return $guarded;
}
```

Validation Guardian applies to each returned entry (invalid ones are dropped): the `uid` must be
numeric and **>= 2** (uid 1 is handled separately), and the mail must be non-empty and pass the
email validator. The merged list is cached in a static; call
`\Drupal::service('guardian.manager')->resetGuardedUsers()` if you change the source mid-request
(e.g. in a test).

## `hook_guardian_add_metadata_to_body_alter(array &$body)`
Append extra lines to the body of Guardian's notification / reset mails (which already include
client IP, host name, and — on CLI — the terminal user).

```php
function mymodule_guardian_add_metadata_to_body_alter(array &$body) {
  if (!empty($_SERVER['HTTP_USER_AGENT'])) {
    $body[] = t('User agent: @ua', ['@ua' => $_SERVER['HTTP_USER_AGENT']]);
  }
}
```
