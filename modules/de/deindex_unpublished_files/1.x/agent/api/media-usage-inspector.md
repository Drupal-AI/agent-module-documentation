<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Media usage overview & MediaUsageInspector service

## Service

`deindex_unpublished_files.media_usage_inspector` = `MediaUsageInspector`
(`src/Service/MediaUsageInspector.php`). Constructor args: `entity_type.manager`,
`entity_field.manager`, `entity.repository`, `module_handler`. It finds which media are referenced
by published vs. unpublished content. All internal entity queries use `->accessCheck(FALSE)` (it is a
site-wide audit run from an admin-gated page). It only considers **media bundles that contain a
`file`/`image`/`svg_image` field** (`getMediaBundlesWithFileFields()`).

Two public methods:

- `getMediaUsedOnlyInUnpublishedNodes()` — media referenced only by unpublished content (not by any
  published entity and not by non-publishable "other" entities). Returns
  `[media_id => ['entity' => Media, 'unpublished_nodes' => int[], 'other_entities' => [...]]]`.
- `getMediaUsageOverview()` — the data behind the form. Per candidate media returns
  `published_nodes`, `unpublished_nodes`, `other_entities`, `other_entities_any`.

### How usage is collected

- `getPublishableContentEntityTypes()` classifies every content entity type by its `status`/`published`
  key or `EntityPublishedInterface`.
- `collectPublishedUsage[Detailed]()` / `collectUnpublishedUsage()` load publishable entities in
  chunks of 50 and extract media ids; `collectOtherEntityUsage()` scans non-publishable content
  entity types (excluding `node`, `paragraph`, `paragraphs_item`).
- Content-moderation aware: when `content_moderation` is enabled and storage is revisionable, it
  checks the **latest revision** (`shouldCheckLatestRevision()`, `getLatestRevisionEntity()`,
  `isEntityPublished()` reading `moderation_state`).
- `getMediaIdsFromEntity()` (recursive, cycle-guarded via `getVisitedKey()`) pulls media from: direct
  media entity-reference fields; **CKEditor embeds** in text/text_long/text_with_summary fields (only
  when `ckeditor5`/`ckeditor` is installed) by regex-matching `<drupal-media>`/`<drupal-entity>` tags
  and resolving `data-entity-uuid` via `entity.repository`; **paragraph** reference fields;
  **file/image/svg_image** fields mapped back to media via `buildMediaIdsByFileId()`; and
  `entity_reference_revisions` fields (including revision-pinned paragraph items).

## Overview form

`UnpublishedMediaUsageForm extends FormBase` (`src/Form/UnpublishedMediaUsageForm.php`), form id
`deindex_unpublished_files_unpublished_media_usage`. Route
`/admin/content/deindex-unpublished-files/unpublished-media`, `_permission: administer media`.

- `buildForm()` sets `#cache max-age 0`, attaches library
  `deindex_unpublished_files/unpublished_media_usage` (CSS only), and calls
  `getMediaUsageOverview()`. Filters (via query params, applied by `applyFilters()` redirect):
  `media_type` (select) and `only_unpublished` (checkbox = "Not used on published nodes"). Paged 50
  per page (`pager.manager`). Rows only used by unpublished content get the CSS class
  `deindex-unpublished-only` (highlighted). Node/entity labels are rendered through `Link` (escaped).
- `submitForm()` bulk action "Unpublish selected media": for each checked media that `isPublished()`,
  calls `$media->setUnpublished()->save()` — which in turn fires `MediaHooks::mediaPresave()` and
  relocates the file per the configured mode. Reports a status/warning message.

The form makes no direct file-access or file-move decision itself; it only sets media publish status
(the relocation is a side effect of the media save). Access is limited to holders of `administer
media`.
