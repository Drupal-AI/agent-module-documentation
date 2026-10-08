<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bulk Cancel Users tool

A separate one-off tool that **cancels** (blocks/deletes) many accounts at once by rule — distinct
from the cron auto-block above.

Form `SettingsCancelUsersForm` at route `block_inactive_users.settings_cancel_users`
(`/admin/config/people/block_inactive_users/cancel_users`, permission `administer site
configuration`), with a confirmation step `block_inactive_users.confirm_cancel_users_form`.
Config object: **`block_inactive_users.settings_cancel_users`**.

## Keys

| Key | Type | Meaning |
|---|---|---|
| `block_inactive_users_idle_time` | text (months) | cancel accounts idle at least this many months |
| `block_inactive_users_include_never_accessed` | int (0/1) | also include users who never logged in |
| `block_inactive_users_include_roles` | sequence | only cancel users in these role ids |
| `block_inactive_users_include_status` | sequence | only users with these status values (`'0'`/`'1'`) |
| `block_inactive_users_whitelist_user` | text | newline-separated usernames to never cancel |
| `block_inactive_users_whitelist_email` | text | newline-separated email fragments to never cancel |
| `block_inactive_users_disable_account_method` | string | core cancel method (below) |
| `block_inactive_users_cancel_email` | bool | send the core cancellation confirmation email |

`block_inactive_users_disable_account_method` is a core `user_cancel()` method id:
`user_cancel_block`, `user_cancel_block_unpublish`, `user_cancel_reassign`, or
`user_cancel_delete`.

## Behavior

The **Cancel Users** button counts matching users (`block_inactive_users_block_cancel_users('count')`),
routes to a confirm form, and on confirmation runs `user_cancel()` for each matched user via
`InactiveUsersHandler::cancelUser()`. uid 0/1 and the `administrator` role are excluded; whitelist
username/email rules are applied as NOT-LIKE query conditions.

```php
\Drupal::configFactory()->getEditable('block_inactive_users.settings_cancel_users')
  ->set('block_inactive_users_idle_time', '12')
  ->set('block_inactive_users_disable_account_method', 'user_cancel_block')
  ->save();
```
