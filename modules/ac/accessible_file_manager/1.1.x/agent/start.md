<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Accessible File Manager (accessible_file_manager) — agent index

An accessibility-first file management, security, upload and analytics toolkit. It bridges Drupal
**File** entities and the physical **public://** / **private://** stream roots, adding a WAI-ARIA
File Explorer, an enriched files inventory (reusing core's files View), download analytics,
render/download **access rules**, token-based automatic filenaming, guarded orphan cleanup, and
accessible file/image **field widgets**. Package `Media`. Core `^10 || ^11`, PHP `>=8.1`.
License GPL-2.0-or-later. Version 1.1.0.

Dependencies (all required): core **file, field, media, views**, plus contrib
**token** (`^1.0`) and **views_bulk_operations** (`^4.0`).

## Solution docs

- **Settings, config objects & schema, install** → [config/settings.md](config/settings.md)
- **File Explorer: routes, path containment, download/ZIP, explorer upload & unmanaged delete** →
  [explorer/file-explorer.md](explorer/file-explorer.md)
- **Access rules, hook_file_download, render filtering & the private .htaccess guard** →
  [access/access-rules.md](access/access-rules.md)
- **Widgets, Views handlers, auto-filenaming, orphan cleanup, analytics & services** →
  [api/services.md](api/services.md)

## What it actually provides

- **Entities (3):** config entities `filename_template` (`src/Entity/FilenameTemplate.php`,
  config prefix `accessible_file_manager.filename_template.*`, admin perm *administer site
  configuration*) and `file_access_rule` (`src/Entity/FileAccessRule.php`, prefix
  `accessible_file_manager.access_rule.*`, admin perm *administer file access rules*); content
  entity `file_download_event` (`src/Entity/FileDownloadEvent.php`) storing download analytics.
- **Routes** (`accessible_file_manager.routing.yml`): dashboard, files/unused (reused core View),
  analytics, settings + download-counter settings, and the explorer suite (private/public browse,
  `{scheme}/download`, `{scheme}/zip`, public upload, file/physical properties, delete
  unmanaged, delete managed upload, rename, bulk-apply template). Each is gated by a specific
  permission — see the explorer doc.
- **Permissions** (`.permissions.yml`): `access accessible file manager`, `access files overview`,
  `view managed file download counts`, `skip managed file download counts`,
  `upload public explorer files` (restricted), `delete unmanaged physical files` (restricted),
  `rename managed files` (restricted), `administer file access rules` (restricted).
- **Plugins:** field widgets `accessible_file` / `accessible_image`
  (`src/Plugin/Field/FieldWidget/`, set as core file/image field defaults via
  `hook_field_info_alter`); Views field & filter handlers under `src/Plugin/views/`; queue workers
  `OrphanFileCleanupWorker`, `OrphanMediaCleanupWorker`, `TemplateBulkRenameWorker`; action
  `QueueOrphanFileDeletion` (`src/Plugin/Action/`).
- **Services** (`.services.yml`): explorer (`FileExplorer`, `FileExplorerPathResolver`),
  deletion (`UnmanagedFileDeletion`, `ExplorerManagedFileDeletion`), access
  (`FileAccessEvaluator`, `FileEntityReferenceResolver`), analytics (`FileAnalytics`,
  `DiskQuotaService`, `FileInventorySummary`, `DownloadCounter`, `DownloadDeduplicator`), naming
  (`AutoFilenameService`, `TemplateBulkRenamePlanner`), cleanup (`CascadeFileCleanup`,
  `OrphanFileChecker`, `CleanupPreviewBuilder`, `EntityReferenceChecker`), and two event
  subscribers (`PrivateFilesystemGuardSubscriber`, `DownloadCounterResponseSubscriber`).
- **Hooks** (`accessible_file_manager.module`): `field_info_alter`, `field_storage_config_insert`,
  `theme`, `form_*_alter` (field config, VBO confirm, files View form), `entity_presave/predelete/
  delete`, `file_insert`, `views_data_alter`, `file_download`, `entity_view_alter`,
  `entity_operation_alter`, `cron`.
- Config object `accessible_file_manager.settings` + install defaults; config schema in
  `config/schema/accessible_file_manager.schema.yml`. No Drush commands.
