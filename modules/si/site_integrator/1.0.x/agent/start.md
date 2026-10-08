<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Site Integrator — agent index

**Integrate an external site into Drupal**. Provides permissions. Version **1.0.0-beta2**. Core `^9||^10||^11`.

Integration — if it proxies server-side, treat like a proxy (trusted host, constrain requests — SSRF); if iframe,
mind third-party content; avoid leaking session data when forwarding. No access role beyond permission.
