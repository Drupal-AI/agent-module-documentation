# IP Limiter — manual setup guide

**IP Limiter** (`ip_limiter`) is an application‑level rate limiter: it watches how
many requests come from a single IP address and temporarily **bans** IPs that
cross a threshold you set. It's aimed at blunting automated abuse — bots
hammering a heavy page like search, waves of spam submissions, brute‑force
attempts — on low‑ to medium‑traffic sites where that noise is a real drain.

Rules are built on an extensible **plugin system**, so you can set different
limits for different situations. Three plugins ship built in: **Path** (match by
request path), **Route** (match by Drupal route name), and **User‑Agent** (match
by the User‑Agent header, with blacklist/whitelist strategies and bot‑detection
presets). You can use the same plugin type more than once, add regex matching,
and layer optional conditions per rule (query‑string patterns, referer
requirements, and so on). Each rule has its own request threshold, time window,
ban duration, and response code (403, 404, or 429). Bans escalate automatically
for repeat offenders and decay over time via cron, and you can view and manage
currently banned IPs in the admin UI.

Set expectations honestly: this is **application‑level** protection, not a
firewall. Blocked requests still reach your web server, pass your firewall, and
write logs — so for persistent malicious IPs a real firewall ban is still the
right tool. And because a ban blocks *everyone* behind an IP, be mindful of shared
addresses (see the Configuration page).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — building rules, thresholds, ban
   durations, and the shared‑IP caveats.

## Where it lives in the admin menu

The rules are managed at **Configuration → System → IP Limiter**
(`/admin/config/system/ip-limiter`). See [Configuration](configuration/index.md).
