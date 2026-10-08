# Field Based Login — manual setup guide

**Field Based Login** (`fbl`) lets people sign in with an alternative identifier —
a **unique user account field** you choose (a string, integer, or telephone field),
and/or their **email address** — instead of only their username. A classic example
is a mobile‑number or membership‑number field: give each user a unique value and
they can log in with it. You can keep the normal username login enabled alongside
the alternatives, or require an alternative on its own.

> **Note on the name:** despite the `fb` machine‑name prefix, this is **Field Based
> Login**, not a Facebook login. There is no Facebook integration, no OAuth, and no
> client secret to manage.

This is the **2.3.x** release. Compared with the 2.x line before it, this version
documents and hardens the email‑login path — you can choose whether email login
resolves to the account name or the display name — and it enforces the login
field's **uniqueness in two places**: the settings form refuses a field that already
has duplicate values, and the user register/edit form blocks saving a duplicate. It
also **blocks ambiguous logins**: if an identifier somehow matches more than one
account, login errors out rather than guessing.

The mechanism is deliberately safe. On the login form, a validate handler resolves
whatever the user typed to the matching account's real username, and then **Drupal
core performs the actual password check** against that username — so the credential
check is never weakened (a wrong password still fails, core flood control still
applies), and login failures use a neutral "unrecognized username or password"
message so the form is not an account‑enumeration oracle.

It extends core's User module, provides its own permission, and offers config
translation for the custom login‑field label and description.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — choose the login field, allowed
   methods, email source, and login‑form labels.

## Where it lives in the admin menu

The settings live at **Configuration → People → Field Based Login**
(`/admin/config/people/fbl`, route `fbl.configuration`), gated by the *administer
fbl* permission. See [Configuration](configuration/index.md).
