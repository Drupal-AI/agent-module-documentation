# DDoS Security — manual setup guide

**DDoS Security** (`ddos_security`) provides **application-layer** abuse
mitigation for a Drupal site. It watches incoming requests, counts how many arrive
from each client IP address, and blocks IPs that exceed a threshold you configure.
It also gives you an admin screen to view, search, and export the list of blocked
IPs, and shows a configurable block/alert message to visitors who have been
blocked. It depends only on core's **User** module.

Set your expectations correctly before deploying it: **this is app-layer
rate-limiting, not true network or volumetric DDoS protection.** By the time a
request reaches this PHP code, Drupal has already bootstrapped and consumed
server resources, so the module cannot stop a real volumetric flood — that job
belongs to an upstream layer such as a CDN, a WAF, or your hosting provider's
scrubbing service. What DDoS Security *is* good at is throttling and blocking
application-layer abuse from identifiable IPs: aggressive scrapers, brute-force
login floods, and similar misbehaving clients.

Two things are worth getting right. First, the module blocks by **client IP**, so
if your site sits behind a reverse proxy or CDN you must make sure Drupal sees the
**real** client IP (configure trusted proxies and `X-Forwarded-For` handling) —
otherwise you risk blocking the proxy itself, or an attacker could spoof or rotate
IP addresses to evade the block or to frame innocent visitors. Second, its admin
and report routes are correctly gated by the **Administer site configuration**
permission, so the block list isn't publicly disclosed.

This module does need configuration to be useful — you set the request threshold
and the block behaviour after enabling it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — set the rate threshold, the block
   behaviour and message, and manage the blocked-IP list.

## Where it lives in the admin menu

Once enabled, DDoS Security's settings and its blocked-IP management screens live
under **`/admin/config/ddos-security`**, in the **Security** area. Access is
restricted to users with the **Administer site configuration** permission.
