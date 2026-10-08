<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Unique Logs (unique_logs) — agent index
**Logs each distinct message only once per request, suppressing duplicates.**

- **Version:** 2.0.x
- **Core:** ^8 || ^9 || ^10
- **Service:** `unique_logs.logger` (`class Drupal\unique_logs\Logger`, args `@logger.factory`).
- **Routes / permissions:** none.

**Security:** No routes, permissions, config or outbound calls; a pure in-request logging helper. No security findings.
