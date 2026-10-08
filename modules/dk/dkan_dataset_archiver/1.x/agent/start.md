<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DKAN Dataset Archiver (dkan_dataset_archiver) — agent index

Preserves durable copies of **DKAN dataset** resource files as revisioned `dda_archive` entities, and
builds theme / keyword / annual / "current" zip bundles via cron queues. Package **DKAN**. Version
**1.x**. Core `^10 || ^11`, GPL-2.0-or-later.

Requires DKAN: depends on `dkan`, `dkan_common`, `dkan_metastore`, `dkan_metastore_search`, plus core
`datetime`, `options`, `views`. Composer pulls `league/flysystem` + `league/flysystem-aws-s3-v3`,
`league/commonmark`, `grandt/phpzipmerge`. Optional submodule
[`dkan_dataset_archiver_remote_storage`](../../modules/dkan_dataset_archiver_remote_storage/1.x/agent/start.md)
mirrors archives to AWS S3.

## What it provides

- **Content entity `dda_archive`** (`src/Entity/DdaArchive.php`) — editorial (revisionable, translatable),
  admin collection at `/admin/content/archive`. Access handler
  `DdaArchiveAccessControlHandler`, routes from `DdaArchiveHtmlRouteProvider`, views data
  `DdaArchiveViewsData`. Ships view `views.view.archives`.
- **Service `dkan_dataset_archiver.archive_service`** (`ArchiveService`) — the engine: creates individual
  archives, downloads distribution files, builds aggregate/annual zips + `manifest.json`, queues work.
- **Service `dkan_dataset_archiver.util`** (`Util`) — static helpers for paths, filenames, access-level
  privacy logic, stream deduction, cache tags.
- **Event subscriber `Subscriber`** — reacts to metastore `LifeCycle::EVENT_DATASET_UPDATE` and the
  module's own `ArchivePostSaveEvent` / `ArchivePostDeleteEvent` (defined in `src/Event/`).
- **Queue worker `archive_aggregation`** (`Plugin/QueueWorker/ArchiveAggregation`) — processes aggregation
  and referencing-archive-update jobs on cron.
- **Hooks** (`src/Hook/CoreHooks.php`, attribute-based) — `hook_help` (renders README via CommonMark),
  two `hook_cron` handlers (delayed aggregation + year-end annuals).
- **Read-only JSON API** under `/api/1/archive/…` (`Controller/ArchiveApiController`).
- **Drush commands** (`Drush/Commands/DkanDatasetArchiverCommands`): `dkan_dataset_archiver:create-annual`,
  `dkan_dataset_archiver:create-current`.
- **Config** `dkan_dataset_archiver.settings` + schema; settings form at `/admin/dkan/archiver`.
- **11 permissions** (`*.permissions.yml`), incl. `administer dkan dataset archiver settings` and
  `access dataset archive api`.

## Solution docs

- **Config object, settings form, every key, install/enable** → [config/settings.md](config/settings.md)
- **The `dda_archive` entity, permissions, services, events, queue, cron, Drush, alter hook** →
  [entity/dda-archive.md](entity/dda-archive.md)
- **The `/api/1/archive/…` read JSON API (routes, params, access, caching)** → [api/rest-api.md](api/rest-api.md)
