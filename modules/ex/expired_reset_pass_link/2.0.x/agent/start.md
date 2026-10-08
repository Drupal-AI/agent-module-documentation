<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Expired Reset Pass Link (expired_reset_pass_link) — agent index

A UI-only helper that adds Drupal core's one-time password-reset link timeout
(`user.settings:password_reset_timeout`) as an editable field on the account
settings form. Package **User**. **Core only** — no contrib/composer deps.
Core requirement `^10 || ^11 || ^12`. License GPL-2.0-or-later. Version 2.0.0.

- **Where the setting appears, what it writes, and how to operate it** →
  [config/settings.md](config/settings.md)

## What it actually is

- Two hook implementations, registered via the OOP hook class
  `Drupal\expired_reset_pass_link\Hook\ExpiredResetPassLinkHooks`
  (`src/Hook/ExpiredResetPassLinkHooks.php`, autowired service in
  `expired_reset_pass_link.services.yml`); `.module` bridges the legacy hook
  names with `#[LegacyHook]`.
- `#[Hook('help')]` `help()` — a one-paragraph help page for
  `help.page.expired_reset_pass_link`.
- `#[Hook('form_user_admin_settings_alter')]` `formUserAdminSettingsAlter()` —
  adds an "Expired Reset Password Link" `details` group with a numeric
  "Password Link Reset Timeout" field to core's `AccountSettingsForm`
  (`user_admin_settings`), and appends the submit handler
  `expired_reset_pass_link_user_admin_settings_submit()` (in `.module`) that
  saves the value to `user.settings:password_reset_timeout`.
- **No** routes, controllers, permissions (`provides_permissions: false`),
  entities, plugins, Drush, cron, config schema or config/install of its own.
  It reads/writes only the core `user.settings` config object. `configure`
  points at the core route `entity.user.admin_form`
  (`/admin/config/people/accounts`).

## Field / config (from source)

- Field `password_reset_timeout`: `#type => number`, `#min => 1`,
  `#max => 31536000` (one year), `#default_value` from
  `user.settings:password_reset_timeout` (fallback 86400).
- Submit handler: if the submitted value is empty it stores `86400`, else the
  submitted integer, into `user.settings:password_reset_timeout` (editable
  config, `->save()`).
- Core consumes this value in its own password-reset flow; this module does not
  generate or validate the reset token itself.
