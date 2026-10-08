<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Advertisement track (ad_track) — agent index

The native **statistics tracker** submodule of the `ad` project: counts impressions and clicks
locally, either immediately or via a cron queue. Package `Advertisement`. Core `^11`. Depends only
on **`ad`**. License GPL-2.0-or-later. Release 11.0.0-alpha12.

- **The two trackers, totals storage, the event entity, click route, settings, Views** →
  [trackers/local.md](trackers/local.md)

## What it provides (from source)

- **Tracker plugins** (`Plugin/Ad/Track`): `LocalTracker` (id `local`, immediate) and
  `DelayedLocalTracker` (id `delayed_local`, queues to `ad_track_queue`, extends `LocalTracker`).
  Both implement the base module's `TrackerInterface`.
- **Totals storage** service `ad_track.total_storage` (`TotalSqlStorage`) over table
  `ad_track_total` (schema in `ad_track.install`): per-ad `click`/`impression` counters kept race-safe
  with `INSERT … ON DUPLICATE KEY UPDATE` and per-ad DB transactions. Interface
  `TotalStorageInterface`.
- **Event entity `ad_track_event`** (`src/Entity/AdTrackEvent.php`, base table `ad_track_event`,
  custom `AdTrackEventStorageSchema`, `AdTrackEventViewsData`) — one row per tracked event with
  url/page_title/referrer/ip/user_agent/session/page_view_id/parent_id fields.
- **Click route** `ad_track.track` → `/ad/track/click/{bucket_id}/{uuid}`
  (`Controller/ClickTrackController`, permission `access content`): records the click, then
  redirects (via `TrustedRedirectResponse`) to the ad's stored target URL.
- **Settings form** `ad_track.settings` route → `/admin/config/content/ad/ad-track`
  (`Form/SettingsForm`), config object `ad_track.settings` (nine boolean toggles) + a "Clear event
  data" truncate button.
- **Queue worker** `ad_track_queue` (`Plugin/QueueWorker/DelayedLocalTrackQueueWorker`, cron 120s).
- **Extra fields on `ad_content`** (`ad_track.module`): read-only `total_impression` /
  `total_click`; `hook_entity_prepare_view` fills them from totals storage.
- **Permissions** (`ad_track.permissions.yml`): `bypass track impression`, `bypass track click`.
- **Views**: `ad_track.views.inc`, Views field `ClickThrough` (`@ViewsField("ad_track_click_through")`)
  computing clicks/impressions %.
- Install: flips any `null` tracker in `ad.settings` to `local`; update hooks add finer bypass
  permissions and default settings.
