<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Symfony Debug (symfony_debug) — agent index

Replaces Drupal's error handler with the **Symfony debug** handler (detailed error pages). Version
**2.0.2**.

**WARNING — DEV ONLY.** Debug error pages show **full stack traces, file paths, code excerpts, and
request/environment context** — a serious **information disclosure** on production (a code/layout map
for an attacker). **Never enable in production;** use dev/staging only, with Drupal's production
error-display (errors hidden) as defence in depth.