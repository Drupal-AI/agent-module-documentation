<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# When Registration Role assigns roles

All of the behaviour is `registration_role_user_presave(UserInterface $user)` in
`registration_role.module`.

```php
$case = \Drupal::config('registration_role.setting')->get('registration_mode');
$assign_roles = FALSE;
$current_user_id = \Drupal::currentUser()->id();

if ($current_user_id == 0 && PHP_SAPI !== 'cli') {
  // Anonymous through the web = genuine self-registration.
  $assign_roles = TRUE;
}
elseif (($current_user_id != 0 || PHP_SAPI === 'cli') && $case == 'admin') {
  // Someone else (or a CLI script) is creating the account.
  $assign_roles = TRUE;
}

if ($user->isNew() && $assign_roles) {
  foreach ($config->get('role_to_select') as $key => $value) {
    if ($value) { $user->addRole($key); }
  }
}
```

## Truth table

| Who is saving | `registration_mode: user` | `registration_mode: admin` |
|---|---|---|
| Anonymous visitor via `/user/register` | **roles granted** | **roles granted** |
| Logged-in admin via `/admin/people/create` | no | **roles granted** |
| Drush / CLI script (`PHP_SAPI === 'cli'`) | no | **roles granted** |
| Any save of an **existing** user | no (`isNew()` is FALSE) | no |

Note the CLI case: under Drush the current user is uid 0 *and* `PHP_SAPI === 'cli'`, so the
first branch is skipped and the second one applies — CLI is treated as "admin creates the
user", not as self-registration. This is the single most surprising behaviour when testing.

## `if ($value)` — the legacy-config guard

Before 2.0 the checkboxes form stored **every** role, with `0` for the unticked ones. If that
config survives, iterating it naively would grant all roles. The truthiness check protects
against it, and `registration_role_update_10001()` rewrites the config with
`array_filter()` and then logs an alert plus a UI warning:

> Review user accounts registered between 2023 July 11 and now for having additional roles
> you did not intend for them to have… users who registered after the 2.0.0 update received
> *all* roles.

If you inherit a site on an old release, run `drush updb` and check
`drush cget registration_role.setting role_to_select` for any `0` values.

Other update hooks: `registration_role_update_8007()` grants `administer registration roles`
to every role that has `administer users`; `registration_role_update_8008()` does the same
`array_filter()` cleanup as 10001 without the warning.

## Extending it

There is no API, no hook and no service. To add conditions, implement your own
`hook_ENTITY_TYPE_presave()` for `user` (or `#[Hook('user_presave')]`) and adjust
`$user->addRole()` / `$user->removeRole()` afterwards — module weight decides ordering.

```php
#[Hook('user_presave')]
public function userPresave(UserInterface $user): void {
  if ($user->isNew() && str_ends_with((string) $user->getEmail(), '@example.edu')) {
    $user->addRole('student');
  }
}
```
