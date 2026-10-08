<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The dda_archive entity, services, events, queue, cron, Drush

## Entity `dda_archive` (`src/Entity/DdaArchive.php`)

`@ContentEntityType(id = "dda_archive")`, extends `EditorialContentEntityBase` (revisionable +
translatable, `show_revision_ui = TRUE`). Tables `dda_archive` / `dda_archive_field_data` /
`dda_archive_revision` / `dda_archive_field_revision`. `admin_permission = "administer dkan dataset
archiver settings"`. Handlers: `view_builder` `DdaArchiveViewBuilder`, `views_data`
`DdaArchiveViewsData`, forms `DdaArchiveForm` / `DdaArchiveDeleteForm` (+ revision revert/delete forms in
`src/Form/`), `route_provider` `DdaArchiveHtmlRouteProvider`, `access`
`DdaArchiveAccessControlHandler`.

Links (all admin): collection `/admin/content/archive`, canonical/edit/delete under
`/admin/content/archive/{dda_archive}`, plus revision `version-history` / `revision` / `revision_revert` /
`revision_delete`.

Key fields (from schema + `ArchiveService` usage): `name` (label), `archive_type`
(`individual`|`theme`|`keyword`|`annual`|`annual_theme`|`annual_keyword`|`current`), `aggregate_of`
(`theme`|`keyword`), `aggregate_on` (the term), `dataset_id` (source dataset identifier),
`dataset_modified`, `access_level`, `themes` / `keywords` (multi-value), `source_archives` (entity
reference to other `dda_archive` for aggregates), `resource_files` (file references — the stored copies),
`remote_url` (link field — S3 URLs set by the submodule), `size`, `status`. Helper methods:
`getArchiveType()`, `isPrivate()`, `getResourceFileItems()`, `getDataset()`, `setSyncing()`,
`setHasRemoteStored()` / `hasRemoteStored()`, `localFilesChanged()`.

## Permissions (`dkan_dataset_archiver.permissions.yml`)

`administer dkan dataset archiver settings`; `view` / `view unpublished` / `edit` for both
`dataset public archive` and `dataset non-public archive`; `add dataset archive`; `delete dataset
archive`; `view dataset archive revisions`; `manage dataset archive revisions`; `access dataset archive
api`. The API controller keys visible access levels off `view dataset public archive` vs `view dataset
non-public archive` (see [../api/rest-api.md](../api/rest-api.md)).

## Services

- `dkan_dataset_archiver.archive_service` → `ArchiveService` (`src/Service/ArchiveService.php`). The core
  engine. Notable methods:
  - `createIndividualArchive(NodeInterface)` — gate via `isArchiveWorthy()` (published, is a `data`
    dataset, not too old, not skip-listed, has distributions), then
    `prepMultiValueFileFieldForStorage()` copies each distribution's file into
    `public://dataset-archives/individual/{dataset_id}/` and creates the `dda_archive`.
  - `addToAggregationQueue()` / `dedupeQueueItem()` — enqueue `archive_aggregation` jobs.
  - `createAggregateArchive()` → `aggregateArchiveFiles()` + `createAggregatedZipFile()` — build a
    `\ZipArchive` with member CSVs + `manifest.json`; wraps it in a `File` entity; create/update the
    aggregate `dda_archive`.
  - `queueReferencingArchiveUpdate()` / `processQueuedReferencingArchiveUpdate()` /
    `updateExistingAggregate()` — cascade rebuilds when a member archive changes/deletes.
  - `queueAnnualArchives()`, `reQueueCurrentArchiving()`, `buildAggregateMetaDataFromAllPublishedDatasets()`.
  - `getMap()` / `getMappedTerm()` (theme/keyword remap), `isBlockedTerm()` / `isBlockedDataset()` /
    `isTooOld()`.
- `dkan_dataset_archiver.util` → `Util` — static helpers: `createArchiveFilePath()`,
  `createArchiveFilename()`, `deduceLocaleFileStream()`, `adjustStorageLocation()`,
  `getAccessLevelsThatAreConsideredPrivate()/Public()`, `getAggregationTag()`, `grabMetadata()`
  (reads the dataset node's `field_json_metadata`).
- `logger.channel.dkan_dataset_archiver`.

## Events (`src/Event/`) and subscriber

The entity dispatches `ArchivePreSaveEvent`, `ArchivePostSaveEvent`, `ArchivePostDeleteEvent`.
`EventSubscriber/Subscriber` subscribes:
- `LifeCycle::EVENT_DATASET_UPDATE` → `createIndividualArchive()` (a DKAN metastore dataset was saved).
- `ArchivePostSaveEvent` → `addArchiveToAggregatorState()` (records pending terms + timestamp in state
  `dkan_dataset_archiver.aggregations`) and `updateExistingArchives()` (cascade + queue current bundles).
- `ArchivePostDeleteEvent` → `updateDeletedArchiveReferences()` (drop the deleted archive from referencing
  aggregates).

## Queue + cron

- Queue `archive_aggregation` — worker `Plugin/QueueWorker/ArchiveAggregation` dispatches each item either
  to `ArchiveService::createAggregateArchive()` or `processQueuedReferencingArchiveUpdate()`.
- `Hook/CoreHooks::cronAggregate()` — after the `aggregation_delay` window elapses, drains the pending
  `aggregations` state into `archive_aggregation` jobs (theme/keyword aggregates + `current` bundles) and
  calls `queueAnnualArchives()`.
- `Hook/CoreHooks::cronAnnualAggregate()` — a safety net that, on Dec 31 after 23:00, queues that year's
  individual + keyword + theme annuals (tracked by state
  `dkan_dataset_archiver.last_annual_archive_created`).

## Drush (`Drush/Commands/DkanDatasetArchiverCommands`)

- `dkan_dataset_archiver:create-annual [year]` (alias `refresh-annual`) — confirm-prompts, then queues
  this/that year's annual archives (respects `archive_years_retained` and the per-type toggles).
- `dkan_dataset_archiver:create-current` (alias `refresh-current`) — `reQueueCurrentArchiving()` for all
  published datasets.
Both only enqueue — you must run `drush cron` to process the queue.

## Extension point

`ArchiveService::addOtherFilesToAggregateArchive()` invokes
`hook_dkan_dataset_archiver_archive_alter(&$data, &$zip)` (documented in
`dkan_dataaset_archiver.api.php` [sic]) so other modules can add files to an aggregate zip before it is
closed.
