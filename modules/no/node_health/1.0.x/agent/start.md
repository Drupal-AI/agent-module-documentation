<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Node Revision Health (node_health) — agent index

**Admin reporting + maintenance suite for node revisions and revision tables: reports, charts, exports, bulk revision cleanup, orphaned `node_r__` table drop, table optimize; plus Drush.**

- **Version:** 1.0.x
- **Core:** ^10 || ^11 || ^12
- **Depends:** none
- **Configure:** `/admin/reports/node-health/settings` (route `node_health.settings`).
- **Permissions:** `view node health reports` (read-only), `administer node health` (`restrict access: true`, destructive).

**Surface:** many controllers/forms under `/admin/reports/node-health/*`; services `TableNameValidator`, `OrphanRTableService`; Drush commands under `src/Commands`.

**Security (reviewed — sound):** all destructive routes require `administer node health`; per-node delete adds `_csrf_token`. Identifier interpolation into raw SQL (`OPTIMIZE`/`DROP`/`COUNT(*)`) is guarded by `TableNameValidator` (strict `[A-Za-z0-9_]{1,64}` **and** existence-in-schema check); `dropTable()` also requires a `node_r__` prefix. No injectable path found.
