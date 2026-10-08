# Login Switch — manual setup guide

**Login Switch** (`login_switch`) hides or moves Drupal's standard authentication
pages. Out of the box, every Drupal site puts its login form at `/user/login`, its
registration form at `/user/register`, and its password‑reset form at
`/user/password`. Because those URLs are the same on every Drupal site in the world,
they are the first place automated scanners and credential‑stuffing bots come
knocking. Login Switch lets you move each of those three forms to a path of your own
choosing — or switch it off entirely.

From a single settings form you handle each route independently: leave it alone, move
it to a custom path (for example `secret-login`), or fully disable it so it returns an
access‑denied response. You can also add a `noindex` header to any of the three pages
so search engines keep them out of their results. When login is disabled, the module
goes one step further and returns a plain 404 for `/user` to anonymous visitors,
rather than the usual redirect that would give away that a login page exists.

This is "security through obscurity" — it does not replace real hardening like strong
passwords, rate limiting, or two‑factor authentication, but it meaningfully cuts the
noise from bots that target the well‑known Drupal URLs. The module changes only route
paths, access requirements, and a response header; it never touches Drupal's actual
authentication logic. It has no dependencies beyond Drupal core.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the settings form, field by field, for
   moving, disabling, and de‑indexing each authentication route.

## Where it lives in the admin menu

Once enabled, the module does nothing until you configure it. Its settings form sits
at **Configuration → People → Login Switch**
(`/admin/config/people/login-switch`) and is gated by core's **Administer site
configuration** permission (administrators by default).
