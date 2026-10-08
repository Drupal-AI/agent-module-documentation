Amazon Filter is a text-format filter that replaces `[amazon:ASIN:selector]` tags in body text with rendered Amazon product blocks, images, prices or single data fields.

---

This submodule of Amazon PAAPI5 adds one filter plugin (`Drupal\amazon_pa_filter\Plugin\Filter\AmazonFilter`, id `amazon`) that you enable on a text format. When content containing `[amazon:…]` tokens is rendered, the filter regex-matches every token, collects the ASINs (including pipe-grouped ones), de-duplicates them, splits them into batches of ten (Amazon's per-request limit), and looks each batch up through the parent module's DB-first caching pipeline (`amazon_pa_item_lookup()`), sleeping an optional configured delay between batches to avoid throttling. Each token is then replaced with the appropriate rendered theme output — an inline box, thumbnail, button, sales button, widget, product group, or a single named data value — and invalid/removed ASINs are replaced with the configured fallback link. It requires `amazon_pa` (for lookups and templates) and core `filter`.

---

- Embed a product box inside an article body with `[amazon:0399155341:inline]`.
- Show full product details with `[amazon:0399155341:full]` or `[amazon:0399155341:details]`.
- Insert a product thumbnail image with `[amazon:0399155341:thumbnail]`.
- Add a buy button (price + crossed-out list price) with `[amazon:0399155341:button]`.
- Add a savings/deal badge button with `[amazon:0399155341:sbutton]`.
- Render an Amazon-style image+text widget with `[amazon:0399155341:amzwidget]`.
- Display several products as a row of boxes with `[amazon:A|B|C:group]`.
- Output just the product title with `[amazon:0596515804:title]`.
- Output just the affiliate detail-page URL with `[amazon:0596515804:detailpageurl]`.
- Output a specific image tag with `[amazon:0596515804:largeimage]` (or small/medium image + width/height variants).
- Pull book/media metadata such as `author`, `ean`, `isbn`, `manufacturer`, `brand`, `binding`, `salesrank`.
- Show pricing fields inline: `amazonpriceformattedprice`, `listpriceformattedprice`, `savingspercentage`, `savingsbasis`.
- Reuse the same ASIN many times on a page without extra API calls (per-request in-memory cache).
- Automatically replace ASINs that have gone invalid with a site-wide fallback link (configured in the parent module).
- Combine multiple products and selectors in a single rich-text field for review/round-up articles.
- Give editors a WYSIWYG-friendly way to add affiliate products without any code or field configuration.
