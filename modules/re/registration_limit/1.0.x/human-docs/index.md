# Registration Limit — manual setup guide

**Registration Limit** (`registration_limit`) is an anti-abuse layer for user
registration. Whenever someone logs in, the module records the timestamp and the
IP address of that login. Then, when a **new** visitor tries to register, it
checks that visitor's IP against those recorded logins — and if a match is found
within a configured time window, the registration is blocked. In other words, it
discourages someone who already has an account (and recently used it) from
spinning up more accounts from the same connection.

You can **whitelist** specific IP addresses so trusted connections are never
blocked, and the module provides its own permission for administering it. It
targets Drupal 10.3 and 11, and ships an optional submodule,
`registration_limit_user_api`, that integrates the same blocking with the User
API module.

Please read the honest caveat before relying on this: the module keys entirely on
**IP address**, which is an imperfect signal. Many legitimate people share one IP
(offices, schools, homes behind NAT, mobile carriers, corporate VPNs), so a
strict limit can **block real users**. At the same time, a determined abuser can
**rotate IPs** trivially with a VPN, proxy, or botnet to sidestep it. Treat
Registration Limit as one weak, supplementary signal — not a real control — and
combine it with CAPTCHA, email verification, and Drupal's flood control for
meaningful protection.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   optionally enable the User API submodule.
2. [Configuration](configuration/index.md) — set the time window, whitelist
   trusted IPs, and grant the permission.

## How to use it

After enabling, set the time window and any IP whitelist entries on the settings
form (see [Configuration](configuration/index.md)). From then on, the module
records login IPs automatically and blocks matching new registrations within the
window. Nothing else is required day to day.
