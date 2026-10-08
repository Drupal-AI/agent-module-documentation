<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Reports — routes, menu & tasks

## Install / enable

```bash
drush pm:install advanced_filesystem_reports
drush cr
```

Requires the parent `advanced_filesystem` (its controllers/forms back every route) plus core `file`.
This sub-module contributes only routing + links.

## Routes (`advanced_filesystem_reports.routing.yml`)

All are `_permission: 'administer advanced filesystem'`, `_admin_route: true`. The `_controller` /
`_form` classes live in the **parent** `advanced_filesystem` module.

| Route | Path | Target |
|---|---|---|
| `advanced_filesystem.storage_growth` | `/admin/reports/advanced_filesystem/storage-growth` | `AdvancedFilesystemStorageGrowthController::report` |
| `advanced_filesystem.storage_growth_settings` | `…/storage-growth/settings` | `AdvancedFilesystemStorageGrowthSettingsForm` |
| `advanced_filesystem.storage_growth_clear` | `…/storage-growth/clear` | `AdvancedFilesystemStorageGrowthClearForm` |
| `advanced_filesystem.storage_growth_export` | `…/storage-growth/export/{format}` (`csv|json`) | `AdvancedFilesystemStorageGrowthController::export` |
| `advanced_filesystem.folder_report` | `…/folders` | `AdvancedFilesystemFolderReportController::report` |
| `advanced_filesystem.file_dependency` | `…/file-dependencies` | `AdvancedFilesystemFileDependencyController::search` |
| `advanced_filesystem.file_dependency_detail` | `…/file-dependencies/{fid}` (`\d+`) | `AdvancedFilesystemFileDependencyController::detail` |

## Menu & local tasks

- `advanced_filesystem_reports.links.menu.yml` adds a "Reports" group under
  `advanced_filesystem.admin` with children Folder sizes, Storage growth, File dependencies and a
  Ghost file scan link (`advanced_filesystem.ghost_scan`, defined in the Cleanup sub-module).
- `advanced_filesystem_reports.links.task.yml` adds local tabs for folder sizes, storage growth
  (+ its Settings sub-tab) and file dependencies, based on `advanced_filesystem.folder_report`.

## Operating notes

- Storage Growth relies on periodic snapshots (captured by the parent module, typically on cron);
  the Settings page controls snapshot interval, retention and default granularity, and the Clear
  route empties the snapshot history.
- Folder Size and File Dependency are read-only reports. File Dependency's detail page lists the
  entities referencing a file so an admin can judge whether it is safe to delete.
- To review the report logic itself (queries, output escaping), read the parent
  `advanced_filesystem` controllers named above — they are not part of this sub-module.
