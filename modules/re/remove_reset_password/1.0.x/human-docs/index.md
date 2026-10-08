# Remove 'Reset your password' — manual setup guide

**Remove 'Reset your password'** (`remove_reset_password`) lets an administrator
hide the *Reset your password* tab on the user login page and, crucially, block the
password-reset page itself for anonymous visitors. It's the module you reach for
when accounts are provisioned centrally or through single sign-on and you don't want
Drupal's built-in self-service password reset to be an available (or reachable)
entry point.

It provides a small settings form with two checkboxes. The first — **remove the
"Reset your password" button** — hides that tab for anonymous users *and* enforces
the hiding server-side: any anonymous request to `/user/password` is denied, so the
page can't be reached just by typing the URL. The second — **remove all local
tabs** — hides every local tab on the login page for a cleaner, single-purpose
login screen, though this one is purely visual and doesn't by itself block the
route.

The module fails closed in a sensible way: the server-side block only ever affects
**anonymous** users on the **password-reset route**, and only when the button is set
to hidden — authenticated users keep their access to password reset, and no other
route is touched. It's fully reversible (just uncheck the boxes), has no
dependencies and no permission of its own; its settings page is gated by core's
*Administer site configuration* permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the two settings and exactly what each
   one hides or blocks.

## Where it lives in the admin menu

The settings form is at **Configuration → People → Remove Reset password**
(`/admin/config/people/reset-password-form-settings`), gated by core's **Administer
site configuration** permission.
