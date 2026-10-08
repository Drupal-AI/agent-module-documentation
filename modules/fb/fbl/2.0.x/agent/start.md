<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field Based Login (fbl) — agent index

Lets users **log in with alternative fields** (a unique custom account field and/or email, instead of the
username). Config at `fbl.configuration` (`/admin/config/people/fbl`, permission `administer fbl`, `restrict
access`); provides config schema + config translation. Depends on core `user`. Package `User`. License
GPL-2.0-or-later. Core `^9 || ^10 || ^11`. Installed copy is a **dev checkout** (no `version:` in
`fbl.info.yml`); documented as the **2.0.x** branch.

## How it works (from source, `fbl.module`)

- `fbl_form_alter` on `user_login_form` prepends `fbl_login_name_validate` to `#validate` and applies the
  configured `label`/`field_desc` to the name field (both `Html::escape`d).
- `fbl_login_name_validate` resolves the entered identifier to the account's **real username**
  (`$form_state->setValue('name', …)`): it queries users by the configured `field` (entity query on
  `{field}.value`), and/or by `user_load_by_name` / `user_load_by_mail` per the enabled options. **Core's
  login authentication then verifies the password** against that username. Lookup failure sets the neutral
  "unrecognized username or password" message; a field match on more than one account is rejected.
- `fbl_user_register_validate` (on `user_form` / `user_register_form`) rejects saving a `field` value that
  already exists on another account, keeping the identifier unique.

## What it provides

- **Route/form**: `fbl.configuration` → `Drupal\fbl\Form\FblConfiguration` (`fbl_configuration_form`), a
  `ConfigFormBase`. → [configure/configure.md](configure/configure.md)
- **Permission**: `administer fbl` (`fbl.permissions.yml`, `restrict access: TRUE`).
- **Config**: `fbl.settings` (schema in `config/schema/fbl.schema.yml`, defaults in
  `config/install/fbl.settings.yml`); all keys nested under `field_based_login`.
- **Config translation**: `fbl.config_translation.yml` exposes `fbl.settings` (translate `label`/`field_desc`).
- **Menu/task links**: `fbl.links.menu.yml` (under `user.admin_index`) and `fbl.links.task.yml`.

## What it does NOT provide

No entities, no controllers, no services beyond the form, no plugin types, no Drush, no external HTTP.
`fbl_uninstall` deletes `fbl.settings`.

## Install / operate

1. `composer require drupal/fbl` and `drush en fbl -y`.
2. Add a unique `string`/`integer`/`telephone` field to the user entity (if using a custom-field login).
3. At `/admin/config/people/fbl` pick the field and the allowed login methods, optionally set label/description.

→ [configure/configure.md](configure/configure.md)
