<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Basic Ads — display block & ad selection

## Block plugin `basic_ads_advertisement_block`
`src/Plugin/Block/AdvertisementBlock.php` (attribute `#[Block(id: "basic_ads_advertisement_block", admin_label: "Basic Ad block (by placement)")]`).

- **Config** (`defaultConfiguration`): `ad_placement_term` (int, term ID), `count` (default 1), `label_display` FALSE.
- **`blockForm()`**: `ad_placement_term` = `entity_autocomplete` limited to `basic_ad_placement` terms; `count` = number 1–50.
- **`blockSubmit()`**: normalizes the term ID to int; clamps `count` to `>= 1`; auto-sets the block's admin `label` to `Basic Ad: {placement}` so placements are distinguishable on Block Layout (front-end title stays hidden, `label_display` FALSE).
- **`build()`**: if no term, returns `[]`. Otherwise emits **only a placeholder** `container` with classes `basic-ad-async`, `data-term`, `data-count`, attaches library `basic_ads/async`, and cache tag `taxonomy_term:{term}`. It renders **no ad HTML server-side** — that is the point: the host page (and this block) can be cached indefinitely while the ad rotates per view.

## Async render flow
1. `js/ad-async.js` (behavior `basicAdsAsync`) finds `.basic-ad-async`, reads `data-term`/`data-count`, and `fetch`es `Drupal.url('ad/fragment/' + term) + '?count=…&_=<cachebust>'` with `X-Requested-With: XMLHttpRequest`.
2. On 200 it injects the HTML and re-runs `Drupal.attachBehaviors` (so impression tracking binds); on 204/empty it hides the placeholder (`display:none`) to leave no empty box.
3. `Controller\AdFragmentController::render($term, $request)` picks ads via `AdSelector`, sets `PlacementStorage`, renders each node with the node view builder inside `renderInIsolation()` into an `item_list`, and returns it with `Cache-Control: no-store, private, max-age=0` (+ `X-Basic-Ads-Fragment: 1`). Empty selection → `204`.

## Ad selection — `Service\AdSelector`
`selectAds(int $term_id, int $count): int[]`.
- **`fetchEligibleAds()`**: entity query for `type=basic_ad`, `status=1`, `field_ad_placement=term`, with an OR group so an empty `field_ad_start_date` = "no start gate" (else `<= today`) and empty `field_ad_end_date` = "no expiry" (else `>= today`); `now` is a date-only `Y-m-d` string (accessCheck on). Weights are pulled in one query from `node__field_ad_weight` (missing row → 0).
- **`weightedSample()`**: Efraimidis–Spirakis weighted sampling without replacement. `score = 2 ^ (-weight / WEIGHT_HALF_LIFE)` with `WEIGHT_HALF_LIFE = 10`; key = `log(u)/score`, take the `count` largest keys. **Lower weight = higher priority** (standard Drupal weight); each 10 units halves/doubles relative odds; equal weights → uniform random. If eligible ≤ count, returns all.

## Related hooks (`src/Hook/BasicAdsHooks.php`)
- `block_alter`: removes the duplicate `views_block:basic_ads_advertisements-block_1` from the block list (the custom block supersedes it).
- `theme` + `theme_suggestions_image_formatter_alter`: register `node__basic_ad` and `image_formatter__basic_ad__field_image` templates (`templates/`).
- `node_view`/`preprocess_node`: expose `#ad_link_url`/`ad_link_title`/`has_link`/`placement` to the node template and add cache tags/contexts (`url.query_args:placement`, `timezone`) with a bounded `max-age`.
- `entity_view` + `views_pre_render`: use `PlacementStorage` to pass the current placement label to the ad node template.
- `views_query_alter`: enforces the start/end date window on the `basic_ads_advertisements` view via parenthesised `IS NULL OR <=/>= now` expressions.

The ad markup itself (`node--basic-ad.html.twig`) prints `content.field_ad_image` inside an `<a href="/ad/click/{nid}?placement=…">` (Twig auto-escaped; link is the tracked redirect).
