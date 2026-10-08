<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# eep — configuration, permission, routing

## Install / enable

`composer require drupal/eep` then `drush en eep`. Dependencies: core `user` and contrib `token`
(both required in `eep.info.yml`). No libraries. After enabling, nothing changes until you turn a
protection on: both flags default to disabled.

## Settings form

`Drupal\eep\Form\SettingsForm` (`getFormId()` = `eep_settings`, extends `ConfigFormBase`).
Route `eep.settings` → path `/admin/config/people/eep`, title "EMail Enumeration Protection",
requirement `_permission: 'administer eep configuration'` (`eep.routing.yml`). Menu link
`eep.settings` sits under `user.admin_index` (`eep.links.menu.yml`). The form shows a
`token_tree_link` element (needs the Token module) for building the custom messages.

## Config object `eep.settings`

`getEditableConfigNames()` returns `['eep.settings']`. Keys written by `SettingsForm::submitForm()`:

| Key | Element | Purpose |
| --- | --- | --- |
| `enable_user_register` | checkbox | Turn on registration-form hardening. |
| `subject_user_register` | textfield | Subject of the email sent when someone registers with an existing email (tokenized). |
| `email_user_register` | textarea | Body of that email (tokenized). |
| `enable_password_reset` | checkbox | Turn on password-reset-form hardening. |
| `message_password_reset` | textarea | Confirmation shown after any password-reset request. |

There is **no `config/install`** file (no shipped defaults) and **no `config/schema`** — the object is
untyped. `EepManager::isUserRegisterEnabled()` / `isPasswordResetEnabled()` treat a missing value as
`FALSE`, so protections are off until the form is saved. Both flags are read from the *editable*
(uncached) config on each request.

## Permission

`administer eep configuration` (`eep.permissions.yml`, `restrict access: true`, title "Administer email
enumeration prevention configuration"). Gates the settings route only. `provides_permissions` = true.
No other permissions; the module adds no access checks to the account forms themselves.

## Effect of the flags

- `enable_user_register` on → `hook_entity_type_alter()` swaps the `user` `register` form handler to
  `Form\RegisterForm`.
- `enable_password_reset` on → `hook_entity_type_alter()` swaps the `reset_password` handler and
  `EepRouteSubscriber` repoints the `user.pass` route form to `Form\UserPasswordForm`.

Changing a flag alters entity handlers/routes, so rebuild caches (`drush cr`) if a change does not take
effect immediately.
