# Press ESC to Login — manual setup guide

**Press ESC to Login** (`press_esc_to_login`) is a small convenience module: for
**anonymous** visitors, pressing the **Escape** key anywhere on the site navigates
the browser to the login page (`/user`). It is handy on staging sites, during QA,
or wherever you have hidden or unlinked the login page and want a fast keyboard
route back to it without typing the URL.

The mechanism is deliberately simple and safe. On each page request the module
checks whether the current user is anonymous; only then does it attach a tiny
JavaScript handler and pass it the login path (`<base_url>/user`). That script
listens for the Escape key and, when pressed, sends the browser to the login form.
For logged-in users nothing is attached at all, so the shortcut is completely inert
once someone has authenticated. It also works across a multisite because it uses
each site's own base URL.

This is purely a **client-side navigation helper**. It does not change
authentication, permissions, sessions, or routing — it just points the browser at
the standard core login form, where users still sign in normally. It does not
weaken security in any way.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

> **Note:** the login path is hardcoded to `/user`. If you have remapped your login
> URL to something else, the shortcut will not follow it. This module is not covered
> by Drupal's security advisory policy.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — it has no settings and no
permissions. It simply works once enabled, as described below.

## Where it lives in the admin menu

Press ESC to Login adds no admin page and no settings. Enabling the module is the
entire setup.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Log out (or open the site in a private/incognito window so you are anonymous).
3. Press the **Escape** key on any page — the browser navigates to `/user`, the
   login form.

Log back in and the shortcut stops responding, since the handler is only attached
for anonymous visitors.
