# Redirect After Logout — manual setup guide

**Redirect After Logout** (`redirect_after_logout`) sends users to a URL you
choose after they log out, and can optionally show them a one‑time message on the
way. By default Drupal drops a logged‑out user back on the front page; this module
lets you send them somewhere more useful instead — a "You've been logged out"
page, a marketing or thank‑you landing page, a feedback survey, an intranet or SSO
login, or even an entirely external site.

You set the destination and message once, as an administrator, on a single
settings form. They then apply to any user who holds the **Redirect user after
logout** permission — so you can target the behaviour to specific roles by
granting (or withholding) that permission. The destination can be the front page,
an internal path, a full external URL, or a token like `[current-page:url]`, and
the module validates it and strips dangerous protocols when you save.

It's careful about a couple of edge cases: the redirect is **skipped during a
Masquerade session**, so unmasquerading still works normally, and the optional
message is shown to the now‑anonymous visitor after the redirect. The only hard
dependency is core's **Filter** module; **Token** and **Masquerade** are
suggested (optional) integrations — Token adds token help on the form and
Masquerade support kicks in automatically if it's present.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and (optionally) add the Token/Masquerade integrations.
2. [Configuration](configuration/index.md) — set the destination, message, and
   message style, and grant the permission that decides who gets redirected.

## Where it lives in the admin menu

The settings form is at **Configuration → User interface → Redirect After
Logout** (`/admin/config/system/redirect_after_logout`) and requires the core
*Administer site configuration* permission. Who actually gets redirected is
controlled separately by the **Redirect user after logout** permission on the
**People → Permissions** page.

## How to use it

Enable the module, open the settings form, enter a destination (and optionally a
message), save, then grant the *Redirect user after logout* permission to the
roles that should be redirected. From then on, when a user in one of those roles
logs out, they land on your destination. The step‑by‑step is in
[Configuration](configuration/index.md).
