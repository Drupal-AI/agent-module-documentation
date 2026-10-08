<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Administrator Login (administrator_login) — agent index

Restricts the **login** and **password-reset** forms to accounts that hold the
`administrator` role. Intended for admins-only sites (staging/staff). Version **1.0.1**
(version-dir `1.0.x`). Core requirement `^10 || ^11`. License GPL-2.0-or-later. Depends only
on core **`user`**.

- **How the restriction works, the two forms it touches, and how to operate it** →
  [behavior/login-restriction.md](behavior/login-restriction.md)

## What it actually is

- A single procedural `.module` file — **no** routes, controllers, services, event
  subscribers, entities, plugins, permissions, config, install hooks, or Drush commands.
  `administrator_login.info.yml` declares only the core `user` dependency.
- `administrator_login_form_alter()` (`hook_form_alter`) appends a `#validate` handler to two
  core forms:
  - `user_login_form` → `administrator_login_validate()`
  - `user_pass` (password reset) → `administrator_login_reset_validate()`
- Each handler loads the submitted username via
  `entityTypeManager()->getStorage('user')->loadByProperties(['name' => $username])`, and
  returns (allows submission to proceed) only when the loaded account has the `administrator`
  role via `$user->hasRole('administrator')`; otherwise it calls `$form_state->setErrorByName('name', …)`
  to block the form.

## Notes

- The `administrator` role machine name is **hard-coded**; a site without that role would block
  everyone from these forms.
- The module adds a restriction on top of core validation — it never authenticates or elevates
  anyone by itself, and it changes no other behavior.
