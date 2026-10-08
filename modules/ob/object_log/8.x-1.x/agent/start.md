<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Object Log (object_log) — agent index

**Devel companion: store arbitrary variable contents by label and inspect them later at an admin report page.**

- **Version:** 8.x-1.x
- **Core:** ^8 || ^9 || ^10
- **Depends:** devel
- **Routes:** `/admin/reports/object_log` (list), `/admin/reports/object_log/{label}` (detail) — both `access devel information`.

**Surface:** logging helper writing to the `object_log` table; `ObjectLogController` (list/detail); clear-log form.

**Security:** entries are written only by developer code (no web write path); both report routes require the developer-only `access devel information`. Detail view `unserialize()`s stored blobs — a debug-tool pattern, not attacker-reachable since the table isn't web-writable. Keep disabled on production (as with Devel).
