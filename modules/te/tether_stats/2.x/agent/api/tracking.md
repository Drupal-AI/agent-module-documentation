# Tracking flow, endpoints, identity sets and tables

## End-to-end flow

1. **Request → element.** On every request, `TetherStatsRequestSubscriber::onRequest`
   (`KernelEvents::REQUEST`) runs when `active` is true and the request is not filtered
   (see [configure/settings.md](../configure/settings.md)). It dispatches
   `TetherStatsEvents::REQUEST_TO_ELEMENT`; if no listener supplies an identity set it builds a
   default one from the URL path (and the query string when `allow_query_string_elements` is on). The
   bundled listener `TetherStatsRequestToElementSubscriber` upgrades `entity.node.canonical` requests
   to an entity-bound identity set (`entity_type=node`, `entity_id=<nid>`). The resulting element row
   is created/loaded via `TetherStatsElement::createElementFromIdentitySet()` and stored on the
   manager (`setElement`).
2. **Beacon attach.** `tether_stats_page_attachments()` (only when `active` **and** an element was
   set) attaches the `tether_stats/tether_stats.corescripts` library and
   `drupalSettings.tetherStats.elid = <element id>`.
3. **Client fires the hit.** `js/tether_stats.js` calls the tracking route by AJAX.
4. **Track.** `TetherStatsTrackController::track()` → `trackEventAtTime(REQUEST_TIME)` writes the
   activity/impression rows.

## `tether_stats.track` — `/tether-stats/track` (permission `access content`)

Returns `JsonResponse`. Reads parameters straight from `$_GET`. Recognised query params:

| Param | Meaning |
|---|---|
| `type` | `hit` (default), `click`, or `impression` (`TetherStatsAnalytics::ACTIVITY_*`; anything else is rejected and logged). |
| `elid` | Numeric element id to attribute the event to. If present and numeric, that element is loaded. |
| `name` / `entity_type` + `entity_id` / `url` (+ `query`) / `derivative` | If no `elid`, these form a **TetherStatsIdentitySet**; a matching element is created/loaded. |
| `alid` | (impression only) the activity id the impression is attached to. |
| `referrer` | Stored in `tether_stats_activity_log.referrer` (the JS sends `document.referrer`). |
| `data` | Serialized into `tether_stats_activity_log.data` if no hook supplies data. |
| `imp0`, `imp1`, … | Embedded impressions on a hit: each is a raw-url-encoded, comma-separated `key=value` identity set; each becomes an impression row (`trackEmbeddedImpressions`). |

For a hit/click it records `ip_address` (`Request::getClientIp()`), `session_id()`, the
`HTTP_USER_AGENT` header as `browser`, the current uid (or NULL if anonymous), and any custom `data`.
Response JSON: `{status: bool, alid?, ilid?}`.

> This endpoint is intended to be called by the site's own front-end JS for **anonymous** visitors,
> so it is gated by `access content` by design and carries no CSRF token. Leave `active` off unless
> collection is wanted.

## Identity sets (`TetherStatsIdentitySet`)

An identity set is a `ParameterBag` of the allowable keys `name`, `entity_type`, `entity_id`, `url`,
`query`, `derivative` (`getAllowableKeys()`; other keys are ignored via `reduceToAllowableKeys()`).
`isValid()` enforces exactly one of three mutually-exclusive states (validated in `testValidity()`):

- **A – Name**: `name` set, matching `^[a-zA-Z0-9_\-]+$`; `entity_id`/`entity_type` must be absent.
- **B – Entity**: both `entity_type` (a real entity-type id) and `entity_id` set. The entity is **not
  loaded** for existence (cost) unless a bundle-constrained derivative forces it.
- **C – URL**: `url` set (with optional `query`); none of name/entity_type/entity_id set.

A `derivative` may be added to any state; it must name an existing, enabled `tether_stats_derivative`
whose entity-type/bundle constraints match. Invalid sets throw typed exceptions
(`TetherStats…Exception`), caught and logged by `TetherStatsManager::testValidityOfIdentitySet()`.

## `hook_tether_stats_track_custom_data($element, $params)` (tether_stats.api.php)

Return an associative array to populate the `data` column of the activity being tracked; the array is
`serialize()`d and stored. `$params` is the track controller's query array. If any implementation
returns data, it overrides the plain `data` query param.

```php
function mymodule_tether_stats_track_custom_data(TetherStatsElementInterface $element, array $params): array {
  return ['country' => 'CA', 'region' => $params['region'] ?? NULL];
}
```

## Database schema (`tether_stats.install`)

- **`tether_stats_element`** — one row per tracked thing. Fields: `elid` (PK), `name`, `entity_id`,
  `entity_type`, `url`, `query`, `derivative`, `count`, `created`, `changed`, `last_activity`.
  Indexes on entity, name, url, derivative, last_activity.
- **`tether_stats_activity_log`** — one row per event. Fields: `alid` (PK), `elid` (FK, restrict),
  `type`, `uid`, `referrer`, `ip_address`, `sid`, `browser`, `data`, `hour`, `day`, `month`, `year`,
  `created`. Times are normalized to the start of the hour/day/month/year for aggregation.
- **`tether_stats_hour_count`** — pre-aggregated counters: `hcid` (PK), `elid` (FK), `type`, `count`,
  `hour`, `day`, `month`, `year`, `timestamp`. Unique key `(elid, type, hour)`. Incremented by
  `incrementHourCount()` for fast reporting without mining the activity log.
- **`tether_stats_impression_log`** — `ilid` (PK), `alid` (FK, restrict), `elid` (FK, restrict).

Writes go through `TetherStatsStorage` (`trackActivity`, `trackImpression`,
`createElementFromIdentitySet`) using the Drupal DB API inside transactions.
