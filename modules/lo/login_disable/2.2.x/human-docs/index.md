# Login Disable — manual setup guide

**Login Disable** (`login_disable`) lets you temporarily stop users from logging
in — for everyone except the roles you exempt — without taking the whole site
offline. Anonymous visitors keep browsing normally; it's authenticated **login**
that is paused. It's built for maintenance windows, soft launches, content
freezes, and locking things down quickly after a security incident.

The real enforcement is deliberately strict: once the feature is active, any
account that logs in but lacks the **Bypass disabled login** permission is
immediately logged straight back out and shown a message. So even someone with
valid credentials cannot get in unless their role is on the allow‑list. User 1
always bypasses. This applies to the login form, the login block, the REST login
endpoint, and one‑time‑login / password‑reset links alike.

On top of that, the module can **hide the login form** behind a secret word added
to the login URL (e.g. `/user/login?yourkey`) and can **force‑log‑out** everyone
else's existing sessions the moment you flip the switch. Bear in mind the module
ships with a *default* access key of `admin` — change it before you rely on it
(see the note in [Configuration](configuration/index.md)).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — activate the block, set the access
   key and message, choose who may bypass, and optionally force logout.

## Where it lives in the admin menu

The settings form is at **Configuration → People → Login Disable**
(`/admin/config/people/login-disable`), and requires the *Administer permissions*
permission. The exempt‑roles setting is the **Bypass disabled login** permission
on the usual *People → Permissions* screen.
