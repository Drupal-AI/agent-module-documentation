<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Widgets, Views, auto-filenaming, cleanup, analytics & services

## Accessible field widgets

`hook_field_info_alter` sets `accessible_file` as the default widget for **file** fields and
`accessible_image` for **image** fields. Both extend core's generic widgets (schema:
`field.widget.settings.accessible_file` extends `file_generic`; `accessible_image` extends
`image_image`) and share `AccessibleUploadWidgetTrait`
(`src/Plugin/Field/FieldWidget/`). They keep Drupal's managed-file validation, upload processing
and no-JS fallback, and add screen-reader progress announcements, a semantic multiple-file list
(theme `accessible_file_manager_file_widget_multiple`, template
`accessible-file-manager-file-widget-multiple.html.twig`, preprocessed in the `.module`),
keyboard "move up/down" ordering that preserves submitted `_weight`, predictable AJAX focus, and
image `alt` presented as a textarea widened to 2048 chars (`ImageAltSchemaManager` updates field
storage on install and on `field_storage_config_insert`). JS/CSS: `accessible-upload.*`.

## Views handlers (`hook_views_data_alter`)

Added to `file_managed`. **Fields:** `accessible_file_manager_download_count` (FileDownloadCount),
`_physical_status` (FilePhysicalStatus), `_type_label` (FileTypeLabel), `_system_label`
(FileSystemLabel), `_directory_label` (FileDirectoryLabel), `_usage_details` (FileUsageDetails),
`_permission_details` (FilePermissionDetails). **Filters:** `_orphan` (OrphanFileFilter),
`_reference_entity` (FileReferenceEntityFilter), `_reference_field` (FileReferenceFieldFilter),
`_scheme` (FileSchemeFilter). Classes in `src/Plugin/views/field|filter/`. The files/unused pages
reuse the core `files` View at runtime; `hook_form_views_form_files_page_1_alter` keeps the VBO form
action on the module route.

## Automatic filenaming — `AutoFilenameService` + `filename_template`

`FilenameTemplate` config entity (`accessible_file_manager.filename_template.*`) holds a `pattern`,
`separator`, `lowercase`, `separate_inner_capitals`, `max_length`, `status`.
`AutoFilenameService::buildTargetUri()` (`src/AutoFilenameService.php`) expands the module tokens
`[accessible-file-manager:original-name]` and `:timestamp`, then core **token** replacements for
entity/user tokens — `validateTokenContext()` throws `\DomainException` if a template uses an
entity-type token without a matching context entity, and unresolved/empty tokens also throw.
Output is transliterated (`tr`), separator-normalised, lowercased, length-clamped (24–180), and
made collision-free by probing `file_exists` / `loadByUri` with a numeric suffix. `rename()` moves
the file with `FileRepository::move(..., FileExists::Error)` and logs FID/old/new/UID. Applied
automatically on `hook_entity_presave` for temporary files on autofilename-enabled fields, on demand
via `RenameFileForm` (core file operations dropdown, `hook_entity_operation_alter`, perm *rename
managed files*), and in bulk via `BulkApplyFilenameTemplateForm` → `TemplateBulkRenamePlanner` →
`TemplateBulkRenameWorker` queue.

## Orphan / cascade cleanup

Per file/image or media-reference field, editors opt in to `delete_orphan_files` /
`delete_orphan_media` (field-config third-party settings). On entity delete, `CascadeFileCleanup`
(`collect` in `hook_entity_predelete`, `enqueue` in `hook_entity_delete`) queues candidates;
`OrphanFileCleanupWorker` / `OrphanMediaCleanupWorker` re-check with `OrphanFileChecker`,
`EntityReferenceChecker` and core `file.usage` before permanent deletion, so a file that gained a
new reference is preserved. The VBO action `QueueOrphanFileDeletion`
(`accessible_file_manager_delete_orphan_file`) queues unused files selected in the files View.
`CleanupPreviewBuilder` powers the mandatory acknowledgement checkbox added to delete/VBO confirm
forms by `hook_form_alter` (`_accessible_file_manager_add_confirmation` /
`_add_orphan_confirmation`).

## Analytics & download counter

`FileAnalytics` (cached per `analytics_cache_lifetime`) aggregates `DiskQuotaService` (quota vs.
`package_quota_gb`, cached in state), `FileInventorySummary` (physical/managed summary) and
`TemplateBulkRenamePlanner`, rendered by `FileAnalyticsController` (perm *view managed file download
counts*). `DownloadCounter` (`src/DownloadCounter.php`) marks a candidate in `hook_file_download`,
and `DownloadCounterResponseSubscriber` records it into the `file_download_event` content entity
**only after a genuine HTTP 200**, skipping excluded roles/extensions, users with *skip managed file
download counts*, and duplicates inside the dedup window (`DownloadDeduplicator`, cache+lock keyed
by fid/uid/request). All counter queries use parameterised `select()`/`condition()` — no raw SQL.
`getTotals()` feeds the Views download-count field.
