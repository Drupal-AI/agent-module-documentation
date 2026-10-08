<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Email Enumeration Prevention (eep) — agent index

Swaps in custom form handlers for the core **user registration** and **password-reset** forms so their
responses no longer differ for existing vs. non-existing accounts, defeating account **enumeration**.
Package `Security`. Depends on core **`user`** and contrib **`token`**. Core `^8 || ^9 || ^10 || ^11`.
License GPL-2.0-or-later. Version 8.x-1.5. No entities, no plugins, no Drush.

- **Config object `eep.settings`, the settings form, permission and menu link** →
  [config/settings.md](config/settings.md)
- **How the two forms are altered and the messages/email normalized (the actual mechanism)** →
  [forms/enumeration-hardening.md](forms/enumeration-hardening.md)

## What it provides (from source)

- **Service** `eep.manager` (`Drupal\eep\EepManager`, implements `EepManagerInterface`): reads the two
  enable flags (`isUserRegisterEnabled()`, `isPasswordResetEnabled()`) and sends the custom
  duplicate-email notification (`sendCustomResetMail()`). Injected with `plugin.manager.mail`,
  `config.factory`, `language_manager`, `token`.
- **Event subscriber** `eep.route_subscriber` (`EventSubscriber\EepRouteSubscriber`): on `RoutingEvents::ALTER`
  (priority -1000) points the `user.pass` route's `_form` at `Drupal\eep\Form\UserPasswordForm` when reset
  protection is on.
- **`hook_entity_type_alter()`** (`eep.module`): replaces the `user` entity's `register` form handler with
  `Form\RegisterForm` and the `reset_password` handler with `Form\UserPasswordForm` per the enable flags.
- **`hook_mail()`** (`eep.module`): defines mail key `eep_reset_password` used by `sendCustomResetMail()`.
- **Route** `eep.settings` → `/admin/config/people/eep`, `_form: Form\SettingsForm`, permission
  `administer eep configuration`. Menu link under `user.admin_index`.
- **Permission** `administer eep configuration` (`eep.permissions.yml`, `restrict access: true`).

## Notes

- Config object **`eep.settings`** ships with **no `config/install` defaults and no `config/schema`**
  (`provides_config_schema` = false); both enable flags default to disabled until saved via the form.
- `src/Controller/EepController.php` extends core `UserController` but is **not referenced by any route**
  (dead code) and refers to a class `Form\UserPasswordResetForm` that does not exist in the module.
