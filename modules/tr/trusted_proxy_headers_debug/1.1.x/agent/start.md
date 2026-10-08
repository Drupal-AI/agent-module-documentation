<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Trusted Proxy Headers Debug (trusted_proxy_headers_debug) — agent index

Diagnostic showing how Drupal interprets **reverse-proxy headers**, for setting up/verifying
`reverse_proxy` trusted-header config. Version **dev-1.1.x**. Core `>=8`.
Report at `/admin/reports/status/trusted_proxy_headers_debug`.

**Why it matters:** don't-trust → every request looks like the proxy IP (breaks flood control, IP
access, logging); over-trust → clients spoof `X-Forwarded-For` and defeat those controls. Settings
live in `settings.php` and are invisible until something misbehaves.

**Setup/verification tool — enable while configuring proxy trust, then disable.** The page reveals
header interpretation (useful to an attacker probing for spoofability) — **confirm its route access
is admin-only** before exposing on a shared environment.