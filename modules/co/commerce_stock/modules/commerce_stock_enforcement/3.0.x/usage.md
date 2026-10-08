Commerce Stock Enforcement blocks customers from buying more than is available: it validates stock on the add-to-cart form, the cart page, and checkout, disabling out-of-stock purchases and showing configurable messages.

---

The submodule is a set of form alterations (`hook_form_alter`) plus validators that consult Commerce Stock's `commerce_stock.service_manager`. On an **add-to-cart** form it checks the selected variation's available level (accounting for what is already in carts); if none is available it relabels the submit button to "Out of stock" and disables it, and it adds a validator that rejects quantities above stock. On the **cart page** (the `commerce_cart_form` view) it validates each line item's quantity against stock. During **checkout** it re-checks the whole order and, if anything is out of stock, redirects back to the cart with an error. The exact stock level comes from the configured stock service (so meaningful enforcement needs `commerce_stock_local` with real levels; with `always_in_stock` everything passes). The three error messages are configurable at `/admin/commerce/config/stock/enforcement/settings` (route `commerce_stock_enforcement.settings`, `StockEnforcementConfigForm`, permission `administer commerce stock`), stored in `commerce_stock_enforcement.settings`: `insufficient_stock_cart` (placeholders `%name`, `%qty`), `insufficient_stock_add_to_cart_zero_in_cart` (`%qty`, `%qty_asked`) and `insufficient_stock_add_to_cart_quantity_in_cart` (`%qty`, `%qty_o`). No permissions or plugins of its own.

---

- Prevent adding more of a product to the cart than is in stock.
- Disable the add-to-cart button and label it "Out of stock" when unavailable.
- Validate cart line-item quantities against available stock.
- Stop checkout when any ordered item has gone out of stock, redirecting to the cart.
- Show a custom "insufficient stock" message on the cart.
- Customize the add-to-cart out-of-stock message when the cart is empty.
- Customize the message when the shopper already has some of the item in their cart.
- Account for quantities already in carts when checking availability.
- Communicate available quantity to shoppers with %qty placeholders.
- Enforce stock only where a real stock service (local) is configured.
- Keep always-in-stock products purchasable without limits.
- Provide a safety net so overselling is blocked at multiple points (cart, checkout).
- Localize/brand the stock enforcement messages per site.
- Combine with local storage so enforcement reflects real transactions.
- Give shoppers clear feedback rather than a generic error when out of stock.
- Block quantity increases on the cart page beyond stock.
- Re-validate the order at checkout in case stock changed since add-to-cart.
- Tailor messaging for B2B vs B2C stores via the config strings.
- Reduce failed orders caused by overselling.
- Enforce availability consistently across the storefront.
