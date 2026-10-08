<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Reports (advanced_filesystem_reports) — agent index

Sub-module of **Advanced Filesystem**. Storage-growth chart, folder-size breakdown and file-
dependency graph for managed files. Depends on core `file` and `advanced_filesystem`. Package
`Advanced Filesystem`. Core `^10 || ^11 || ^12`. License GPL-2.0-or-later. Version 1.0.27 (dir 1.0.x).

- **All routes, their controllers/forms and permission** → [config/routes.md](config/routes.md)

## What it actually is

- A **routing-only** sub-module. It ships `*.routing.yml`, `*.links.menu.yml`, `*.links.task.yml`,
  a README and the `.info.yml` — **no `src/`, no config, no permissions, no hooks, no Drush**.
- Every route's `_controller` / `_form` resolves to a class in the **parent `advanced_filesystem`
  namespace** (e.g. `\Drupal\advanced_filesystem\Controller\AdvancedFilesystemStorageGrowthController`),
  so the actual logic is documented with the parent module.
- All routes are under `/admin/reports/advanced_filesystem/*` and gated by
  `_permission: 'administer advanced filesystem'` (the parent's restricted permission) with
  `_admin_route: true`.

## Routes (parent-namespace targets)

- `advanced_filesystem.storage_growth` — `AdvancedFilesystemStorageGrowthController::report`.
- `advanced_filesystem.storage_growth_settings` — `AdvancedFilesystemStorageGrowthSettingsForm`.
- `advanced_filesystem.storage_growth_clear` — `AdvancedFilesystemStorageGrowthClearForm`.
- `advanced_filesystem.storage_growth_export` — `…StorageGrowthController::export` (`{format}: csv|json`).
- `advanced_filesystem.folder_report` — `AdvancedFilesystemFolderReportController::report`.
- `advanced_filesystem.file_dependency` — `AdvancedFilesystemFileDependencyController::search`.
- `advanced_filesystem.file_dependency_detail` — `…FileDependencyController::detail` (`{fid}: \d+`).

## Notes

- The README also mentions content-aware private file access via `hook_file_download`; that hook is
  implemented in the parent module, not here.
- Because this module owns no controllers, its security posture is just "every route is
  admin-permission-gated"; audit the controllers under the parent `advanced_filesystem` project.
