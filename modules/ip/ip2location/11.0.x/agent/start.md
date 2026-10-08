<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# IP2Location (ip2location) — agent index

**Resolves the visitor IP to geolocation data from a local IP2Location BIN database and caches it in the session for reuse by other modules/themes.**

- **Version:** 11.0.x
- **Core:** ^10 || ^11
- **Library:** requires `ip2location/ip2location-php` (Composer) + an IP2Location BIN file
- **Route:** `ip2location.admin_settings` → `/admin/config/system/ip2location` (perm `administer site configuration`)
- **Service:** `init_subscriber` (KernelEvents::REQUEST) — looks up client IP, stores record as JSON in session key `ip2location`
- **API:** `ip2location_get_records()` returns the decoded geolocation object
- **Config:** `ip2location.settings` → `database_path`, `cache_mode`
- **Security:** Admin config route is permission-gated. BIN path is admin-controlled (config), read from disk by an authenticated admin — not attacker-supplied. No public endpoint exposes lookups; results live only in the requester's own session. Geolocation is derived from Drupal's computed client IP, so trust it only with correct reverse-proxy/trusted-host settings. No TLS/network fetch, no SQL, no user-supplied path injection.

See [api/records.md](api/records.md) and [configure/settings.md](configure/settings.md)