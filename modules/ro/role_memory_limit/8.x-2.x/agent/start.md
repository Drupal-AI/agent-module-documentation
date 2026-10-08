<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Role Memory Limit (role_memory_limit) — agent index

**Sets PHP memory_limit per request based on the current user's roles.**

- **Version:** 8.x-2.x
- **Core:** ^8.8 || ^9 || ^10
- **Configure:** `/admin/config/system/role-memory-limit` (perm `administer site configuration`)

**Surface:** `RoleMemoryLimit` event subscriber on `KernelEvents::REQUEST` calls `ini_set('memory_limit', ...)` using per-role config; `RoleMemoryLimitForm` config form. Drush include present.

**Security:** limits are admin-configured (`administer site configuration`). No user input reaches `ini_set` beyond stored config values. Take highest role limit; `-1` = unlimited. Low risk.
