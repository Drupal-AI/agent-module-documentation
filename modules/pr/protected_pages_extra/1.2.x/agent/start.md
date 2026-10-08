<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Protected Pages Extra — agent index

**Password-protect any page** (single paths or wildcards). Version **1.2.x**. Core `^11.1`. Depends on core `path_alias`.

Config-entity storage + HTTP middleware (priority 30) enforcement. Per-page or global password, session expiry, flood/brute-force protection with IP allowlist, email notifications, and one-step migration from the legacy `protected_pages` module.

- **Configure protected pages, settings, flood control, email, IP allowlist** → [configure/settings.md](configure/settings.md)
- **Permissions (incl. `bypass protected page access check`)** → [permissions/permissions.md](permissions/permissions.md)
- **Access-checker service + protected_page entity API** → [api/access-checker.md](api/access-checker.md)

No plugin types, no Drush commands, no hooks inviting third-party implementations. Provides config schema and config_translation mapper.
