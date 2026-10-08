<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring the BIN database

Route: `ip2location.admin_settings` → `/admin/config/system/ip2location` (permission `administer site configuration`).

Config object `ip2location.settings`:
- `database_path` (string) — path to the IP2Location BIN file. The field help describes it as relative to the Drupal root (e.g. `sites/default/files/IP2Location-LITE-DB11.BIN`); the runtime opens it directly with `file_exists()`/`\IP2Location\Database`.
- `cache_mode` (string) — one of `no_cache`, `memory_cache`, `shared_memory`.

Setup:
1. `composer require ip2location/ip2location-php`.
2. Download a BIN from lite.ip2location.com (free) or ip2location.com (commercial).
3. Upload it and enter the path; the form validates it with `is_file()` and a test `8.8.8.8` lookup.
4. Pick a cache mode — `memory_cache`/`shared_memory` speed up lookups at the cost of RAM.

Since the path is only writable by users with `administer site configuration`, it is not an attacker-controlled injection surface; treat that permission as trusted.
