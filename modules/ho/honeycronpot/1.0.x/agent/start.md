<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Honeycronpot — agent index

Hardens the **Honeypot** module by **rotating the honeypot field name via cron** (moving target defeats bots
that learned the static field name). Depends on `honeypot`. Version **1.0.5**. Core `^10||^11`.

**Positive** anti-spam hardening — complements Honeypot (keep its time-based + honeypot protections). No
access role.
