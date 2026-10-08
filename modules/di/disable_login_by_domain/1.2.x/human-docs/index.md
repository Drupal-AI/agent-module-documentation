# Disable login by domain — manual setup guide

**Disable login by domain** (`disable_login_by_domain`) turns the login form off on
particular hostnames, so a single Drupal site served under several domains can accept
logins on some of them and refuse logins on others. You list the domains where login
should be blocked, and on those domains Drupal disables the login page, disables the
user-login block, disables the login form itself, and — if a user somehow reaches
authentication another way — stops them from actually getting logged in.

The situation comes up more often than it sounds. One install frequently answers to
more than one hostname: a canonical domain plus a legacy one kept for redirects, a
public marketing domain plus an application domain, or a CDN-fronted public host
alongside its origin that sits behind a VPN for staff. Login usually belongs on
exactly one of those, and leaving it enabled everywhere is avoidable exposure — a
login form on a legacy domain nobody watches is a quiet credential-stuffing target,
and a login form on an origin host that bypasses the CDN also bypasses the CDN's rate
limiting and bot protection. This module lets you close those doors.

Two important cautions. First, **the module's authors are explicit that it is a
convenience, not a hardened security tool.** It decides which domain a request is on
using the `Host` / `X-Forwarded-Host` header, which a determined attacker can try to
spoof; you should set Drupal's **Trusted Host Settings** to make that much harder.
Second, **disabling the login *form* is not the same as disabling *authentication*.**
Check the other ways a session can be created — password reset, any SSO callback,
HTTP basic auth if enabled, and REST or JSON:API session requests — because a login
restriction with gaps is worse than none, since it is trusted.

It depends on core's User module and runs on Drupal 9, 10, and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.
2. [Configuration](configuration/index.md) — list the domains to block, and the
   settings that keep the restriction trustworthy.

## Where it lives in the admin menu

The settings form is at **Configuration → People → Disable login by domain**
(`/admin/config/people/disable-login-by-domain`) and requires the **Administer site
configuration** permission.
