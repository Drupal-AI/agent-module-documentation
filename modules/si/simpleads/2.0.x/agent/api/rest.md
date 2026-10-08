# REST resources

SimpleAds ships six `@RestResource` plugins (config in `config/install/rest.resource.*.yml`), all
`cookie` auth + `json` format. The front-end JS libraries (`simpleads.block.js`, `simpleads.reference.js`,
`simpleads.views.js`, `simpleads.stats.js`) call them to fetch ad markup and post tracking hits. Each is
gated by the matching `restful <method> <id>` permission (see [../permissions/permissions.md](../permissions/permissions.md)).
Every route parameter that names an entity is resolved through entity storage `load()`, and an unknown id
returns a JSON error code (`invalid_entity`, `group_not_found`, `no_ads_found`, …) rather than data.

| Resource id | Method | URI | Controller | Returns |
|---|---|---|---|---|
| `simpleads_group` | GET | `/simpleads/group/{entity_id}/{current_node_id}/{node_ref_field}/{simpleads_ref_field}` | `SimpleAdsGroup` | Active ads in a group (`{items, count}`); optional node↔ad reference-field matching. |
| `simpleads_reference` | GET | `/simpleads/reference/{entity_type}/{field_name}/{entity_id}` | `SimpleAdsReference` | Active ads targeted by a `simpleads_reference` field on the given entity. |
| `simpleads_views` | GET | `/simpleads/views/{view_id}/{display_id}` | `SimpleAdsViews` | Active ads whose ids come from a Views result set. |
| `simpleads_stats` | GET | `/simpleads/stats/data/{entity_id}` | `SimpleAdsStats` | Today + all-time stats arrays for one ad. Permission NOT granted by default. |
| `simpleads_click` | POST | `/simpleads/click/{entity_id}` | `SimpleAdsClicks` | Records a click, returns the ad model. |
| `simpleads_impression` | POST | `/simpleads/impression/{entity_id}` | `SimpleAdsImpressions` | Records an impression, returns the ad model. |

## Ad model payload

GET endpoints return each ad via `Model\SimpleAdsBase::model()`:

```json
{ "entity_id": 12, "group_id": 3, "html": "<rendered ad markup>",
  "url": "https://example.com/promo", "url_target": "_blank" }
```

`html` is the ad rendered in the `ads_view_mode` view mode; `url`/`url_target` let the JS wire the
click-through. The click/impression counting and the redirect happen client-side — the JS posts to the
tracking endpoints and navigates the browser to `url`.

## Tracking flow

`SimpleAdsClicks::post($entity_id)` / `SimpleAdsImpressions::post($entity_id)` load the ad by id and call
`Model\SimpleAds::click()` / `::impression()`. Those methods:

1. skip obvious bots (`Base::isBotDetected()` — a User-Agent regex),
2. require the caller to hold `count simpleads clicks` / `count simpleads impressions`,
3. run `checkCampaign()` (auto-deactivate the ad if its campaign limit is now met), and
4. `INSERT` a row into `simpleads_clicks` / `simpleads_impressions` with `entity_id`, `time()`, and the
   request client IP.

The response invalidates the ad's cache tags. Cron later folds the raw rows into `simpleads_stats`
(see [entities.md](entities.md)).
