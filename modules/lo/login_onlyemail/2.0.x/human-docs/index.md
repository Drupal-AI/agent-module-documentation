# Login with email only — manual setup guide

**Login with email only** (`login_onlyemail`) removes the username as a login
option. Drupal's standard login box accepts "username or email"; this module
narrows it to **email address only** — the single identifier field is labelled and
validated as an email, and that address is resolved to an account. It also changes
the *"Forgot your password"* flow to match: password recovery asks for the email
address too.

It is one of the smallest useful modules you'll install — essentially a single
`.module` file that alters the login and password‑reset forms. That simplicity is
the whole appeal: there is nothing to configure, and enabling it is the entire
setup. The trade‑off is that the change is **site‑wide and unconditional** — there
is no per‑role or per‑path exemption. A site that still wants usernames to work at
login needs a different module (for example **Login Email or Username** or **Mail
Login**, which accept either identifier).

One clarification worth making: this module changes the **login form only**.
Usernames still exist and are still shown wherever Drupal displays an account name
— it does not turn the email address into the account's display name. Because it
only alters the login form, uninstalling it restores the stock login form, so it's
cheap to trial.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module. That's the whole setup.

There is **no configuration page** — the module has no settings, permissions, or
schema.

## How to use it

Simply enable the module. From that point on, the login form accepts only an email
address, and the password‑reset form asks for the email address as well.

A few things to plan for:

- **Usernames still exist.** Consider pairing this with automatic username
  generation on registration, so users never have to think about a username they
  can't log in with anyway.
- **Compatibility.** Other authentication modules that also alter the login form —
  such as LoginToboggan or Email Registration — may be incompatible with this one.
- **Automated tests.** If you run core integration tests that use the
  `drupalLogin()` method, disable this module for those test runs, since it changes
  the identifier the login form expects.
