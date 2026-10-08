<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Advertisement (ad) — agent index

A self-hosted advertising framework for Drupal 11. The base `ad` module is a **skeleton**: it
defines ad **placements**, a block that serves a random ad, a settings form, and two **extensible
plugin types** (buckets + trackers). It renders nothing useful until a content-provider submodule
(`ad_content`) and optionally a tracker (`ad_track`) are enabled. Package `Advertisement`. Core
`^11`. No dependencies. License GPL-2.0-or-later. Release **11.0.0-alpha12** (version tracks core).
No upgrade path from 4.x.

- **Settings form, placement entities, the ad block, permissions & routes** → [config/settings.md](config/settings.md)
- **The bucket & tracker plugin APIs, factories, services, how ads are served** → [api/plugins.md](api/plugins.md)

## Submodules (each documented in its own tree under `modules/`)

- **ad_content** — the ad entity (`ad_content`), its bundles (image/text), the `AdContentBucket`
  provider, and the AJAX impression-render controller. → `modules/ad_content/11.0.x/`
- **ad_track** — native impression/click trackers, the `ad_track_event` entity, totals SQL storage,
  the click-redirect route, statistics Views. → `modules/ad_track/11.0.x/`
- **ad_content_scheduler** — Scheduler-module integration to time-publish/unpublish ads. →
  `modules/ad_content_scheduler/11.0.x/`
- **ad_content_js** — experimental JavaScript/network-script ad type (WIP, mostly non-functional). →
  `modules/ad_content_js/11.0.x/`

## What the base module provides (from source)

- **Config entity `ad_placement`** (`src/Entity/AdPlacement.php`) — a named, sized slot. Nine
  presets shipped in `config/install/ad.ad_placement.*` (billboard, fullsize_banner,
  halfsize_banner, large_leaderboard, leaderboard, medium_rectangle, mobile_leaderboard, rectangle,
  skyscraper). Managed at `/admin/config/content/ad/ad-placements`.
- **Block plugin `ad`** — `AdSlot` (`src/Plugin/Block/AdSlot.php`), admin label "Advertisement
  slot", category "Advertisement". Config: `bucket_ids` (checkboxes) + `placement_id` (select).
  Picks a random bucket, then renders `bucket->buildPlaceholder(placement)`. Access =
  permission `view ads`.
- **Two plugin managers / factories** (services in `ad.services.yml`): `ad.bucket_factory`
  (`BucketFactory`), `ad.tracker_factory` (`TrackerFactory`), each backed by a private
  `DefaultPluginManager` scanning `Plugin/Ad/Bucket` and `Plugin/Ad/Track`. Also
  `ad.placement_manager` (`AdPlacementManager`).
- **Interfaces** `AdInterface`, `Bucket\BucketInterface`, `Track\TrackerInterface`; fallback
  `NullTracker` (id `null`).
- **Settings form** `SettingsForm` at route `ad.settings` (`/admin/config/content/ad`), config
  object `ad.settings` (keys `trackers`, `advertisement_indicator`, `hide_empty_blocks`).
- **Permissions** (`ad.permissions.yml`): `administer ads`, `administer ad settings`,
  `administer ad placements`, `view ads`. `hook_install()` grants `view ads` to anonymous +
  authenticated.
- **Hook** `ad_page_attachments()` seeds `drupalSettings.ad.track_impressions/track_clicks` (FALSE;
  overwritten by submodules). Helper `ad_get_placements_list()`.
- Config schema in `config/schema/ad.schema.yml` (`ad.settings`, `ad.ad_placement.*`,
  `block.settings.ad`).
