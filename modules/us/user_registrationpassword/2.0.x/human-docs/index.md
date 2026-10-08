# User Registration Password — manual setup guide

**User Registration Password** (`user_registrationpassword`) lets visitors choose
their own password right on the registration form, even when your site requires
email verification. Instead of Drupal's default flow — where a new user has to
wait for a one-time login link and only *then* set a password — the module sends a
single activation email that both confirms the address and logs the user in with
the password they already picked.

There is no separate settings page. The module adds its options to core's
**Account settings** form, where you choose one of three verification modes:

- **No verification** (`none`) — no verification email; the user sets a password
  on the form and can log in immediately (low-friction sign-up).
- **Verify first, set password later** (`default`) — the classic core flow.
- **Verify with password on the form** (`with-pass`) — the shipped default: a
  verification email is still required, but the password is set during
  registration, and the module sends its own activation email that confirms the
  account and logs the user in.

Alongside the mode you can control how long the activation link stays valid, where
users go after they confirm, and the wording of the activation email (which
carries a `[user:registrationpassword-url]` token for the one-time confirmation
link). The module also lets users who never logged in re-request their activation
email from the standard password-reset form, and it ships a REST endpoint at
`/user/registerpass` for headless registration.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the registration modes, activation-
   link expiry, redirect, and the activation email, all on the Account settings
   form.

## Where it lives in the admin menu

The module has no page of its own. Its options are added to the core **Account
settings** form at **Configuration → People → Account settings**
(`/admin/config/people/accounts`), which requires the *Administer account
settings* / *Administer site configuration* permission. It works together with
Drupal's own "Who can register accounts?" and "Require email verification"
settings on that same page.
