# Field Based Login — manual setup guide

**Field Based Login** (`fbl`) lets people sign in with an alternative identifier —
their email address, or a custom user account field you choose — instead of only
their username. A classic example is a mobile‑number field: give each user a unique
mobile number and they can log in with it as if it were their username. You can
allow the normal username login alongside the alternative, or require the
alternative on its own.

> **Note on the name:** despite the `fb` machine‑name prefix, this is **Field Based
> Login**, not a Facebook login. There is no Facebook integration, no OAuth, and no
> client secret to manage.

The way it works is deliberately safe. On the login form, a validate handler
resolves whatever the user typed to the matching account's real username, and then
**Drupal core performs the actual password check** against that username. So the
credential check is never weakened — a wrong password still fails, and core's flood
control still applies — and login failures use a neutral "unrecognized username or
password" message so the form does not become an account‑enumeration oracle. The
one rule you must uphold is **uniqueness**: the field you allow for login must map
to exactly one account, or logins become ambiguous.

It extends core's User module, provides its own permission, and (optionally) offers
config translation so you can translate the custom login‑field label and
description.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — choose the login field and which login
   methods to allow.

## Where it lives in the admin menu

The settings live at **Configuration → People → Field Based Login**
(`/admin/config/people/fbl`, route `fbl.configuration`), gated by the *administer
fbl* permission. See [Configuration](configuration/index.md).
