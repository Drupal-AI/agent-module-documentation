# Disable User 1 — manual setup guide

**Disable User 1** (`disable_user_1`) blocks the account with user ID 1 — Drupal's
implicit superuser — as a security-hardening measure. User 1 is a special case in
Drupal: it isn't a role or a permission set but a hard-coded exception, so
`hasPermission()` returns TRUE for it no matter what the permissions page says. That
makes it the single most powerful account on any site, and often the least governed —
typically created during installation with a password chosen in a hurry, shared
around during the build, and never audited afterwards.

A hardened site wants that account unusable, with real administrators instead holding
an **administrator role** whose permissions are visible and reviewable. This module
does exactly that: when it is enabled and switched on, user 1 is logged out on any
page it tries to access, so the site can no longer be operated through the
permission-bypassing superuser account.

There is an important safety switch built in. The module only takes effect when you
**explicitly turn it on in `settings.php`** — enabling the module alone does nothing
until you add the flag. That two-step design is deliberate, so you don't accidentally
lock the account before you're ready.

Two things to establish **before** you switch it on:

1. **A genuine administrator account exists and works** — one with an administrator
   role, not user 1. If you disable user 1 without a working replacement, nobody can
   administer the site.
2. **You know the recovery path.** Drush's user commands and `drush uli --uid=1`
   operate below the level this module intercepts, so command-line access remains your
   way back in. That is also the argument *for* the module: it moves superuser access
   from a password anyone might leak to server-level (Drush) access.

It needs nothing but Drupal core and runs on Drupal 10 and 11. Note that recent
Drupal core has been moving away from the special-case treatment of user 1 on its
own; check whether your core version already restricts it before adding this module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and turn
   it on in `settings.php`.

There is **no configuration page** for this module — it has no settings form. It is
controlled entirely by a single line in `settings.php`, described below.

## How to use it

After installing and enabling the module (see [Installation](installation/index.md)),
and after confirming a real administrator account works, switch the module on by
adding this line to your site's `settings.php`:

```php
$config['disable_user_1.settings']['disable_user_1'] = TRUE;
```

From that point on, user 1 is logged out whenever it accesses any page. To re-enable
the account, set the value to `FALSE` (or remove the line). Because the switch lives
in `settings.php`, you can keep it on in production while leaving it off in local or
staging environments.
