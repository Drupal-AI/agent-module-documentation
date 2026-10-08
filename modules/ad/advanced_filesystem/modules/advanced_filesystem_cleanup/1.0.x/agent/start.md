<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cleanup (advanced_filesystem_cleanup) — agent index

Sub-module of **Advanced Filesystem**. Orphan management, bulk delete, dead image-style detection,
filename sanitiser and file tools. Depends on core `file` and `advanced_filesystem`. Package
`Advanced Filesystem`. Core `^10 || ^11 || ^12`. License GPL-2.0-or-later. Version 1.0.27 (dir 1.0.x).

- **All routes, their controllers/forms and permission** → [config/routes.md](config/routes.md)

## What it actually is

- A **routing-only** sub-module: `*.routing.yml`, `*.links.menu.yml`, `*.links.task.yml`, README,
  `.info.yml`. **No `src/`, no config, no permissions, no hooks, no Drush.**
- Every `_controller` / `_form` resolves to a class in the **parent `advanced_filesystem`
  namespace**, so the logic (and any security review of the queries/deletes) belongs to the parent.
- All routes are gated by `_permission: 'administer advanced filesystem'` (parent restricted
  permission), `_admin_route: true`.

## Routes (parent-namespace targets)

- `advanced_filesystem.orphan_settings` — `AdvancedFilesystemOrphanSettingsForm`
  (`/admin/config/media/advanced_filesystem/orphan-settings`).
- `advanced_filesystem.bulk_delete_orphans` — `AdvancedFilesystemBulkDeleteOrphansForm`
  (`…/bulk-delete-orphans`).
- `advanced_filesystem.file_tools` — `AdvancedFilesystemFileToolsForm` (`…/file-tools`).
- `advanced_filesystem.dead_styles` — `AdvancedFilesystemDeadStylesController::report`
  (`/admin/reports/advanced_filesystem/dead-styles`).
- `advanced_filesystem.dead_styles_flush` / `…_delete` — flush-all / delete-all confirm forms.
- `advanced_filesystem.dead_styles_flush_one` / `…_delete_one` — `…DeadStylesController::flushOne` /
  `::deleteOne` (`{style_name}: [a-z0-9_]+`).

## Notes

- Destructive operations (bulk orphan delete, dead-style flush/delete) are admin-permission-gated;
  the flush/delete-one routes are controller GET handlers whose `{style_name}` is regex-constrained
  to `[a-z0-9_]+`. The delete/flush logic itself lives in the parent module — review it there.
- The menu group also references `advanced_filesystem.ghost_scan` and
  `advanced_filesystem.private_access`, both defined in the parent module.
