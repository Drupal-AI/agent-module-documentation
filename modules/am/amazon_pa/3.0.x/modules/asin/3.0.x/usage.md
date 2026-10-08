Amazon Field adds an ASIN field type so editors store an Amazon product ID on an entity and display the live product (title, price, image, buttons, galleries) via field formatters and Views.

---

This submodule of Amazon PAAPI5 provides the `asin` field type (`Drupal\asin\Plugin\Field\FieldType\AmazonField`), a text widget (`asin_text`) that validates the entered ASIN by looking it up against the Amazon API or the local cache and shows the stored title, and a mandatory per-field Amazon locale setting. It bundles thirteen field formatters that render the cached product through the parent module's Twig templates: plain ASIN text, product URL, an inline detail block, a sales button, and small/medium/large thumbnails and galleries (plus medium-with-title and medium-with-details variants). It also declares Views data over the `amazon_item`, `amazon_item_image` and `amazon_item_participant` tables and a custom `views_handler_field_amazon_image` handler that renders a product image (as markup or plain URL, optionally linked to the affiliate detail page). Requires `amazon_pa`.

---

- Add an "Amazon product" field to a content type by entering just the ASIN.
- Validate ASINs on entry so editors get an error for non-existent products.
- Bind each field instance to a specific Amazon locale (US, UK, DE, …) for correct pricing/referrals.
- Display the product title/price/image automatically from the stored ASIN using the `asin_details` formatter.
- Show a small, medium or large product thumbnail with the `asin_thumbnail_*` formatters.
- Show a thumbnail plus title with `asin_thumbnail_medium_title`.
- Present a product image gallery (small/medium/large) with the `asin_gallery_*` formatters.
- Show a gallery with product details using `asin_gallery_medium_details`.
- Render a sales/deal badge button with `asin_sbutton`.
- Output only the affiliate product URL with `asin_detailpageurl`.
- Output the raw ASIN string with `asin_plain`.
- Build a Views listing of Amazon products (title, brand, MPN, sales rank, prices, savings) from the `amazon_item` base table.
- Add product images to a View and choose small/medium/large size, HTML or plain-URL output, and whether to link to Amazon.
- Expose participant/creator data (author, actor, artist) of products in Views via the `amazon_item_participant` join.
- Filter, sort and argue Views on any cached product column (price ranges, sales rank, invalid-ASIN flag, buy-box winner).
- Optionally refresh a field's product data from Amazon on node save (via the parent module's node-edit update option).
- Reuse one ASIN field across many content types for affiliate round-ups, review sites and product catalogues.
