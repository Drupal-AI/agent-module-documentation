# No Request New Password — manual setup guide

**No Request New Password** (`noreqnewpass`) removes Drupal's **"Request new password"**
(forgotten‑password) flow from your site. When it's switched on, end users can no longer
trigger a password‑reset email: the `/user/password` page returns access‑denied, the "Reset
your password" link disappears from under the login form and from the user login block, and
the REST/HTTP reset endpoint is blocked too. Login itself still works exactly as before, and
core's flood protection (IP and per‑user login throttling) is preserved — the module simply
strips out the self‑service recovery path and shows the standard generic "Unrecognized
username or password." error without steering people toward a reset link.

This is handy on closed or invite‑only sites, sites where accounts come from SSO/LDAP and
local resets shouldn't exist, environments with no reliable outbound email, kiosks and shared
terminals, or anywhere policy requires password changes to go through an administrator or
helpdesk rather than self‑service.

The whole module is driven by a **single checkbox**. Enabling the module does nothing on its
own — you turn the behavior on from its settings form. When the checkbox is off, the module is
completely inert and Drupal behaves normally. It has **no dependencies** beyond Drupal core
(10.3 or 11) and adds one permission that controls who may toggle the setting.

This guide is written for a **human** configuring the module in the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the module.
2. [Configuration](configuration/index.md) — flip the single "Disable Request new password
   link" setting and grant the permission that guards it.

## Where it lives in the admin menu

The settings form is at **Configuration → People → No Request New Password**
(`/admin/config/people/noreqnewpass`) — the module's `configure` link, also listed under the
People admin index. Its permission, *Administer No Request New Password*, is set at
**People → Permissions**.
