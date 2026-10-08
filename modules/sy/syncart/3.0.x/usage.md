Syncart is a Synapse-authored custom Drupal Commerce cart that replaces the default add-to-cart/checkout UX with a JSON/AJAX cart plus favorites, donation mode, and an admin checkout-link generator.

---

Syncart layers on top of `commerce_cart`, `commerce_checkout`, and `commerce_order`. It exposes a set of controller endpoints that read/write the current session's Commerce cart as JSON (`/api/cart-load`, `/cart/add-item`, `/cart/add-items`, `/cart/set-variation-quantity`, `/cart/set-order-item-quantity`, `/cart/set-item-note`, `/cart/remove-cart-item`, `/cart/refresh-stock`, `/cart-repeat-order/{order}`), rendered through `SynRenderService` and mutated through `SynCartService`. It provides a `CartBlock`, a cookie-driven favorites/wishlist page (`/favorites`), a settings form at `/admin/config/syncart`, an admin page to reset Commerce order-number sequences, and a `CheckoutLink` service that builds a time-limited hashed URL an admin can hand a customer to resume a specific order at checkout. A `SyncartFinalize` checkout pane, several presave/preprocess hooks, and a receipt/template set (with en/es/kk/ru translations) round out the storefront. Three optional submodules add order-status taxonomy management, POS terminal support, and paragraph-based product features.

---

- Build an AJAX single-page cart where adding, updating, and removing items returns fresh cart JSON without a full page reload.
- Add a single product variation to the cart via a `POST` to `/cart/add-item` with `{vid, quantity, selected_products}`.
- Add several variations at once via `POST /cart/add-items` with `{vids: [...]}`.
- Render the current cart contents (items, quantities, subtotal, total, promotions) as JSON from `/api/cart-load`.
- Show a themed cart region on any page through the provided `CartBlock` block plugin.
- Let shoppers change a line-item quantity live via `POST /cart/set-order-item-quantity` or `/cart/set-variation-quantity`.
- Remove a line item and redirect back to the cart via `POST /cart/remove-cart-item`.
- Capture a per-line-item note/comment (enabled by the "Order item note" setting) via `POST /cart/set-item-note`.
- Offer a "repeat this order" action that copies a previous order's items into a new cart (`/cart-repeat-order/{commerce_order}`).
- Re-check on-hand stock for cart items before checkout via `POST /cart/refresh-stock`.
- Enforce stock availability at add-to-cart time with the "Consider stock availability" setting.
- Run a donation-style storefront where the shopper enters an amount and the module reuses or creates a matching-priced product variation on the fly.
- Provide a cookie-based favorites/wishlist page at `/favorites` that lists chosen products with a combined price.
- Toggle a quantity selector on the add-to-cart widget with the "Show quantity selection" setting.
- Customize the checkout flow layout via the bundled `commerce_checkout_flow.default` config and the `SyncartFinalize` checkout pane.
- Generate an admin-only, time-limited hashed checkout link (`/admin/commerce/orders/{order}/checkout-link`) so a staff member can email a customer a direct resume-checkout URL.
- Reset/flush the running sequence of a Commerce order-number pattern from `/admin/config/syncart/administer`.
- Localize the storefront and order views into English, Spanish, Kazakh, and Russian using the shipped view/display config per language.
- Auto-provision customer profile and user fields (name, surname, phone, email, comment) and a product `field_stock` on install.
- Add taxonomy-driven order statuses and a kanban-style orders-by-status board with the `syncart_order_status` submodule.
- Support an in-store POS workflow (dedicated order type, checkout flow, and terminal cookie) with the `syncart_pos` submodule.
- Attach paragraph-based "product feature" upsells that add adjustments to the order with the `syncart_product_feature` submodule.
- Send a themed order receipt email on order completion via the `OrderCompleteSubscriber` event subscriber.
