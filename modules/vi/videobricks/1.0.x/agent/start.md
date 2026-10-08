<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# 42videobricks (videobricks) — agent index
**Integrates the 42videobricks video service as a Drupal media source with an admin upload library.**

- **Version:** 1.0.x
- **Core:** ^10
- **Depends:** media
- **Permission:** `administer 42videobricks` (`restrict access: TRUE`) — gates every route.
- **Routes (all admin):** `/admin/config/videobricks/settings` (API settings), `/library`, `/add`, `/init`, `/finalize`, plus `/admin/content/videobricks`.
- **Media:** source plugin `Videobricks`; field type/widget/formatter; vendor `Api42Vb\Client` SDK.

**Security:** All routes require `administer 42videobricks` (restricted). API calls go to fixed per-environment HTTPS hosts via the SDK/Guzzle (TLS defaults on, no `verify => false`); endpoint host not user-controllable (no SSRF). API key saved in `videobricks.settings`.

See [configure/setup.md](configure/setup.md).
