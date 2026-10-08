Adds Eulerian datalayer values (product reference and name) on Commerce product pages.

---

Eulerian - Commerce Product is a submodule of the Eulerian module. On a Commerce product's canonical
page it appends product data to the Eulerian datalayer (`drupalSettings.eulerian.datalayer`) that the
base module then pushes to Eulerian: `prdref` set to the product UUID and `prdname` set to the
product label. It also dispatches a `CommerceProductParamsEvent`, letting other modules add extra
`prdparam-*` attributes to the product datalayer. It requires the base `eulerian` module (which must
have a domain configured and the page must be tracked) and `commerce_product`; it has no admin UI,
config, routes or permissions of its own.

---

- Track product-detail (canonical) pageviews in Eulerian.
- Send the product reference (`prdref` = product UUID) to Eulerian.
- Send the product name (`prdname` = product label) to Eulerian.
- Populate the Eulerian datalayer automatically on `entity.commerce_product.canonical`.
- Add custom product parameters via the `CommerceProductParamsEvent` subscriber.
- Emit `prdparam-<name>` attributes computed from any product field.
- Feed product data into Eulerian attribution/analytics.
- Combine with eulerian_commerce_cart and eulerian_commerce_checkout for full funnel tracking.
- Reuse the base module's visibility, status-code and consent handling for product pages.
- Build product analytics without writing custom JavaScript.
- Extend the product datalayer from a contrib/custom module cleanly.
- Track only product-canonical routes (other routes are untouched by this submodule).
