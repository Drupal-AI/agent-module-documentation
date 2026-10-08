<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ad_track — trackers, storage, click route, settings

## Enable & wire up

`drush en ad_track`. `ad_track_install()` rewrites `ad.settings.trackers`, replacing any `null`
tracker with `local`, so the tracker activates for existing sources automatically. Which tracker a
bucket uses is still the per-bucket choice on the base `ad.settings` form.

## Tracker plugins (`Plugin/Ad/Track`)

Both implement `\Drupal\ad\Track\TrackerInterface`.

- **`LocalTracker`** (id `local`, "Local ad event tracker") — writes immediately.
  - `trackImpression($ad, $user, $context)`: returns NULL if the user has `bypass track impression`;
    if `track_impression_totals`, calls `totalStorage->increaseTotal(IMPRESSION, $ad)`; if
    `track_impression_events` is off, stops there; otherwise builds event values (url from
    `<current>`, referrer from `HTTP_REFERER`, a static per-request `page_view_id` UUID) and saves.
  - `trackClick($ad, $user, $context)`: returns NULL if `bypass track click`; increases the click
    total when `track_click_totals`; saves a click event when `track_click_events`, merging
    parent-impression values via `getParentValues($context['parent_id'])`.
  - `trackEvent()` adds ip/user_agent (only if `track_ip`/`track_agent`), a fresh event UUID, user
    id; **nulls** url/page_title/referrer when their toggles are off; then `saveEvent()`.
  - `sanitizeValues()` validates url/referrer with `UrlHelper::isValid` (else `''`) and strips
    user_agent/page_title to `[A-Za-z0-9\-_()\/,;|. ]` before storage.
- **`DelayedLocalTracker`** (id `delayed_local`, "Queue-based local ad event tracker") extends
  `LocalTracker`; its `saveEvent()` pushes `{ad_id, bucket_id, values}` onto queue `ad_track_queue`
  and returns the pre-generated UUID. `doDelayedSave()` (called by the worker) performs the real
  `parent::saveEvent()`.

`DelayedLocalTrackQueueWorker` (`@QueueWorker(id="ad_track_queue", cron={"time"=120})`): on cron it
re-loads the ad via the bucket factory and calls `doDelayedSave()`.

## Totals storage — `ad_track.total_storage`

`TotalSqlStorage` (service args `@database`, `@logger.factory`) over table **`ad_track_total`**
(pk `(ad_id, bucket_id)`, unsigned int `click`/`impression`; schema in `ad_track.install`).

- `loadTotals($ad)` — SELECT clicks+impressions for the ad (defaults 0/0).
- `increaseTotal($type, $ad)` — `INSERT … VALUES (:ad_id, :bucket_id, 1) ON DUPLICATE KEY UPDATE
  $field = $field + 1`, where `$field` is `database->escapeField($type)` and `$type` is one of the
  `TrackerInterface::EVENT_*` constants; ad ids are bound parameters. Wrapped in a per-ad
  `startTransaction()` / `rollbackTransaction()`.

## Event entity `ad_track_event`

`src/Entity/AdTrackEvent.php` — content entity, base table `ad_track_event`, `admin_permission:
administer ads`, custom storage schema (`AdTrackEventStorageSchema`) and `AdTrackEventViewsData`.
Fields: `type` (bundle), `user`, `created`, `ad_id`, `ip_address`, `user_agent`, `url`,
`page_title`, `referrer`, `page_view_id`, `session`, `parent_id`.

## Click route

`ad_track.track` → `/ad/track/click/{bucket_id}/{uuid}` (permission `access content`),
`ClickTrackController::track`. Loads the bucket + ad (`getAd($uuid)`), calls
`getTracker()->trackClick()` with the request query as context, then redirects to
`$ad->getTargetUrl()->setAbsolute()` via a `TrustedRedirectResponse` (cache max-age 0); a missing ad
throws `NotFoundHttpException`. The target URL is the ad entity's own admin-set link field.

## Settings — `ad_track.settings`

Route `ad_track.settings` → `/admin/config/content/ad/ad-track` (permission `administer ad
settings`), form id `ad_track_settings_form`. Boolean toggles (schema
`config/schema/ad_track.schema.yml`, defaults in `config/install/ad_track.settings.yml`):

`track_impression_totals` (FALSE), `track_click_totals` (TRUE), `track_impression_events` (FALSE),
`track_click_events` (FALSE), `track_ip` (FALSE), `track_agent` (FALSE), `track_url` (TRUE),
`track_title` (TRUE), `track_referrer` (TRUE). The form also warns if no `local`/`delayed_local`
tracker is enabled on any source, and its **Clear event data** submit truncates `ad_track_event`.

`ad_track_page_attachments()` overwrites `drupalSettings.ad.ad_track.track_impressions/track_clicks`
from these settings so the front-end JS knows whether to fire tracking.

## Permissions & reporting

Permissions `bypass track impression`, `bypass track click` (`ad_track.permissions.yml`) exclude
selected roles from counting. `ad_track.module` adds read-only `total_impression` / `total_click`
fields to `ad_content` (filled by `hook_entity_prepare_view`, cache max-age 0). Views field
`ClickThrough` (`@ViewsField("ad_track_click_through")`) renders clicks/impressions as a percentage;
optional views exist in the project's config.
