<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring the reset-link timeout

## Install / enable

- `composer require drupal/expired_reset_pass_link` then `drush en expired_reset_pass_link -y`
  (or enable at `/admin/modules`). Requires only Drupal core.
- No install hook, no config/install, no config/schema — nothing is created on
  enable. The module only alters an existing core form.

## What it adds and where

`ExpiredResetPassLinkHooks::formUserAdminSettingsAlter()`
(`src/Hook/ExpiredResetPassLinkHooks.php`) alters core's account settings form
`user_admin_settings` (`\Drupal\user\AccountSettingsForm`), reached at:

- Route: `entity.user.admin_form` → `/admin/config/people/accounts`
- Access: core's own requirement on that route, permission
  **`administer account settings`**. The module adds no route and no permission
  of its own.

It inserts a `details` element `password_timeout_settings` (title *"Expired
Reset Password Link"*, `#open => TRUE`, `#weight => 0`) containing one field:

| Property | Value |
| --- | --- |
| key | `password_reset_timeout` |
| `#type` | `number` |
| `#title` | Password Link Reset Timeout |
| `#min` | `1` |
| `#max` | `31536000` (one year, in seconds) |
| `#default_value` | `user.settings:password_reset_timeout` or `86400` |
| `#description` | timeout in seconds for one-time login links; default 86400 (24h) |

## What it writes

The alter appends `expired_reset_pass_link_user_admin_settings_submit()` (in
`expired_reset_pass_link.module`) to `$form['#submit']`. On save it reads
`$form_state->getValue('password_reset_timeout')`; if empty it substitutes
`86400`, otherwise uses the submitted value, and writes it to the **core**
config object:

```
user.settings:password_reset_timeout = <seconds>
```

via `\Drupal::configFactory()->getEditable('user.settings')->set(...)->save()`.
This is the same key core reads to decide one-time login (password reset) link
validity. Schema for the key lives in **core's** `user.settings` config schema,
not in this module.

## Equivalent without the module

The value can also be set directly in configuration or in `settings.php`:

```
$settings['user.settings']['password_reset_timeout'] = 86400;
```

The module simply provides an admin UI for the same value; it does not change
how core produces or checks the reset token.

## Operating notes

- Set a smaller value (e.g. `1800` for 30 minutes) to shorten the reset window,
  or up to `31536000` (one year) to lengthen it. Empty resets to `86400`.
- The value participates in normal config export/import (`user.settings`).
- Disabling/uninstalling the module leaves the current `password_reset_timeout`
  value in `user.settings`; core continues to honour whatever is stored.
