<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Node Revision Health reports on node revision growth and lets admins clean up old revisions, drop orphaned revision tables, and optimize tables.

---

The module adds an admin reports section under `/admin/reports/node-health` with a list, per-node revision report, explorer, charts (table-size growth, content-type usage), and CSV/table exports, plus maintenance forms for bulk revision cleanup, orphaned `node_r__*` table detection and dropping, table optimize, log management, and a queue processor. A matching set of Drush commands mirrors the UI. Read routes require `view node health reports` (or `administer node health`); every destructive route requires `administer node health` (declared `restrict access: true`), and the per-node delete route additionally enforces a CSRF token.

Raw-SQL operations that cannot use placeholders for identifiers go through a `TableNameValidator` that both enforces a strict `[A-Za-z0-9_]{1,64}` pattern and checks the table actually exists in the current schema; `OrphanRTableService::dropTable()` additionally refuses any name not prefixed `node_r__`. This defense-in-depth means table names interpolated into `OPTIMIZE`/`DROP`/`COUNT(*)` statements are validated against the live schema, closing the usual SQL-injection path for identifier interpolation. Use it to keep revision tables from ballooning on busy editorial sites.

---
- Report how many revisions each node accumulates.
- Chart table-size growth over time.
- Identify content types driving revision-table bloat.
- Bulk-delete old node revisions beyond a chosen minimum.
- Delete a single node's old revisions from the report (CSRF-protected).
- Detect orphaned `node_r__*` revision tables left by removed fields.
- Drop confirmed orphaned revision tables safely.
- Run `OPTIMIZE TABLE` on selected tables to reclaim space.
- Export table sizes to CSV for capacity planning.
- Manage/clean the module's own logs.
- Process cleanup work through a queue for large sites.
- Mirror all actions on the CLI via Drush commands.
- Give read-only reviewers reports without destructive access.
- Restrict destructive maintenance to trusted admins.
- Explore paragraph revision fields for debugging.
- Schedule revision maintenance as part of routine ops.
