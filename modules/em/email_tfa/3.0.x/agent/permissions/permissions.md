<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions & the per-user field

## Permission

Defined in `email_tfa.permissions.yml`:

| Permission | Gates |
|---|---|
| `administer email tfa` | Access to the settings form `email_tfa.settings` (`/admin/config/people/email-tfa`) — the entire module configuration. |

Grant only to trusted admins (it controls whether/how 2FA is enforced site-wide):

```bash
drush role:perm:add administrator 'administer email tfa'
```

There are no other permissions. The login/verify routes are gated by `_user_is_logged_in: 'FALSE'`
(anonymous only) and, for verify, a `_custom_access` callback, not by a permission.

## Per-user opt-in field (not a permission)

In `optionally_by_users` mode, whether a given user is challenged is controlled not by a permission
but by the boolean base field **`email_tfa_status`** ("Active") that the module adds to the user
entity (`hook_entity_base_field_info`). Users toggle it on their own account edit form; the checkbox
is only shown when `status` is on and `tracks` is `optionally_by_users`. Read/set it like any user
field:

```php
$user->get('email_tfa_status')->value;          // read
$user->set('email_tfa_status', TRUE)->save();    // force-enable for a user
```
