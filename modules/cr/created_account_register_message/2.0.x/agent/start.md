<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Created Account Register Message (created_account_register_message) — agent index

Alters the **core user registration form** so that registering with an email that already has an
active account shows a friendly message (and, for never-logged-in accounts, sends a password-reset
e-mail) instead of Drupal's "This email is already in use" error. Package `Custom`. Core
`^10.1 || ^11`. License GPL-2.0-or-later. Version **2.0.x** (documented from the 2.0.x development
branch — the `.info.yml` has no `version:` line).

- **The full mechanism, functions, mail, and behavior** → [hooks/registration-message.md](hooks/registration-message.md)

## What it actually is

- A single-file module: `created_account_register_message.module`. **No** `src/`, routes,
  permissions, services, config objects, config schema, plugins, or Drush commands. **No
  dependencies** beyond core's `user` module.
- One `hook_help()` (`created_account_register_message_help`) and one form-alter
  (`created_account_register_message_form_user_register_form_alter`) plus two plain callbacks
  (`carm_node_form_validate`, `carm_node_form_submit`).

## Mechanism (from source)

- The form-alter appends `carm_node_form_validate` to `$form['#validate']` on `user_register_form`.
- `carm_node_form_validate()` runs `\Drupal::entityQuery('user')` filtered by the submitted `mail`
  and `status = 1`. If no match, it returns and normal registration proceeds. If a match is found it
  stashes the uid in a `drupal_static` (`carm_user_nologin` when `getLastLoginTime() == 0`, else
  `carm_user_login`), then calls `$form_state->setSubmitHandlers(['carm_node_form_submit'])` and
  `$form_state->clearErrors()` — this both suppresses the duplicate-email error and prevents a second
  account from being created (the default submit handler no longer runs).
- `carm_node_form_submit()` reads those statics: for a never-logged-in account it fires
  `_user_mail_notify('register_admin_created', User::load($uid))` and adds the "we have e-mailed a
  password reset link" status; for a previously-logged-in account it adds a status containing
  `Link::createFromRoute()` links to `user.login` and `user.pass`.

## Operating it

- Install and enable; nothing else to configure. See
  [hooks/registration-message.md](hooks/registration-message.md) for the exact strings, mail key,
  and edge-case behavior.
