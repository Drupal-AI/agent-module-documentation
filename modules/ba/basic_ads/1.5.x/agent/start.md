<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Basic Ads (basic_ads) — agent index

Core-only advertisement manager. Ads are `basic_ad` nodes (image + optional link + placement terms + start/end date + weight); placements are `basic_ad_placement` taxonomy terms. A block renders a cacheable placeholder that loads a weighted-random ad client-side from an uncacheable fragment endpoint, so page caching stays intact while ads rotate. Impressions/clicks are tracked to custom DB tables; cron unpublishes expired ads and prunes old tracking rows; an admin dashboard reports CTR.

Dependencies (all core): node, taxonomy, datetime, image, text, link, views, block. No composer/external deps. License GPL-2.0-or-later. Core `^10.3 || ^11 || ^12`.

## What it provides
- Content type `basic_ad` + vocabulary `basic_ad_placement` + View `basic_ads_advertisements` + tables `basic_ads_impressions` / `basic_ads_clicks`, all created in `basic_ads.install`.
- Block plugin `basic_ads_advertisement_block` — `src/Plugin/Block/AdvertisementBlock.php` (placeholder + async attach).
- Routes (`basic_ads.routing.yml`): `basic_ads.click` `/ad/click/{nid}`, `basic_ads.view` (track_view) `/ad/view/{nid}`, `basic_ads.fragment` `/ad/fragment/{term}`, `basic_ads.stats` `/admin/reports/ad-stats`, `basic_ads.stats_detail` `/admin/reports/ad-stats/{nid}`, `basic_ads.settings` `/admin/config/system/basic-ads`.
- Controllers: `AdTrackingController` (click redirect + view JSON), `AdFragmentController` (uncacheable ad HTML), `AdStatsController` (dashboard).
- Services (`basic_ads.services.yml`): `basic_ads.ad_selector` (weighted sampling), `basic_ads.ad_tracker` (record/count/prune), `basic_ads.placement_storage` (per-request term label).
- Hooks in `src/Hook/BasicAdsHooks.php` (attribute-based): theme, node_view, preprocess_node, entity_view, block_alter, cron, views_query_alter, views_pre_render.
- Settings form `BasicAdsSettingsForm`; config `basic_ads.settings` (`excluded_roles`). Permission `administer basic ads`.

## Solution docs
- [Config & settings](agent/config/settings.md) — install artifacts, `basic_ads.settings`, schema, permissions, roles-excluded.
- [Block & ad selection](agent/plugins/advertisement-block.md) — the block plugin, async fragment flow, `AdSelector` weighting.
- [Tracking, routes & stats](agent/api/tracking.md) — click/view/fragment routes, `AdTracker`, cron, stats dashboard.
