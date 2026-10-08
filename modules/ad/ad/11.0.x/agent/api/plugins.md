<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ad — bucket & tracker plugin APIs

The base module defines two extensible plugin types plus the domain interface `AdInterface`. A
custom module extends the system by providing a **bucket** (where ads come from) and/or a **tracker**
(where statistics go). The shipped `ad_content` / `ad_track` submodules are just the native
implementations of these.

## `AdInterface` (`src/AdInterface.php`)

A single ad instance. Methods: `getAdIdentifier(): string`, `getBucketId(): string`,
`getPlacementId(): string`, `getTargetUrl(): ?Url`. In `ad_content` this is implemented by the
`AdContent` entity (identifier = its UUID).

## Bucket plugin type (ad content providers)

- **Discovery dir:** `Plugin/Ad/Bucket`. **Manager:** `Bucket\BucketPluginManager` (alter hook
  `ad_bucket_info`, cache key `ad_bucket_plugins`) — a private service used only through the factory.
- **Factory service `ad.bucket_factory`** (`Bucket\BucketFactory`, args: plugin manager,
  `config.factory`, `request_stack`). `get(string $id): ?BucketInterface` instantiates the plugin
  with configuration `['ad_context' => currentRequest query params, 'tracker_id' => configured
  tracker for that bucket or 'null']`. `getList()` (from `AdFactoryBase`) returns id → label, sorted.
- **`Bucket\BucketInterface`** methods: `buildPlaceholder($placement_id)`, `buildAd($placement_id)`,
  `getAd($id): ?AdInterface`, `getTracker(): TrackerInterface`, `isEmpty($placement_id): bool`,
  `getPlacementCount($placement_id): int`.

The tracker assigned to each bucket is read from `ad.settings` `trackers[$bucketId]`; the bucket
resolves it lazily via `getTracker()`.

## Tracker plugin type (statistics engines)

- **Discovery dir:** `Plugin/Ad/Track`. **Manager:** `Track\TrackerPluginManager` (alter hook
  `ad_tracking_info`, cache key `ad_tracking_plugins`) — private, used via the factory.
- **Factory service `ad.tracker_factory`** (`Track\TrackerFactory`, args: plugin manager,
  `logger.factory`). `get(string $name): TrackerInterface` — on a `PluginException` it logs and
  falls back to the `NullTracker`. `getList()` forces the `null` tracker to the front of the list.
- **`Track\TrackerInterface`** constants `EVENT_IMPRESSION='impression'`, `EVENT_CLICK='click'`,
  `PLACEHOLDER_IMPRESSION='AD_TRACK_IMPRESSION_ID_PLACEHOLDER'`. Methods: `id()`,
  `trackImpression($ad, $user, $context=[]): ?string`, `trackClick($ad, $user, $context=[]): ?string`
  (return the event UUID or NULL).
- **`NullTracker`** (`src/Plugin/Ad/Track/NullTracker.php`, id `null`, label "None") — no-op
  fallback; both track methods return NULL. Used when a bucket has no configured tracker.

`AdFactoryBase` (`src/AdFactoryBase.php`) is the shared base for both factories, holding the plugin
manager and the `getList()` implementation. `AdFactoryInterface` declares `getList()`.

## Serving flow (with `ad_content` + `ad_track` enabled)

1. `AdSlot::build()` picks a random bucket + placement and returns the bucket's placeholder
   (`<ad-content>` custom element, library `ad_content/ad_content.render_ads`).
2. The JS (`ad_content/js/ad-content.render.js`) collects placeholders and GETs
   `/ad/content/render?ads={…}` (`ImpressionController::renderAds`, `ad_content` submodule).
3. That controller asks the bucket to `buildAd($placement)`, which renders one random published ad
   and fires `tracker->trackImpression()`; the rendered HTML is returned as JSON and injected.
4. On click, JS GETs `/ad/track/click/{bucket_id}/{uuid}` (`ClickTrackController`, `ad_track`),
   which fires `trackClick()` and redirects to the ad's stored target URL.

To write a custom provider, create a plugin under `your_module/src/Plugin/Ad/Bucket/` implementing
`BucketInterface`; for a custom stats backend, one under `.../Plugin/Ad/Track/` implementing
`TrackerInterface`. Both use the legacy `@Plugin(id=…, label=…)` annotation (see the native
implementations).
