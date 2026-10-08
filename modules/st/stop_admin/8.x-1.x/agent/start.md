<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Stop administrator login (stop_admin) — agent index

Lightweight security-hardening module that prevents **user 1** (the superuser) from logging in
through the site's login form, and optionally extends the same block to every user holding the
site's **administrator role**. The intent is to keep the shared superuser account out of
interactive use so people sign in with their own named accounts. Recovery is via Drush
(`drush uli`) or the one-time login link from the password-reset mail.

- Package `Security`. Version **8.x-1.5** (version-dir `8.x-1.x`).
- Core requirement `^8.8 || ^9 || ^10 || ^11`. **No module dependencies**, no libraries.
- Provides: one config form/route, one permission, one config object + schema, one menu link.
  No entities, no plugins, no services, no Drush commands.

## How it works (from source)

- `stop_admin.module` → `stop_admin_form_alter()` reads `stop_admin.settings:disabled`. When the
  block is **not** disabled and the form is `user_login_form` or `user_login_block`, it appends the
  validate callback `_stop_admin_prevent_admin_login` to `$form['#validate']`.
- `_stop_admin_prevent_admin_login()` reads the resolved `uid` from `$form_state->get('uid')`.
  If `uid === 1` it sets a form error. If config `block_admin_role` is on, it loads the role
  flagged `isAdmin()` and, when the logging-in user `hasRole()` that role, sets the same error.
  The error text reuses core's `UserLoginForm::validateFinal()` wording (generic
  "Unrecognized username or password"), so it discloses nothing about the account.

## Configuration & operation

- **Details:** [config/settings.md](config/settings.md) — install/enable, config object + schema,
  the settings form, route, permission, and the `disabled` escape hatch.
- Config object `stop_admin.settings`: `disabled` (bool, off the whole block), `block_admin_role`
  (bool, extend the block to the administrator role). Install defaults: both `false`.
- Settings form `Drupal\stop_admin\Form\StopAdminConfigForm` at
  `/admin/config/people/stop_admin` (menu link under *People*), permission
  `administer stop_admin configuration`.
- `stop_admin.install`: `hook_update_N` `_8001`/`_8002` seed `disabled`/`block_admin_role` = FALSE
  on sites that predate those keys.
