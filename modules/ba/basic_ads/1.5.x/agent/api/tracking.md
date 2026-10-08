<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Basic Ads — routes, tracking service, cron & stats

## Routes (`basic_ads.routing.yml`)
| Route | Path | Controller | Access | Notes |
|---|---|---|---|---|
| `basic_ads.click` | `/ad/click/{nid}` | `AdTrackingController::click` | `access content` | `no_cache`; records click, 302 redirect to ad link |
| `basic_ads.track_view` | `/ad/view/{nid}` | `AdTrackingController::view` | `access content` | GET/POST; records impression, returns JSON |
| `basic_ads.fragment` | `/ad/fragment/{term}` | `AdFragmentController::render` | `access content` | GET; uncacheable ad HTML (see block doc) |
| `basic_ads.stats` | `/admin/reports/ad-stats` | `AdStatsController::overview` | `administer nodes` | dashboard table |
| `basic_ads.stats_detail` | `/admin/reports/ad-stats/{nid}` | `AdStatsController::detail` | `administer nodes` | per-ad stats |
| `basic_ads.settings` | `/admin/config/system/basic-ads` | `BasicAdsSettingsForm` | `administer basic ads` | excluded roles |

`{nid}`/`{term}` are constrained to `\d+`.

## `AdTrackingController`
- **`click(int $nid)`**: loads the node, 404s unless bundle `basic_ad` with a non-empty `field_ad_link` resolving to a non-empty URL (empty URL is logged + 404). Reads `placement` from the query (urldecoded), calls `AdTracker::trackClick()`, returns `TrustedRedirectResponse($target, 302)` where `$target` is the ad's own link-field URL (author-set, not request-supplied).
- **`view(int $nid)`**: 404s unless a `basic_ad` node; calls `AdTracker::trackImpression()` with the `placement` query arg; returns `JsonResponse({status, nid})`. Called by `js/ad-tracking.js` (`fetch('/ad/view/'+id+'?placement=…')`) only when the rendered ad has a placement.

## `Service\AdTracker`
`final`; records and reports tracking.
- `trackImpression(nid, placement)` / `trackClick(nid, placement)`: return early if `isUserExcluded()`; otherwise `insert` into `basic_ads_impressions` / `basic_ads_clicks` with `nid`, request time, **anonymized IP**, truncated `User-Agent` (255), placement (+ truncated `Referer` for clicks). Failures are caught and logged, never thrown.
- `isUserExcluded()`: true if the current user's roles intersect `basic_ads.settings:excluded_roles`.
- `anonymizeIp()`: IPv4 → last octet zeroed; IPv6 → truncated to /48; invalid → `''`.
- Counts: `getImpressionCount`/`getClickCount`/`getCtr(nid, ?start, ?end)` via a parameterized `countQuery()` (`countRows()`). `pruneOlderThan(cutoff)` deletes rows with `timestamp < cutoff`, returns `{impressions, clicks}` counts.

All DB access uses the query builder with bound conditions (no string-concatenated SQL); `AdStatsController::getPlacementStats()` likewise uses `select()->groupBy()->addExpression('COUNT(*)')`.

## Cron (`BasicAdsHooks::cron`)
- Unpublishes `basic_ad` nodes with `field_ad_end_date < today` (date-only compare; `accessCheck(FALSE)`), logging each.
- Prunes tracking rows older than 365 days via `AdTracker::pruneOlderThan(now - 365d)`.

## Stats dashboard (`AdStatsController`)
- `overview()`: entity query all `basic_ad` nodes; table of title (link to detail), published status, impressions, clicks, CTR%.
- `detail(nid)`: 404 unless `basic_ad`; summary table for Today / 7d / 30d / All-time (CTR = clicks/impressions·100) plus a per-placement breakdown from `getPlacementStats()`. All dynamic values (`@title`, placement labels) go through `t()` placeholders / render arrays (auto-escaped).
