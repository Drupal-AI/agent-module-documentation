# Maintenance Exempt — manual setup guide

**Maintenance Exempt** (`maintenance_exempt`) lets specific visitors keep using
your site while it is in **maintenance mode**, without granting them a role or
the *access site in maintenance mode* permission. You whitelist them by **IP
address** (a single address or a whole CIDR range), by **request path**, or with
a **secret query-string key** — a "magic link" that lets someone through.

Normally Drupal only lets users with the *access site in maintenance mode*
permission past the maintenance splash page. This module adds those extra ways to
get through on top of that permission. It does so by replacing Drupal's core
maintenance-mode service with its own version, which lets a request through when
any of the configured exemptions match.

Typical uses: keeping your office or VPN IP browsing during a deploy, giving a
client a preview link, keeping a health-check or webhook path reachable while the
site is down, or letting a payment-gateway return URL complete during a
maintenance window. Everything is **off until you fill it in** — with empty
settings the module behaves exactly like stock Drupal.

> **A note on the query key:** the secret key is a shared secret carried in the
> URL. Anyone who knows it — including anonymous visitors — can bypass
> maintenance, and once they use it the exemption sticks for their whole session.
> That is the intended feature, not a bug, but treat the key like a password:
> make it hard to guess, rotate it, and use HTTPS so it is not leaked in logs or
> referrers.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — set the exempt IPs, URLs, and query
   key on the core maintenance-mode form.

## Where it lives in the admin menu

There is no separate settings page. The module adds its options to Drupal's core
maintenance-mode form at **Configuration → Development → Maintenance mode**
(`/admin/config/development/maintenance`).

## How to use it

1. Enable the module.
2. Go to **Configuration → Development → Maintenance mode** and fill in whichever
   exemptions you need — exempt IPs, exempt URLs, and/or a query-string key.
3. Turn maintenance mode on. The visitors, paths, or keyed links you listed will
   still get through while everyone else sees the maintenance page.
