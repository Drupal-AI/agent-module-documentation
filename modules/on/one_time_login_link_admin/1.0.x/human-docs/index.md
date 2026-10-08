# One Time Login Link Admin — manual setup guide

**One Time Login Link Admin** (`one_time_login_link_admin`) brings the equivalent
of Drush's `drush user:login` into the browser. It adds actions to the **People**
screen so an administrator can generate a one‑time login link for any user — or
email that link straight to them — without needing shell access to the server.

This is the tool you reach for when someone cannot log in normally: their
welcome email bounced, their password‑reset mail is not arriving, a domain
migration broke their address, or they are simply locked out and a support agent
needs to restore access from the admin UI. Rather than escalating to a developer
with SSH access, the support person clicks an action next to the user and gets a
working one‑time login link.

The module is deliberately tiny — one controller, two routes, no configuration,
and no dependency beyond Drupal core. It declares **no permission of its own**,
reusing core's **Administer users** permission instead.

**How the links are scoped — worth understanding.** Both actions require the
**Administer users** permission and are triggered from the admin UI. The link
itself is a standard Drupal one‑time login link for the target account, so its
lifetime, single use and expiry are handled by Drupal core exactly as for the
normal password‑reset flow. Note that `administer users` is already an
administrator‑equivalent permission in Drupal — anyone who holds it can already
reset any account's password — so the module introduces no new privilege
boundary; it does mean that whoever can administer users can generate a link that
logs them in *as* another user, so grant the permission only to trusted staff.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module. It adds actions to the
existing People screen and has no settings; usage is described below.

## How to use it

Once enabled, go to **People** (`/admin/people`). Beside each user you will find
the module's actions:

- **Generate** a one‑time login link — Drupal creates the link and displays it at
  the top of the page for you to copy.
- **Email** the login link — Drupal sends the link directly to the user's
  registered email address.

A word on which to choose. The **generate** variant *shows* a working login link
to whoever holds the permission, which effectively grants that person access to
the account — so prefer the **email** variant, which delivers access to the
account owner instead of to the operator. Treat generation as an action to be
used only to *send* access, not to *hold* it, and one worth logging and
justifying. As with any one‑time login link, deliver it over a secure channel and
remember that whoever holds the link can use it until it is consumed or expires.
