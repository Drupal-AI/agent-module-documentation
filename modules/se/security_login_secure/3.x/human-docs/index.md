# Security Login Secure — manual setup guide

**Security Login Secure** (`security_login_secure`), by miniOrange, is marketed as an
"enterprise-level" security suite, but its core, genuinely useful feature is
**brute-force protection**: it tracks failed login attempts and blocks the offending
IP address or user account after too many failures. Around that it offers IP blocking
and whitelisting (including country and IP-range blocking), login reporting with CSV
export, a delay-based DoS mitigation, role-login-by-IP restrictions, and risk-based
authentication prompts, plus administrator/user notifications for unusual activity.

The brute-force feature is a legitimate and worthwhile control. As with any IP-ban
mechanism, keep two caveats in mind: on shared IPs (corporate NAT, CGNAT, VPNs) a ban
can catch innocent users, and if your site sits behind a reverse proxy you must make
sure Drupal sees the *real* client IP, or the module will end up blocking the proxy
instead of the attacker.

This guide is written for a **human** clicking through the admin UI. If you are an AI
coding agent, read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the brute-force, IP-blocking, and related
   settings, plus the miniOrange registration.

## How to use it

After enabling, the module adds a **miniOrange Security / Login Security** admin
section where you configure the failed-login thresholds, IP blocking and whitelisting,
reporting, and the other features. Set your brute-force limits there, then test that a
locked-out account and IP behave as you expect.
