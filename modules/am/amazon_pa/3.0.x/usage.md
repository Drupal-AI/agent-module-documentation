Amazon PAAPI5 fetches Amazon product data by ASIN through Amazon's Product Advertising / Creators API, caches it in local tables, and displays it as affiliate-linked product blocks, images and prices.

---

The base `amazon_pa` module is the integration and caching engine: it stores your Amazon API credentials and per-locale associate (affiliate) IDs, wraps Amazon's official PHP SDK (`GetItems` / `SearchItems`) behind helper functions, and normalises each response into four tables (`amazon_item`, `amazon_item_participant`, `amazon_item_image`, `amazon_item_image_gallery`). Cron periodically re-queries stored ASINs to keep prices and stock fresh, subject to a configurable refresh interval and per-run limit. It ships a large set of Twig templates and theme hooks (buttons, sales buttons, thumbnails, galleries, widgets, detail blocks) and a set of preprocess functions that XSS-filter product strings before rendering. Two submodules build on it: `amazon_pa_filter` provides an `[amazon:ASIN:selector]` text-format filter for embedding products in body text, and `asin` provides an ASIN field type with a widget, thirteen field formatters, and Views integration over the cached product tables. All configuration lives at `/admin/config/services/amazon` behind the `administer amazon pa settings` permission; the SDK itself is not bundled and must be installed manually per INSTALL.txt.

---

- Add Amazon affiliate product boxes to article bodies with `[amazon:ASIN:inline]` or `[amazon:ASIN:full]`.
- Show a compact product thumbnail inline in prose with `[amazon:ASIN:thumbnail]`.
- Render a "buy" button with price and crossed-out list price via `[amazon:ASIN:button]`.
- Render a savings/deal badge button showing discount values via `[amazon:ASIN:sbutton]`.
- Display several products side by side as a row of boxes with `[amazon:ASIN|ASIN|ASIN:group]`.
- Pull a single data point into text, e.g. `[amazon:ASIN:title]`, `[amazon:ASIN:author]`, `[amazon:ASIN:detailpageurl]`.
- Embed a product image tag directly with selectors like `[amazon:ASIN:largeimage]`.
- Attach an ASIN field to a content type so editors enter a product ID per node.
- Auto-display the product title, price and image from a node's ASIN field using the `asin` formatters.
- Choose a display size per field: small/medium/large thumbnails, galleries, or detail layouts.
- Output only the affiliate product URL from an ASIN field with the `asin_detailpageurl` formatter.
- Build a Views listing of cached Amazon products (title, price, sales rank, brand, MPN, images) from the `amazon_item` base table.
- Join Amazon product images into a View and render them as HTML or as a plain image URL, optionally linked to the product page.
- Keep prices and availability current automatically via cron with a configurable refresh schedule (1–24 h) and cron ASIN limit.
- Refresh a node's product data on save, on view, or on `hook_node_update` (useful for Views Bulk Operations mass refreshes).
- Store extended data optionally: contributor/creator names (authors, actors) and product image links.
- Display EU-compliant strike-through / reference prices (UVP, "was" price, savings percentage) using the EU price fields.
- Configure a fallback link for ASINs that have become invalid, so dead affiliate links are replaced site-wide.
- Test a single ASIN lookup and inspect the raw returned data at `/admin/config/services/amazon/test`.
- Clean up the item cache by deleting a single ASIN or purging all invalid ASINs at `/admin/config/services/amazon/database`.
- Throttle requests with a per-request delay and a token-request delay to avoid Amazon "too many requests" bans while new to the API.
- Restrict API calls to node pages only, or disable outbound API requests entirely while still serving already-cached ASINs.
- Run separate associate IDs per Amazon locale (US, UK, DE, FR, IT, ES, CA, JP, CN) for locale-correct pricing and referrals.
