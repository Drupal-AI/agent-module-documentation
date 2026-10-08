<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Access code (access_code) — agent index

Alternative authentication for Drupal user accounts: a visitor logs in with a per-user
**access code** instead of username/password. Package **Security**. Depends only on core
**`user`**. Core `^9 || ^10 || ^11`. Version 2.0.5. License GPL-2.0-or-later.

## What it provides

- **Two login entry points** (both require the visitor to be logged out — `_user_is_logged_in: 'FALSE'`):
  - Form `access_code.login` at **`/user/ac`** → `Form\LoginForm` (also usable via the login block).
  - Controller `access_code.auto_login` at **`/ac/{access_code}`** → `Controller\UseCodeController::useCode`
    (auto-login link).
- **Settings** form `access_code.settings` at **`/admin/config/people/access_code`**
  (`Form\SettingsForm`, permission `administer account settings`; menu link under
  *People → …* via `access_code.links.menu.yml`). Writes config object **`access_code.settings`**.
- **Service** `access_code.manager` → `Service\AccessCodeManager` (validate/generate/store codes,
  finalize login). Defined in `access_code.services.yml`.
- **Permissions** (`access_code.permissions.yml`): `change own access code`, `change any access code`
  (plus core `administer users` lets an admin pick an explicit code).
- **Storage**: DB table **`access_code`** (`uid`, `code` varchar(20) primary key, `expiration` int),
  created by `access_code_schema()` in `access_code.install`.
- **User-form integration**: `access_code.module` alters the user register/edit forms
  (`hook_form_..._alter` → `AccessCodeManager::addFormFields`) to manage a user's code, expiration
  and access link. Deletes the row on `hook_user_delete`.
- **Tokens** (`access_code.tokens.inc`): `[user:access-code]`, `[user:access-code-expiration]`.
- **Hook** for integrators: `hook_access_code_login_redirect($user)` may return a `Url` to override
  the post-login redirect.

## Solution docs

- **Login flows, routes, permissions, the AccessCodeManager service API, hooks, tokens & storage** →
  [api/login-and-codes.md](api/login-and-codes.md)
- **Settings form & config keys, install/enable, auto-generation and expiration options** →
  [config/settings.md](config/settings.md)

## Notes

- No config schema is shipped (there is no `config/` directory), even though `SettingsForm` writes
  `access_code.settings`. No submodules, no Drush, no plugin types.
- Access codes are login credentials: successful validation runs core `user_login_finalize()`, giving
  a normal authenticated session. Both entry points use core `UserFloodControl` (`user.flood`).
