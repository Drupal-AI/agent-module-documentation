<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform JavaScript Setting Element — agent index

**Provides a webform element that pulls a JavaScript settings property into a hidden field**. Depends on `webform`.
Version **1.0.0-alpha5**. Core `^9.4||^10||^11`.

Webform/developer — the value is **populated client-side into a hidden field = fully attacker-controllable**;
**never trust it for security decisions** server-side (re-derive anything security-relevant). No access role.
