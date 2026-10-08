# BotShield — manual setup guide

**BotShield** (`botshield`) is an application-layer bot defense for Drupal 10.3+
and 11. It classifies incoming traffic as good bots or bad bots, rate-limits and
blocks abusive requests, enriches requests with geographic data, and reports on
what it has seen. The goal is to cut down scraping, abuse, and attack traffic
that reaches your site.

It is important to set expectations correctly, and BotShield's own documentation
is honest about this: because it runs inside Drupal, it acts only once a request
has already reached the application. That means it can mitigate application-layer
bot abuse, but it cannot stop a true network-level or volumetric flood — for that
you still want a CDN or WAF in front of the site. It identifies and blocks by
**client IP** (and geography), so two caveats apply: behind a reverse proxy you
must make sure Drupal sees the real client IP (trusted-proxy configuration), and
an attacker who rotates IP addresses can evade IP-based blocking.

BotShield is a security-positive feature — it mitigates bots, it does not grant
or restrict content access. It provides its own permissions but has no
access-control role beyond them.

This guide is written for a **human** configuring the module through the admin
UI. If you want a terse, token-cheap reference for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — requirements, installing with
   Composer, and enabling the module.
2. [Configuration](configuration/index.md) — the settings form where you tune
   classification, rate limits, and blocking.

## Where it lives in the admin menu

BotShield's settings form is at the `botshield.settings` route (under
Configuration). Access is controlled by the permissions the module provides —
grant them only to trusted administrators.

## How to use it

Enable the module, then open its settings form and configure three things: how
traffic is **classified** (good bots vs bad bots), the **rate limits** you want
to enforce, and what **blocking** should happen when a limit is exceeded. Review
the reporting to see which bots are being caught and adjust the thresholds. If
your site sits behind a proxy or CDN, confirm your trusted-proxy settings first
so the IP-based rules see real visitor addresses rather than the proxy's.
