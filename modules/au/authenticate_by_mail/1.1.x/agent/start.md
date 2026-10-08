<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Authenticate by mail (authenticate_by_mail) — agent index

Replaces Drupal's password login with a **passwordless one-time login link mailed to the user**. The user
submits a username/email on the login page and receives a magic link that logs them in. Depends only on core
**`user`**. Core `^10.1 || ^11`, PHP `>=8.1`. Version 1.1.1. License GPL-2.0-or-later. No database schema, no
entities, no Drush.

- **Login flow, routes, controller, mail token, and the `user.auth` / route overrides** →
  [api/login-flow.md](api/login-flow.md)
- **Settings form, config object, schema, flood tuning, and the mail template** →
  [config/settings.md](config/settings.md)

## What it actually is (from source)

- **`LoginForm`** (`src/Form/LoginForm.php`) replaces the `user.login` route form. Field `name` accepts a
  username **or** email; `validateForm()` resolves the account with an entity `OR` query on `mail`/`name`,
  applies IP and per-user flood limits, and on success stashes the user in a temporary value.
  `submitForm()` calls `_authenticate_by_mail_notify()` and always shows a constant "If %name is a valid
  account…" message (no account enumeration).
- **`LoginController::authenticate($uid, $timestamp, $hash)`** (`src/Controller/LoginController.php`) at route
  **`authenticate_by_mail.login`** (`/authenticate-by-mail/{uid}/{timestamp}/{hash}`) validates the link and
  calls `user_login_finalize()`. It always returns a redirect (to `<front>` or `user.login`).
- **Mail** — `authenticate_by_mail_mail()` + helpers `_authenticate_by_mail_notify()`,
  `_authenticate_by_mail_url()`, `_authenticate_by_mail_tokens()` in `authenticate_by_mail.module`. The link
  is built with core `user_pass_rehash($user, $timestamp)` and exposed as the `[user:one-time-login-url]`
  token.
- **`RouteSubscriber`** (`src/Routing/RouteSubscriber.php`, service `authenticate_by_mail.route_subscriber`)
  swaps the `user.login` form to `LoginForm` and **disables `user.pass`** (`_access: 'FALSE'`).
- **`AuthenticateByMailServiceProvider`** + **`FailedAuth`** replace the `user.auth` service with one whose
  `authenticate()` always returns `FALSE`, disabling password authentication site-wide.
- **`SettingsForm`** (`src/Form/SettingsForm.php`) at **`/admin/config/people/authenticate-by-mail`** writes the
  `authenticate_by_mail.settings` config object (timeout, two flood limits, mail subject/body). Config schema in
  `config/schema/`, defaults in `config/install/`, config-translation enabled.

## Token / link mechanism

The link hash is core's `user_pass_rehash()` (HMAC over the account's uuid, hashed password, and last-login +
the timestamp), verified with `hash_equals()`. The controller enforces: link not expired (`timeout`; skipped
for never-logged-in users), timestamp after the account's last login, timestamp not in the future, target
account active and not already logged in. Same well-tested path as core's password-reset link.

## Gotchas

- Removing passwords is **global**: `user.auth` fails for everyone, and `user.pass` is disabled. Incompatible
  with modules that alter or depend on password login (e.g. core HTTP Basic Auth).
- The settings route requires permission `administer authenticate_by_mail settings`, which the module **does not
  define** — only uid 1 can reach the form unless you define/grant it elsewhere (fails closed).
