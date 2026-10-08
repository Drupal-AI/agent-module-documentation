<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings, config & install — accessible_file_manager

## Install / enable

`composer require drupal/accessible_file_manager` then enable it (pulls in core file/field/media/
views and contrib token + views_bulk_operations). `hook_install` (`.install`) calls
`ImageAltSchemaManager::updateAll()` to widen image alt storage to 2048 chars and grants the new
`access accessible file manager` permission to any role that already holds one of the five
file-manager permissions (`_accessible_file_manager_grant_dashboard_permission`).
`update_11001` re-runs both steps for upgrades. Uninstalling removes the config entities and the
settings object; the `file_download_event` content-entity table is dropped with the module.

## Admin surface

Dashboard menu items (`.links.menu.yml`) sit under **Content → Accessible File Manager**
(route `accessible_file_manager.dashboard`, perm *access accessible file manager*), with children
Files, Analytics, File Explorer and File Settings. Two settings forms live under
**Configuration → Media**:

- `FileManagerSettingsForm` — route `accessible_file_manager.settings`
  (`/admin/config/media/accessible-file-manager`), perm **administer site configuration**. This is
  the module's `configure` route.
- `DownloadCounterSettingsForm` — route `accessible_file_manager.settings.download_counter`,
  same permission.

Config entity collections (config-entity forms, `src/Form/FilenameTemplateForm.php`,
`src/Form/FileAccessRuleForm.php`) are at
`/admin/config/media/accessible-file-manager/filename-templates` and `/access-rules`.

## Config object `accessible_file_manager.settings`

Install defaults (`config/install/accessible_file_manager.settings.yml`); schema is a
`config_object` in `config/schema/accessible_file_manager.schema.yml`. Keys:

| Key | Default | Meaning |
| --- | --- | --- |
| `package_quota_gb` | 100 | Hosting-package quota (GB) shown on analytics. |
| `download_counter_enabled` | true | Master switch for the local download counter. |
| `download_counter_excluded_extensions` | `jpg jpeg gif png` | Space-separated extensions never counted. |
| `download_counter_deduplication_window` | 30 | Seconds within which repeat downloads are one count. |
| `download_counter_excluded_roles` | `content_editor`, `administrator` | Roles whose downloads are not counted. |
| `analytics_cache_lifetime` | 43200 | Analytics cache TTL (seconds). |
| `analytics_top_download_limit` | 10 | Rows in the "top downloads" list. |
| `explorer_page_size` | 100 | Explorer entries per page (clamped 10–500 in `FileExplorer::getPageSize`). |
| `explorer_zip_max_files` | 1000 | Max files in a ZIP (clamped 1–10000). |
| `explorer_zip_max_megabytes` | 512 | Max total ZIP bytes. |
| `explorer_zip_max_depth` | 20 | Max folder recursion depth for ZIP (clamped 1–100). |
| `explorer_upload_extensions` | `pdf doc docx … webp svg mp4 webm zip exe` | Allowlist for explorer uploads. |
| `explorer_upload_max_megabytes` | 100 | Per-file explorer upload size cap. |
| `orphan_batch_size` | 50 | Orphan-cleanup batch size. |

The ZIP and upload limits are re-clamped at runtime in `FileExplorer::createZip` /
`addDirectoryToZip` and `PublicExplorerUploadForm`, so config edits cannot exceed the hard caps.

## Config schema for the config entities

- `accessible_file_manager.filename_template.*` — `id`, `label`, `pattern`, `separator`,
  `lowercase`, `separate_inner_capitals`, `max_length`, `status`. Consumed by
  `AutoFilenameService` (see api/services.md).
- `accessible_file_manager.access_rule.*` — `id`, `label`, `status`, `weight`, `scope`
  (`path`|reference), `scheme`, `path_pattern`, `entity_type`, `bundle`, `field_name`,
  `grant_roles`, `deny_roles`, `grant_users`, `deny_users`, `owner_policy`, `valid_from`,
  `valid_until`, `duration_seconds`. Consumed by `FileAccessEvaluator` (see access/access-rules.md).
- `field.field.*.*.*.third_party.accessible_file_manager` — per-field policy:
  `delete_orphan_files`, `delete_orphan_media`, `autofilename_enabled`, `autofilename_template`.
  Set via the field-config edit form (`hook_form_field_config_edit_form_alter`).
