# E-Mail Username — manual setup guide

**E-Mail Username** (`email_username`) makes a user's **e-mail address double as
their username**, so people register and sign in with their e-mail instead of picking
a separate username. On the account form the Username field is hidden and disabled
(its description becomes "Username is synchronized with e-mail address"), the E-mail
field becomes required, and whatever the user enters as their e-mail is copied into
the username automatically.

Because Drupal's login form authenticates against the username field — which now
holds the e-mail — users effectively "log in with their e-mail" without any custom
login page. The synchronisation happens in more than one place: on the account form,
on every user save (so programmatic updates and imports are covered too), and, when
you first enable the module, it back‑fills existing users' usernames from their
e-mail addresses.

The module also tightens e-mail validation. Every account e-mail is checked for
RFC compliance using the `egulias/email-validator` library, and — when PHP's `intl`
extension is available — it additionally runs a DNS (MX) check and a spoof/confusable‑
character check, so addresses on non‑mail domains or with deceptive characters are
rejected. Both of those extra checks can be turned off in `settings.php`.

This guide is written for a **human** setting the module up. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the `settings.php` validation toggles
   and exactly what the module changes.

## Where it lives in the admin menu

There is **no admin settings form**. The only configuration lives in `settings.php`
(the DNS and spoof validation toggles). The module's visible effects appear on the
user account create/edit form (the Username field is hidden) and on login.

## How to use it

For most sites, using it is simply: install, enable, done. After that:

- New users register with their e-mail address; the Username field no longer appears.
- Existing users had their usernames back‑filled from their e-mail when you enabled
  the module, so everyone can sign in with their e-mail.
- Login is core's normal login form — nothing to change there.

If you need to relax the extra e-mail validation (for example on an environment
without outbound DNS), set the toggles in `settings.php` — see
[Configuration](configuration/index.md).

> **Heads up:** because the e-mail overwrites the username on every save, any username
> set elsewhere is not preserved — identity is keyed on the e-mail address.
