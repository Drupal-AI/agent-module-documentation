<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SimpleAds (simpleads) — agent index

Advertisement manager. Models **ads, ad groups, and campaigns** as three content entities, serves a
group of ads in a block / CKEditor tag / Views style / reference field (with rotation + modal), and
tracks **impressions and clicks** through anonymous REST beacons that a JS library fires client-side.
Cron aggregates raw hits into per-day stats and can auto-expire ads when a campaign's click/impression/date
limit is met. Version **2.0.12**, core `^9 || ^10 || ^11`.

Dependencies: `rest`, `views`, `js_cookie` (composer `drupal/js_cookie:^1.0`). Configure route:
`simpleads.advertisement` (`/admin/config/simpleads/advertisement`). Defines permissions and config schema;
no Drush commands; no plugin *types* of its own (extend via alter hooks).

- **Change view modes / responsive media queries / stats date format** → [configure/settings.md](configure/settings.md)
- **Grant who can manage ads and who can be counted** → [permissions/permissions.md](permissions/permissions.md)
- **The 3 entities, their fields, ad/campaign types, and the stats service** → [api/entities.md](api/entities.md)
- **Track/serve ads over REST (click, impression, group, reference, views, stats)** → [api/rest.md](api/rest.md)
- **Display ads: block, `<simpleads>` filter/CKEditor, Views style, reference field** → [blocks/display.md](blocks/display.md)
- **Field types, widgets, and formatters the module provides** → [fields/fields.md](fields/fields.md)
- **Alter hooks to add ad/campaign types, tabs, and group properties** → [hooks/alter-hooks.md](hooks/alter-hooks.md)

## Key facts

- Entity types: `simpleads` (ad, base table `simpleads`), `simpleads_group`, `simpleads_campaign`.
- Ad types (`simpleads_advertisement_types`): `image`, `responsive_image`, `html5`. Campaign types (`simpleads_campaign_types`): `click`, `impression`, `date`.
- Services: `simpleads.cron`, `simpleads.module`, `simpleads.stats`, `paramconverter.entity.simpleads`.
- Config object: `simpleads.config` — keys `ads_view_mode`, `stats_view_mode`, `stats_date_format`, `desktop_media_query`, `tablet_media_query`, `mobile_media_query`.
- Tables: `simpleads_clicks`, `simpleads_impressions` (raw), `simpleads_stats` (aggregated per entity/day).
- Block plugin id `simpleads`; text filter id `simpleads`; Views style id `simpleads`; CKEditor5 plugin `simpleads_SimpleAds`.
- Field types: `simpleads_reference`, `simpleads_stats` (computed), `simpleads_advertisement` (computed).
- REST resource ids: `simpleads_click`, `simpleads_impression`, `simpleads_group`, `simpleads_reference`, `simpleads_views`, `simpleads_stats`.
- Cron hook aggregates daily and re-saves date-driven ads; state key `simpleads_last_aggregation_time`.
