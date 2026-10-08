Adds Schema.org/Product JSON-LD structured data via Metatag, describing a product with offers, price, availability, ratings, and identifiers for product rich results.

---

Schema.org Product is a Schema.org Metatag submodule that registers Metatag tag plugins for the `Product` type and its nested `Offer`, `AggregateRating`, and `Review` objects. Enabling it exposes a `Schema.org Product` group in Metatag configuration where each property is token-driven and rendered into the page's JSON-LD block. It covers descriptive fields (`name`, `description`, `image`, `category`, `brand`, `url`), commerce identifiers (`sku`, `mpn`, `isbn`, and GTIN‑8/12/13/14), and the sales/rating data Google needs for product results: `offers` (price, currency, availability), `aggregateRating`, and `review`. The `@type` and `@id` tags allow specialization and cross-referencing. Because the values map from tokens, one configuration can cover an entire Commerce product type or catalog bundle. It is the standard way to make Drupal Commerce or catalog products eligible for price/rating rich results and Merchant listings.

---

- Mark up a catalog or Commerce product node as a `Product`.
- Set the product `name`, `description`, and `image` from tokens.
- Provide `brand` and `category` for the item.
- Emit an `offers` block with `price`, `priceCurrency`, and `availability`.
- Show in-stock/out-of-stock status via availability.
- Add `aggregateRating` (average score + review count) for star ratings.
- Include individual `review` markup nested in the product.
- Supply a `sku` and manufacturer `mpn`.
- Provide GTIN‑8, GTIN‑12 (UPC), GTIN‑13 (EAN), or GTIN‑14 identifiers.
- Add an `isbn` for books.
- Link the canonical product `url`.
- Set the `@type` and a stable `@id` for the product entity.
- Qualify products for Google price and rating rich results.
- Feed Merchant/shopping listings with structured product data.
- Standardize markup across an entire Commerce product type via tokens.
- Reference product identifiers to disambiguate items across marketplaces.
- Surface price and availability directly in search snippets.
- Combine with Review/Offer data for full shopping eligibility.
- Map price and currency dynamically from Commerce field tokens.
- Improve click-through with rich product SERP appearance.
