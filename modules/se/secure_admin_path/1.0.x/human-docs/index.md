# Secure Admin Path — manual setup guide

**Secure Admin Path** (`secure_admin_path`) renames Drupal's well-known `/admin` and
`/user` URL prefixes to a custom string of your choosing — for example `/manage/…`
instead of `/admin/…`. The idea is simple: automated scanners and brute-force bots
hammer the standard `/user/login` and `/admin` locations constantly, so moving those
pages to an address the bots do not know about cuts a lot of that noise and blocks
some opportunistic attacks.

It is important to be clear-eyed about what this buys you. This is **security through
obscurity**, not access control. Renaming the paths *hides* the admin and login area
from bots that guess the defaults, but anyone who learns your custom prefix reaches
exactly the same pages. The real protection for your admin area is still Drupal's
permissions and authentication — strong passwords, flood/rate limiting, and two-factor
authentication. Treat Secure Admin Path as one defense-in-depth layer that reduces
noise, never as the boundary that keeps attackers out.

The module provides its own permission and a small settings form where you pick the
replacement terms for "admin" and "user". Once configured, it rewrites the routing so
the admin and account pages answer at the new prefix. One caveat from the module's own
documentation: if another module stops working after you enable this, it is because
that module uses hard-coded paths instead of route names — that is a limitation of the
other module and is not something Secure Admin Path can fix.

This guide is written for a **human** clicking through the admin UI. If you are an AI
coding agent, read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — choose the replacement terms for the
   `admin` and `user` path prefixes.

## Where it lives in the admin menu

After enabling, its settings form sits at **Configuration → System → Secure Admin
Path** (`/admin/config/system/secure-admin-path`). Remember that once you change the
prefixes, the admin area itself moves — so from then on you reach it (and this
settings form) under your new custom path, not the old `/admin` one.
