<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration, permissions & enforced enrolment

## Config object — `alogin.config`

Admin form `ConfigForm` (`src/Form/ConfigForm.php`, form id `alogin_config_form`) at
`/admin/config/alogin/config` (route `alogin.config`, `_permission: 'administer alogin'`,
`_admin_route: TRUE`). Menu link `alogin.config` under *Configuration → System*
(`system.admin_config_system`). Install defaults in `config/install/alogin.config.yml`. There is
**no `config/schema/`** for this module, so strict config-schema tooling may flag the object; it
still saves and works.

| Key | Default | Meaning |
|---|---|---|
| `allow_enable_disable` | `0` | If on, users may toggle their own 2FA (checkbox on the settings form). If off, 2FA is **mandatory** and `SettingsForm` stores `enabled = 1`. |
| `redirect` | `0` | If on (and `allow_enable_disable` off), un-enrolled authenticated users are force-redirected to their 2FA setup form. |
| `message_type` | `'status'` | Drupal message type for the redirect notice: `status`, `warning` or `error`. |
| `redirect_message` | `'Please setup 2FA via email.'` | The message shown on the enforced redirect. Required when `allow_enable_disable` is off (`validateForm()`). |

The Redirect Settings fieldset (`redirect`, `message_type`, `redirect_message`) is only relevant
when `allow_enable_disable` is unchecked — `#states` hides it otherwise.

Config export example:

```yaml
# alogin.config.yml
allow_enable_disable: 0
redirect: 1
message_type: 'warning'
redirect_message: 'You must set up two-factor authentication to continue.'
```

## Permissions (`alogin.permissions.yml`)

- `administer alogin` — reach the configuration form.
- `alogin bypass enforced redirect` — exempt an account from the enforced-enrolment redirect
  (checked in `MfaRedirectSubscriber` and `MfaLoginController`).

## Enforced enrolment — `MfaRedirectSubscriber` (`src/EventSubscriber/MfaRedirectSubscriber.php`)

Subscribes to `KernelEvents::REQUEST` (`check2fa`). For an authenticated user it force-redirects to
`alogin.settings` (their `/user/{uid}/2fa`) with the configured message **only when all** of:

- `redirect` is on **and** `allow_enable_disable` is off;
- the user lacks `alogin bypass enforced redirect`;
- the user has no row in `alogin_user_settings` (`authenticator->exists()` is false);
- the current route is not one of the bypass routes: `entity.user.edit_form`, `user.pass`,
  `user.logout`, `alogin.settings`, `system.css_asset`, `system.js_asset`.

This is enrolment enforcement (nagging un-enrolled users to set up), separate from the login-time
code check. It redirects rather than blocks, and applies only to already-authenticated sessions.

## Operating notes

- Make 2FA mandatory: leave `allow_enable_disable` off and turn `redirect` on so users are pushed to
  set it up; grant `alogin bypass enforced redirect` to any service/role that must skip it.
- Let 2FA be optional: turn `allow_enable_disable` on; users see the Enable/Disable checkbox on
  their settings form.
- Recover a locked-out user: `drush mfa-reset {uid}` clears their row so they can re-enrol.
