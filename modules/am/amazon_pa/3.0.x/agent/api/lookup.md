<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# amazon_pa — lookup pipeline, tables, theming (procedural API in `amazon_pa.module`)

Everything here is plain functions in `amazon_pa.module` (no service/class API). Callers are the
`asin` formatters/widget, the `amazon_pa_filter` filter, cron, and the test form.

## Lookup call graph

- **`amazon_pa_item_lookup($item_ids, $force_lookup = FALSE, $locale = NULL)`** — main entry. DB-first:
  unless `$force_lookup`, reads `amazon_pa_item_lookup_from_db()`, then fetches any missing ASINs from
  the web and merges. Returns an array keyed by ASIN.
- **`amazon_pa_item_lookup_from_db($item_ids, $locale)`** — `SELECT * FROM amazon_item WHERE asin IN (…)`
  (+ optional `locale =`), then `_amazon_pa_load_child_data()` joins participants + image + gallery rows.
- **`amazon_pa_item_lookup_from_web($item_ids, $locale)`** — returns `[]` immediately if
  `debug.amazon_request_enabled` is off. Splits ASINs into batches of **10** (Amazon's max) and calls
  `_amazon_pa_item_batch_lookup_from_web()`.
- **`_amazon_pa_item_batch_lookup_from_web($item_ids, $locale)`** — builds params, calls
  `amazon_pa_api_request('GetItems', …)`, logs any `->Errors` via
  `_amazon_pa_item_batch_lookup_from_web_errors()` (which marks the failing ASIN `invalid_asin = TRUE`
  in the DB by regex-extracting the ItemId from the error message), then `amazon_pa_item_clean()` +
  `amazon_pa_item_insert()` for each returned item.
- **`amazon_pa_api_request($operation, $parameters, $locale)`** — reads credentials + the locale's
  associate tag from `amazon_pa.settings`, `sleep()`s `debug.amazon_request_delay`, optionally bumps the
  request counter, and dispatches to `amazon_pa_getItems()` (`GetItems`) or `amazon_pa_searchItems()`
  (`SearchItems`). If `amazon_only_nodes` is set and the current route is not a node, the operation is
  forced to `'none'` (no call).

## SDK wrappers

- **`amazon_pa_getItems($itemIds, $locale, $credentials)`** — the live path. Builds
  `Amazon\CreatorsAPI\v1\Configuration` with `setCredentialId/Secret/Version`, resolves the marketplace
  URL from `includes/amazon_pa.locales.inc`, creates `DefaultApi`, requests a large `GetItemsResource`
  set (OffersV2 price/availability/buy-box, images primary+variants, browse nodes, itemInfo, external
  IDs), calls `->getItems($marketplace, $request)`, and maps the response with `amazon_pa_parseResponse()`
  (keyed by `getASIN()`), decoding each item via `json_decode($item->__toString())`. TLS is the SDK's
  default Guzzle client (verification on; not overridden). Errors are logged through
  `\Drupal::logger('amazon')` with `Xss::filter()` on messages.
- **`amazon_pa_searchItems($parameters, $locale, $credentials)`** — keyword search wrapper. Note: this
  path references old PAAPI5 classes (`SearchItemsRequest`, `PartnerType`, `SearchItemsResource`) and the
  deprecated `watchdog()` / `check_plain()` functions, so it is effectively **dead/broken** under the 3.x
  Creators-API stack and is not reached by the normal ASIN pipeline (only `GetItems` is dispatched).

## Response cleaning — `amazon_pa_item_clean($itemdata)`

Maps the SDK object into a flat `$item` array: `title`, `asin`, `parent_asin`, `binding`, `brand`,
`mpn`, `manufacturer`, `releasedate`, `productgroup`, `producttypename`, `locale` (from
`itemInfo->title->locale`, defaulting to `US`), `isbn`/`ean`, `salesrank`, `detailpageurl`, OffersV2
prices (`listprice*`, `amazonprice*`, `isbuyboxwinner`, EU savings fields `pricetype`, `pricetypelabel`,
`savingsbasis`, `savingspercentage_unf`, `savingsbasis_unf`), `participants` (by contributor role), and
`imagesets` / `imagesets_gallery` for small/medium/large primary + variant images.

## Persistence — tables (`amazon_pa_schema()` in `amazon_pa.install`)

- **`amazon_item`** (PK `asin,locale`) — the main product row incl. all price/savings columns,
  `invalid_asin` flag, and `timestamp`.
- **`amazon_item_participant`** (index `asin`) — role → participant name (only stored when the
  `creators` extended-data box is on).
- **`amazon_item_image`** (PK `asin,size`) — primary image url/width/height (only when `images` box on).
- **`amazon_item_image_gallery`** (PK `asin,size,image_order`) — variant/gallery images.

`amazon_pa_item_insert()` deletes the ASIN's rows first, intersects the cleaned array with the schema
columns, tidies the `detailpageurl` (un-encodes `~ = : , / & ?`), and inserts. `amazon_pa_item_delete()`
removes rows from all four tables. `amazon_pa_get_invalid_asins()` lists rows with `invalid_asin = 1`.

## Cron — `amazon_pa_cron()`

Returns early if `amazon_request_enabled` is off. For each locale with an associate ID, selects up to
`details.amazon_refresh_cron_limit` ASINs whose `timestamp` is older than
`now - details.amazon_refresh_schedule` and re-fetches them via `amazon_pa_item_lookup_from_web()`,
logging counts to the `amazon` channel.

## Theming (`amazon_pa_theme()` + `template_preprocess_amazon_pa_item()`)

14 theme hooks (`amazon_pa_item`, `amazon_details`, `amazon_asin_group`, `amazon_item_button`,
`amazon_item_sbutton`, `amazon_widget`, `amazon_item_test`, thumbnails small/medium/large + medium_title,
galleries small/medium/large + medium_details, `amazon_detail`) mapping to `templates/*.html.twig`.
`template_preprocess_amazon_pa_item()` builds `clean_item(s)`: every string value is `Xss::filter()`ed,
titles are truncated to 50 chars, `detailpageurl` and image URLs pass `UrlHelper::stripDangerousProtocols()`,
dimensions pass `Html::escape()`, and images render through the core `image` theme.
`template_preprocess_amazon_pa_views_view_row_item()` is a Views row preprocess helper.
