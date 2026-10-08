<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Unified Share Button (unishare) — agent index

**Block with a floating share button: native Web Share API where available, sharing-links dialog otherwise.**

- **Version:** 1.0.x (info.yml: 1.0.0)
- **Core:** `^9.3 || ^10 || ^11`
- **Provides:** block plugin `unishare` (`UnifiedShareButtonBlock`); theme hook `unishare_button`; library `unishare/button` (deps `core/drupal`, `core/drupal.dialog`).
- **Build:** shares the current request URI + resolved page title + site name; cached per `url.path`.
- **Setup:** place the "Unified Share Button" block in a region; no config form or permission.
- **Security:** The shared URL is the current page URI derived server-side from the request stack — not attacker-supplied, so no open-redirect/SSRF vector. No routes, no data writes, no external server calls (sharing is client-side). No security-relevant surface.
