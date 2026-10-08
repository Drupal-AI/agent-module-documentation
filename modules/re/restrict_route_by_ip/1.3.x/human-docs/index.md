# Restrict route by IP — manual setup guide

**Restrict route by IP** (`restrict_route_by_ip`) lets you limit specific Drupal
routes so they only answer requests coming from a set of approved IP addresses.
It is a network layer on top of Drupal's permission system: even if someone has
the right password, a sensitive path such as `/user/login`, `/admin`, a webhook
receiver, or a reports page can be made to respond only from your office range,
your VPN, or a partner's addresses.

You manage the rules as **route restriction** configuration entities in the admin
UI. Each restriction names one or more routes (by route name, by path, by a path
with a `%` wildcard such as `/admin/%/content`, or by a regular expression) and a
set of allowed IPs. IPs can be given as single addresses, a hyphenated range
(`x.x.x.x-x.x.x.x`), a wildcard (`x.x.x.*`), or CIDR notation (`x.x.x.x/24`). You
can preview which routes a rule will affect before saving, and you can disable a
restriction without deleting it.

Two things are worth understanding before you rely on this module. First, a rule
in your **web server or CDN** (nginx, Cloudflare) is the stronger place for IP
restriction — it runs before PHP and cannot be bypassed by an application bug.
Reach for this module when the infrastructure is not under your control, when the
rules must travel with your exported configuration between environments, or when
they must be editable without a deployment. Second, the restriction is only as
correct as the client IP Drupal sees — see the caution in
[Configuration](configuration/index.md) about reverse proxies.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — create and manage route
   restrictions, plus the reverse-proxy and lockout cautions you must read first.

## Where it lives in the admin menu

Once enabled, manage your restrictions at **Configuration → System → Restrict
route by IP** (`/admin/config/system/restrict_route_by_ip`). Access to that page
is gated by the **Administer restrict route by IP** permission, which is marked as
a restricted permission — grant it only to trusted administrators.
