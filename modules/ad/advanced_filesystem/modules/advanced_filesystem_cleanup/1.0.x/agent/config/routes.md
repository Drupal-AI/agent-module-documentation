<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cleanup — routes, menu & tasks

## Install / enable

```bash
drush pm:install advanced_filesystem_cleanup
drush cr
```

Requires the parent `advanced_filesystem` (its controllers/forms back every route) plus core `file`.
This sub-module contributes only routing + links.

## Routes (`advanced_filesystem_cleanup.routing.yml`)

All are `_permission: 'administer advanced filesystem'`, `_admin_route: true`. Target classes live
in the **parent** `advanced_filesystem` module.

| Route | Path | Target |
|---|---|---|
| `advanced_filesystem.orphan_settings` | `/admin/config/media/advanced_filesystem/orphan-settings` | `AdvancedFilesystemOrphanSettingsForm` |
| `advanced_filesystem.bulk_delete_orphans` | `…/advanced_filesystem/bulk-delete-orphans` | `AdvancedFilesystemBulkDeleteOrphansForm` |
| `advanced_filesystem.file_tools` | `…/advanced_filesystem/file-tools` | `AdvancedFilesystemFileToolsForm` |
| `advanced_filesystem.dead_styles` | `/admin/reports/advanced_filesystem/dead-styles` | `AdvancedFilesystemDeadStylesController::report` |
| `advanced_filesystem.dead_styles_flush` | `…/dead-styles/flush-all` | `AdvancedFilesystemFlushDeadStylesForm` |
| `advanced_filesystem.dead_styles_delete` | `…/dead-styles/delete-all` | `AdvancedFilesystemDeleteDeadStylesForm` |
| `advanced_filesystem.dead_styles_flush_one` | `…/dead-styles/{style_name}/flush` | `…DeadStylesController::flushOne` |
| `advanced_filesystem.dead_styles_delete_one` | `…/dead-styles/{style_name}/delete` | `…DeadStylesController::deleteOne` |

`{style_name}` is constrained to `[a-z0-9_]+`.

## Menu & local tasks

- `…links.menu.yml` adds a "Cleanup" group under `advanced_filesystem.config` with children Orphan &
  Retention, Dead image styles, Bulk delete orphans, File tools, and a Private file access link
  (`advanced_filesystem.private_access`, parent module).
- `…links.task.yml` adds local tabs for orphan settings, dead styles, bulk delete, file tools and a
  Ghost files tab (`advanced_filesystem.ghost_scan`, parent module).

## Operating notes

- **Orphans** = permanent `file_managed` rows with no references anywhere. The Orphan Settings form
  controls the minimum age and scheme/extension/path exclusions used to identify them; Bulk Delete
  Orphans runs the deletion as a Batch job respecting those settings.
- **Dead image styles** = derivatives on disk for image styles no longer in configuration. The report
  lists them; flush clears derivatives, delete removes the style/derivatives — per style or in bulk.
- **File Tools** provides the filename sanitiser, directory scanner and broken-reference detector,
  plus a dedup resolver / metadata stripper.
- All of the above execute in the parent `advanced_filesystem` module; audit those classes (query
  construction, path handling, deletion logic) there rather than in this sub-module.
