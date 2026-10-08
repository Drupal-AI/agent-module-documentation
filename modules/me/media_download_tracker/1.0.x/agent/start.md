<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Media Download Tracker (media_download_tracker) — agent index

Logs every media download made through the **Media Entity Download** route
(`media_entity_download.download`, path `/media/{media}/download`) as one row in its own DB table,
and exposes that table to Views. Package `Media`. Core `^8 || ^9 || ^10 || ^11`. Hard dep:
**media_entity_download**. Version 1.0.x (documented: 1.0.0-beta5).

- **Tracking mechanism, storage schema, Views integration, shipped reports** → [api/tracking-and-views.md](api/tracking-and-views.md)

## What it actually is (all of it)

- One event subscriber `MediaDownloadTrackerSubscriber` (`media_download_tracker.services.yml`,
  service `media_download_tracker.subscriber`) on `KernelEvents::REQUEST` priority 0. It fires on
  the download route only and inserts a log row.
- One DB table `media_download_tracker` (`media_download_tracker.install`, `hook_schema`): columns
  `id` (serial PK), `media_id` (int), `timestamp` (int), `uid` (int), `requested_url` (varchar 255),
  `referrer` (varchar 255, nullable), `ip_address` (varchar 45, nullable).
- `hook_views_data()` (`media_download_tracker.module`) exposes the table as a Views **base table**
  with fields + a `media_id`→`media_field_data` relationship and a `uid`→`users_field_data`
  relationship.
- One install-time view `views.view.media_download_tracker` (`config/install/`) with two page
  displays under Reports: log at `/admin/reports/media-entity-downloads`, aggregated count at
  `/admin/reports/media-entity-downloads/count`. Both restricted to the `administrator` role.

## What it does NOT have

- **No `configure` route, no config form, no settings.** (info.yml declares no `configure`.)
- **No permissions.yml** — it defines no permissions of its own. Report access = the view's access
  (administrator role by default); the download event is gated by media_entity_download's
  `download media` permission + `media.view` entity access.
- **No Drush commands, no config schema, no plugin types, no submodules, no libraries.**
- **No per-entity counter** — it never writes back to the media entity (contrast the separate
  `media_entity_download_count` project). Every download is a discrete log record; counts are
  derived in Views via aggregation.
