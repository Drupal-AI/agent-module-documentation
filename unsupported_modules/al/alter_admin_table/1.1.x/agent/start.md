<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Alter Admin Table (alter_admin_table) — agent index

**Alters admin listing table columns and aids module discovery for site builders.**

- **Version:** 1.1.x (project `ata_st`)
- **Core:** ^9 || ^10
- **Route:** `alter_admin_table.test` → `/alter-admin-table` (`_permission: access content`); controller `HelperController::test` returns a placeholder.
- **Config/permissions:** none of its own.

**Security:** single read-only help route gated by `access content` (effectively public); no mutating endpoints, no external calls, no secrets.
