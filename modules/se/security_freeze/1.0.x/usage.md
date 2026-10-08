<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
A read-only security lockdown mode that blocks all login (incl. UID 1).

---

Security Freeze provides a read-only security maintenance mode — when armed (via `drush freeze:on`) it blocks all login including UID 1, redirects logging off the database, and enforces a strict self-only CSP, while the anonymous front end stays live. It's an incident-response tool: freeze a possibly-compromised site into a safe read-only state without taking it offline. Dormant until activated. Supports Drupal 11.3.

---

- Provide a read-only lockdown mode.
- Block all login (incl. UID 1).
- Redirect logging off the database.
- Enforce a strict self-only CSP.
- Keep the anonymous front end live.
- Arm via `drush freeze:on`.
- Stay dormant until activated.
- Support Drupal 11.3.
- Aid incident response.
- Handle the security freeze.
- Lock down safely.
- Freeze the site
- Support Drupal.
- Support Drupal.
- Support Drupal.
