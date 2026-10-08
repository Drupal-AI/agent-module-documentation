<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Force Password Change — service API

Service id: **`force_password_change.service`**
(class `Drupal\force_password_change\Service\ForcePasswordChangeService`,
interface `ForcePasswordChangeServiceInterface`). Backed by
`force_password_change.mapper` (`@database`) and core `user.data`, `config.factory`, `datetime.time`.

## Force a change from code

```php
$svc = \Drupal::service('force_password_change.service');

// Force specific users (empty array = ALL active users):
$svc->forceUsersPasswordChange([$uid1, $uid2]);

// Force one user (does NOT also register the force time):
$svc->forceUserPasswordChange($uid);

// Register the timestamp of a force (last_force):
$svc->registerForcePasswordTime($uid);

// Clear a pending force for a user:
$svc->removePendingForce($uid);

// Record that a user just changed their password (last_change):
$svc->setChangedTimeForUser($uid);
```

`forceUsersPasswordChange()` calls `forceUserPasswordChange()` **and**
`registerForcePasswordTime()` per uid, so it both flags and timestamps.

## How a pending force is stored and detected

`forceUserPasswordChange($uid)` does exactly:
```php
\Drupal::service('user.data')->set('force_password_change', $uid, 'pending_force', 1);
```
So to check whether a user has a pending forced change:
```php
$pending = \Drupal::service('user.data')->get('force_password_change', $uid, 'pending_force'); // 1 or NULL
```
`checkForForce()` returns a redirect reason for the **current** user: `'admin_forced'` if
`pending_force` is set, or `'expired'` if `expire_password` is on and the user's password is older
than the highest-priority role expiry (it also then sets `pending_force`). Returns FALSE otherwise.

## Other useful methods

- `getUserCountForRole($rid)`, `getPendingUsersForRole($rid, $countQuery=FALSE)`,
  `getNonPendingUsersForRole($rid)`, `getUsersForRole($rid, $uidOnly=FALSE)`.
- `getRoleExpiryTimePeriods()`, `insertExpiryForRoles($values)`,
  `updateExpiryForRole($rid, $seconds, $weight)`, `getLastChangeForRole($rid)`,
  `updateLastChangeForRoles($rids)`.
- First-login list (`force_password_change_uids` table): `addFirstTimeLogin($uid)`,
  `removeFirstTimeLogin($uid)`, `getFirstTimeLoginUids()`.
- `getTextDate($seconds)` → human-friendly "years/weeks/days/hours" string.

## Enforcement plumbing (no code needed, for context)

- `check_login_only = false`: an event subscriber + `force_password_change.on_only_login`
  HTTP middleware check `checkForForce()` on every request and redirect to the user edit form.
- `check_login_only = true`: `hook_user_login()` performs the check once at login.
- `hook_user_insert()` flags new users when `first_time_login_password_change` is on;
  `hook_user_delete()` clears their `force_password_change_uids` rows.
