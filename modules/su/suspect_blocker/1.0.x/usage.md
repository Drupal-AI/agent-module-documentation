<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Suspect Blocker auto-bans IPs that scan/probe many URLs quickly.

---

Suspect Blocker blocks IP addresses that attempt to access multiple URLs repeatedly within a short window — detecting scanning/probing behavior (bots, vulnerability scanners) and banning the offending IP via the core Ban module, logging via syslog. It's an automated intrusion-prevention aid.

It builds on core `ban` and `syslog`; tune thresholds to avoid false positives (blocking legitimate crawlers/users behind shared IPs). Supports Drupal 10 and 11.

---

- Block IPs probing many URLs.
- Detect scanning/probing behavior.
- Ban offending IPs via core Ban.
- Log via syslog.
- Aid intrusion prevention.
- Detect bots/scanners.
- Tune thresholds carefully.
- Avoid blocking legitimate crawlers.
- Depend on core `ban` and `syslog`.
- Support Drupal 10 and 11.
- Rate-limit by URL access.
- Auto-ban suspects.
- Harden against scanning
- Configure the window/threshold
- Support security.
- Block bad actors.
- Monitor access patterns.
- Prevent probing
