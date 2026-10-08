<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CacheRefs (`cacherefs`) — agent index
**Invalidates cache tags of nodes referenced by a saved node (insert/update/delete).**

- **Version:** 2.0.x  | **Core:** ^8 || ^9 || ^10
- No routes, permissions, or config — install-and-forget.
- Logic in `cacherefs.module`: node insert/update/delete → `cacherefs_clear()` → invalidate `node:<target_id>` for `field_*` entity-reference fields.

**Security:** no routes or user input; internal cache-tag invalidation only. No findings.
