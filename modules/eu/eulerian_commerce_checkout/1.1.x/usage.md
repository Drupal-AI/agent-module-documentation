Adds Eulerian datalayer values for the completed order on the Commerce checkout complete step.

---

Eulerian - Commerce Checkout is a submodule of the Eulerian module. On the Commerce checkout
"complete" step it appends order data to the Eulerian datalayer
(`drupalSettings.eulerian.datalayer`) that the base module pushes to Eulerian: the order reference
(`ref` = order UUID), total `amount`, `currency`, and a `products` list with each item's product
UUID, unit price and quantity. This is the conversion/transaction event. It resolves the checkout
step via the Commerce checkout order manager and only fires when the requested step matches the
resolved step and equals `complete`. It requires `commerce_checkout` and the base `eulerian` module;
it has no admin UI, config, routes or permissions of its own.

---

- Track completed orders (conversions) in Eulerian.
- Send the order reference (`ref` = order UUID) to Eulerian.
- Send the order total `amount` and `currency` to Eulerian.
- Send the purchased `products` (UUID, amount, quantity) to Eulerian.
- Fire only on the checkout `complete` step.
- Populate the datalayer automatically from the routed `commerce_order`.
- Feed transaction data into Eulerian attribution/revenue analytics.
- Measure e-commerce conversion in Eulerian.
- Combine with eulerian_commerce_product and eulerian_commerce_cart for full funnel tracking.
- Reuse the base module's visibility and consent handling for the checkout page.
- Track conversions without writing custom JavaScript.
- Track only the checkout-complete step (other steps/routes are untouched).
