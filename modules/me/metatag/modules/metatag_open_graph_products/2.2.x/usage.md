Adds Open Graph `product:*` meta tags for describing e-commerce products (price, currency, availability, condition, retailer id).

---

When a product page is shared, richer previews and shopping integrations benefit from structured product data. This submodule extends Open Graph with the `product:*` object properties — price amount and currency, availability, condition, and retailer item id. It registers them as Metatag plugins that can be set as defaults or per product entity, with token support so values come straight from Commerce fields. Depends on the main Metatag module and `metatag_open_graph`. Ideal for Drupal Commerce catalogs.

---

- Declare a product price with `product:price:amount`.
- Declare the currency with `product:price:currency`.
- Declare stock availability with `product:availability`.
- Declare item condition (new/used/refurbished) with `product:condition`.
- Declare the retailer item id with `product:retailer_item_id`.
- Enrich Facebook/social previews for product pages.
- Populate price from a Commerce price field via tokens.
- Set product OG defaults on the product content/entity type.
- Override product tags per product bundle.
- Support shopping-catalog integrations that read OG product tags.
- Keep product metadata exportable as config.
- Show accurate availability in shared links.
- Provide currency-aware pricing metadata.
- Standardize product tagging across a Commerce store.
- Combine with core Open Graph tags for full product previews.
- Improve product discoverability on social platforms.
