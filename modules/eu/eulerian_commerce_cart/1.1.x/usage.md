Adds Eulerian datalayer values for the current user's cart on the Commerce cart page.

---

Eulerian - Commerce Cart is a submodule of the Eulerian module. On the Commerce cart page (route
`commerce_cart.page`) it appends cart data to the Eulerian datalayer
(`drupalSettings.eulerian.datalayer`) that the base module pushes to Eulerian: `scart = 1`,
`scartcumul = 0`, and a `products` list containing each line item's product UUID (`ref`), unit price
(`amount`) and quantity. It reads the current session's carts via the Commerce cart provider. It
requires `commerce_cart` and — through its dependency on `eulerian_commerce_product` — the base
`eulerian` module. No admin UI, config, routes or permissions of its own.

---

- Track the Commerce cart page in Eulerian.
- Send the cart contents (`products`) to Eulerian.
- Send each product's reference (UUID), amount and quantity.
- Mark the cart event with `scart = 1`.
- Send products as an accumulation (`scartcumul = 0`).
- Populate the datalayer automatically on `commerce_cart.page`.
- Use the current user's carts from the Commerce cart provider.
- Feed cart data into Eulerian funnel/attribution analytics.
- Combine with eulerian_commerce_product and eulerian_commerce_checkout for full funnel tracking.
- Reuse the base module's visibility and consent handling for the cart page.
- Track cart composition without writing custom JavaScript.
- Track only the cart route (other routes are untouched by this submodule).
