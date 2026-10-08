# Entities, fields, and the stats service

## Entity types

| Entity type id | Class | Base table | Collection route |
|---|---|---|---|
| `simpleads` (the ad) | `Entity\Advertisement` | `simpleads` | `/admin/content/simpleads` |
| `simpleads_group` | `Entity\Group` | `simpleads_group` | `/admin/config/simpleads/group/list` |
| `simpleads_campaign` | `Entity\Campaign` | `simpleads_campaign` | `/admin/config/simpleads/campaign/list` |

All three are `ContentEntityType`s with a shared HTML route provider (`Routing\SimpleAdsHtmlRouteProvider`),
per-type list builders, Views data handlers, and access handlers. Add/Group/Campaign forms open in a modal
(`use-ajax`). Install seeds one group ("Default") and one campaign ("Example campaign", type `click`, limit 100).

## Advertisement (`simpleads`) base fields

| Field | Type | Notes |
|---|---|---|
| `title` | string(50) | Required label. |
| `group` | entity_reference → `simpleads_group` | Required; which group/block the ad belongs to. |
| `type` | list_string | Required; allowed values from `simpleads_advertisement_types()` → `image` / `responsive_image` / `html5`. Default `image`. |
| `image` | image | For `image` ads (png jpg jpeg gif webp, dir `simpleads/image`). |
| `responsive_image_desktop/_tablet/_mobile` | image | For `responsive_image` ads; each shown under its media query. |
| `html5` | file (zip only) | For `html5` ads; extracted on save to `public://simpleads/html5/{fid}/`, served from `index.html` in an iframe. |
| `url` | link (required) | Click-through URL. `getUrl()` absolutizes an internal `/path` via `Url::fromUserInput`. |
| `url_target` | boolean | Open in new window → target `_blank` vs `_self`. |
| `campaign` | entity_reference → `simpleads_campaign` | Optional; ties the ad to a campaign. |
| `start_date` / `end_date` | datetime (UTC) | Scheduling window (used when no campaign, or campaign type `date`). |
| `inactive` | boolean | Manual kill switch; overrides `status`. |
| `status` | boolean | Active/published flag (auto-managed in `preSave`, see below). |
| `stats` | computed `simpleads_stats` | Renders the statistics tabs/charts. |
| `advertisement` | computed `simpleads_advertisement` | Renders the ad markup. |

`Advertisement::preSave()` recomputes `status`: if the ad has a campaign, it is active only while
`campaign->isActive()` && `campaign->isRunning($ad)`; otherwise it is active when `start_date <= now` and
inactive if `start_date` is in the future or `end_date <= now`. Saving any ad invalidates cache tag
`simpleads_group`. Read counts with `$ad->getClicks($todayOnly=FALSE)` / `$ad->getImpressions(...)` and full
data with `$ad->getStatistics()` (all delegate to the `simpleads.stats` service).

## Campaign (`simpleads_campaign`) fields & logic

Fields: `name`, `type` (multi-value list from `simpleads_campaign_types()`: `click` / `impression` / `date`),
`start_date`, `end_date`, `click` (int limit), `impression` (int limit), `status`.

`Campaign::isRunning(AdvertisementInterface $ad)` returns FALSE (campaign done → ad gets deactivated) when:
`click` in types and `$ad->getClicks() >= click` limit; or `impression` in types and impressions `>=` limit;
and for `date` type, only within `isWithinDateRange()`. This is checked both at ad `preSave` and on every
tracked hit (`Model\SimpleAds::checkCampaign()` — when a campaign finishes it sets the ad inactive, saves it,
and invalidates `simpleads_group`).

## Group (`simpleads_group`) fields

`name`, `description`, `status`. A block/filter/view targets a group id; only ads with
`group = id, status = TRUE, inactive = FALSE` are served (`Model\SimpleAdsGroups::load()`), with optional
`domain_access` filtering when Domain + Domain Entity modules are present, and a
`hook_simpleads_group_properties_alter($properties)` hook.

## Statistics service (`simpleads.stats` → `SimpleAdsStats`)

Constructed with `@database`, `@config.factory`. Use `->setEntityId($ad_id)` then:

| Method | Returns |
|---|---|
| `getClicks($todayOnly)` / `getImpressions($todayOnly)` | Total (aggregated `simpleads_stats` sum + today's raw rows) or just today. |
| `getTodaysClicks()` / `getTodaysImpressions()` | Count of raw rows in `simpleads_clicks` / `simpleads_impressions`. |
| `loadTodayData()` | Today's clicks/impressions + unique + CTR. |
| `loadAll()` / `loadData()` | Per-day rows (from `simpleads_stats`) for tables / charts. |
| `generateTestData()` | Fills a year of random `simpleads_stats` rows for entity 1 (dev helper). |

## Storage tables (`simpleads.install` `hook_schema`)

- `simpleads_clicks` — raw click rows: `id`, `entity_id`, `timestamp`, `ip_address`.
- `simpleads_impressions` — raw impression rows, same shape.
- `simpleads_stats` — aggregated per `entity_id`+`date` (Ymd): `clicks`, `clicks_unique`, `impressions`, `impressions_unique`, `timestamp`.

## Cron (`simpleads.cron` → `SimpleAdsCron::init()`)

Once per day (`state('simpleads_last_aggregation_time')`): groups yesterday-and-older raw rows by day into
`simpleads_stats` (impressions merged, clicks updated; `*_unique` = `COUNT(DISTINCT ip_address)`), then deletes
the consumed raw rows. Every run it also re-saves all non-`inactive` ads that have no campaign so date-based
status flips take effect.
