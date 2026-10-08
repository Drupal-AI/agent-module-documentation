<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Block/warn/cancel logic

Service **`block_inactive_users.deactivate_users`** = `InactiveUsersHandler`. Cron and the
settings-form buttons drive it; you can also call it programmatically.

## Cron (`block_inactive_users_cron`)

1. `$handler->warn()` — emails users approaching their block date once (respects
   `block_inactive_users_warn_send_email`), recording warned uids in **state**
   `block_inactive_users.warn`.
2. `block_inactive_users_block_users()` — loads candidate users (`$handler->getUsers()`:
   active, not uid 1, not in `block_inactive_users_exclude_roles`) and, when
   `timestampdiff(last_access, now) >= idle_time` (in **months**), calls
   `$handler->disableInactiveUsersStatus($user, $send_email)` which `$user->block()`s them and
   (optionally) emails a reactivation link.

`hook_user_login` clears a user from the warn state; `hook_user_presave` bumps last-access when
an account is unblocked so it isn't immediately re-blocked.

## Key methods

- `disableInactiveUsersStatus(User $user, bool $sendmail = TRUE)` — block + optional email.
- `timestampdiff($last_access, $current_time)` — interval in **whole months**.
- `getUsers()` — active users eligible for blocking (excludes uid 1 + excluded roles).
- `warn()` — send advance-warning emails, update warn state.
- `cancelUser($uid, $notify, $method)` — wraps core `user_cancel()` with the given method.
- `mailUser($from, $user, $subject, $body, $activation_link)` — token-replaced HTML mail via
  `block_inactive_users_mail` (`hook_mail`, key `block_inactive_users_warn`).

## Reactivation

`disableInactiveUsersStatus` builds a signed URL to route
`block_inactive_users.reactivate_confirm`
(`/reactivate/{user}/confirm/{timestamp}/{hashed_pass}`, controller
`ReactivateUserController::confirmReactivate`) using `user_pass_rehash()`.

```php
$handler = \Drupal::service('block_inactive_users.deactivate_users');
$handler->disableInactiveUsersStatus($user, FALSE); // block a specific user, no email
```
