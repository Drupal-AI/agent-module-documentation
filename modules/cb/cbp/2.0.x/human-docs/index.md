# Crowd Bruteforce Protection — manual setup guide

**Crowd Bruteforce Protection** (`cbp`) is a hybrid security suite that defends
your login form against brute-force attacks. Version 2.0.x is a complete rewrite
for Drupal 10 and 11, built around a "local first, cloud second" model:

- **Reactive defense (local).** It decorates Drupal's core flood service so that
  when an attacker hammers your login form, CBP detects it immediately using local
  thresholds and bans the offending IP on your own server — with no added latency.
- **Asynchronous crowd reporting.** Rather than making your visitors wait on an
  API call, threat reports are placed on a queue and sent to a central
  intelligence engine by a background worker. If the crowd confirms an IP is a
  global threat, CBP can proactively ban it before it even reaches your login
  page (depending on your configuration).
- **Vulnerability scanning.** It watches 404 errors intelligently — ignoring
  ordinary internal broken links but flagging suspicious scanning behavior, such
  as bots probing for `wp-login.php` or old exploit paths — and distinguishes a
  real user following a bad link from a bot retrying non-SSL paths.

A **fail-open** design means that if the central API server is unreachable, your
site keeps running and your local protection continues to work 100% of the time.
The heavy lifting runs through queue workers to avoid thread exhaustion during an
attack.

CBP bans offending IPs using Drupal core's **Ban** module, which is its only
dependency. It supports Drupal 9, 10, and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (and its Ban dependency).

## How to use it

CBP begins protecting your login flow as soon as it is enabled. The main thing to
tend to is **thresholds**: tune how many failed attempts trigger a local ban so
that you catch attackers without locking out legitimate users who share an IP
(for example, many people behind a single office or campus NAT). Set thresholds
conservatively at first and tighten them as you observe real traffic.

Because it participates in the crowd intelligence network, enabling CBP also means
threat data from your site is queued and shared with the central engine — the more
sites participate, the more effective the shared blocklist becomes. Review your
organization's data-sharing expectations if that matters to you, and note the
fail-open behavior: an unreachable central server never takes your site down.
