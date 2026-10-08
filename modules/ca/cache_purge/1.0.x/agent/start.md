<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cache Purge (`cache_purge`) — agent index
**Truncates database cache tables that exceed a configured size limit, on cron.**

- **Version:** 1.0.x  | **Core:** ^9 || ^10
- **Configure:** `/admin/config/system/cache-purge` (`cache_purge.settings`, perm `administer site configuration`)
- Declares an `administer cache purge` permission (route uses `administer site configuration`).
- Cron: `SHOW TABLES LIKE 'cache%'` → size from `information_schema.TABLES` (table name parameterized) → truncate oversized.

**Security:** admin-gated config; DB size query parameterizes the table name. No user-facing mutation route. No verified finding.
