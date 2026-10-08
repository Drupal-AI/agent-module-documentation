<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# User Expire — mechanics & API

The module is procedural (hooks in `user_expire.module`); there is no public service.

## The `user_expire` table (per-user dates)

`hook_schema` defines table `user_expire`:

| Column | Type | Notes |
|---|---|---|
| `uid` | int (PK) | The user. |
| `expiration` | int | Unix timestamp when the account will be blocked (`0` = none). |

Set/reset a user's date with `user_expire_set_expiration($account, $timestamp)` — passing no
timestamp (or 0) **deletes** the row (resets). It does a DB `merge`, then calls
`user_expire_notify_user()` to flash a message. The value is also surfaced on loaded user
objects as `$account->expiration` via `hook_user_load`.

The user edit form gets a "User expiration" details section
(`user_expire_form_user_form_alter`, shown only with `set user expiration`): a checkbox plus a
`datetime` (date-only) field. On submit the chosen date is normalised to local midnight and
saved into the table. `hook_user_insert` also picks up an expiration set during account
creation.

Direct write (avoids the user edit form):

```php
\Drupal::database()->merge('user_expire')
  ->key('uid', $uid)
  ->fields(['uid' => $uid, 'expiration' => strtotime('2030-12-31 00:00:00')])
  ->execute();
```

## Cron: what actually blocks accounts

`user_expire_cron()` runs, in order:

1. **Per-role warnings** — if `send_expiration_warnings`, `user_expire_expire_by_role_warning()`
   finds users `offset` seconds from expiry and emails them (throttled by `frequency`, using
   State `user_expire_last_run`).
2. **Per-user blocking** — `user_expire_process_per_user_expiration()` selects rows where
   `expiration <= REQUEST_TIME` and blocks those accounts.
3. **Per-role blocking** — `user_expire_expire_by_role()` blocks users whose last access (or
   creation date, if never accessed) is older than the role's inactivity period.

Blocking (`user_expire_expire_users()`): sets the account blocked, saves it, clears the per-user
`user_expire` row, and logs `User %name has expired.` to the `user_expire` logger. Inactivity
is computed in `user_expire_find_users_to_expire_by_role()` over `users_field_data.access` /
`.created`; only `status = 1` (active) non-anonymous users are considered, and the
`authenticated` role skips the `user__roles` join (applies to everyone). Un-blocking a user
refreshes their last-access time (`hook_user_presave`) so cron won't immediately re-block them.

## Warning email (`hook_mail`)

Key `expiration_warning`: subject/body come from `user_expire.settings.expiration_warning_mail`
and are run through the token service (`user` context). Sent via the core mail manager to each
user found by the warning query.

## Views integration (`user_expire.views.inc`)

`hook_views_data` joins `user_expire` to `users_field_data` and exposes `expiration` as a
**date** field / filter / sort ("Expiration date"), so you can build user Views by upcoming
expiration.

## Report

`/admin/reports/expiring-users` (route `expiring_users.admin`,
`UserExpireReport::listOfUsers`, permission `view expiring users report`) lists accounts that
have a pending expiration date.

## Rules action (optional)

`Plugin/RulesAction/UserExpire.php` — `@RulesAction id = "rules_user_expire"`, label "Set a
user expiration date", context `user` (entity:user) + `expiration` (timestamp). Only loadable
when the contrib **Rules** module is installed (it is a dev/test dependency, not required).
