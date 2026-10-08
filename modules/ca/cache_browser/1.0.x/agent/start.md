<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cache browser (`cache_browser`) — agent index
**Admin tool to inspect cache bins, view entries by CID, and clear bins.**

- **Version:** 1.0.x  | **Core:** ^10
- **Routes:** `/admin/reports/cache`, `/admin/reports/cache/{bin}`, `/{bin}/cid/{cid}`, `/{bin}/clear`
- **Permission:** `access cache browser` (restrict access: true — "caches may contain private and sensitive information")
- Plugin system for cache bin derivers + backend processors; param converter resolves `{bin}`.

**Security:** all routes gated by a restricted permission; the module itself warns caches may hold sensitive data. No anonymous access. No verified finding.
