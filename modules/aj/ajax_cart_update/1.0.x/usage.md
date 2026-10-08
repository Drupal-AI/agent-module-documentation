AJAX Cart Update adds live, no-reload updates to the Drupal Commerce cart form so quantity changes instantly refresh item prices, order totals and the cart block.

---

The module attaches JavaScript to the Commerce cart page (`/cart`, including language-prefixed variants such as `/en/cart`) and to the cart block. When a shopper edits an `edit_quantity` input it removes the cart form's manual "Update cart" submit button and, after a short debounce, POSTs the changed quantities to a controller that saves the order items and returns fresh, server-rendered price/total markup. Two interchangeable update strategies are offered and chosen on a single settings form: "selectors" replaces DOM nodes matched by predefined CSS selectors extracted from the cart Views output, while "endpoint" fetches JSON from dedicated `/ajax/cart/*` endpoints and is suited to heavily customized layouts or client-side frameworks (it emits an `ajaxCartUpdate:endpointUpdated` jQuery event for Vue/React integration). All cart data comes from Commerce's `commerce_cart.cart_provider`, so updates always act on the current visitor's own session cart. It requires Views, Commerce and Commerce Cart, and works out-of-the-box against the stock `commerce_cart_form` and `commerce_cart_block` views.

---

- Give shoppers instant order-total and subtotal updates when they change a quantity on the `/cart` page, with no full page reload.
- Refresh per-line item prices in the cart table live as quantities change.
- Remove the manual "Update cart" submit button so the cart behaves as a modern AJAX cart.
- Keep the cart block (mini-cart) item count, quantities, titles and prices in sync with edits made on the cart page.
- Support multilingual storefronts by honoring a two-letter language prefix in the AJAX URLs (e.g. `/uk/cart`, `/es/cart`).
- Choose "selectors" mode for standard themes that use the stock Commerce cart markup and CSS classes.
- Choose "endpoint" mode for complex or bespoke cart layouts where selector replacement is unreliable.
- Integrate a Vue.js or React storefront component by listening to the `ajaxCartUpdate:endpointUpdated` document event and reading the returned cart JSON.
- Trigger custom front-end behavior after any cart change by listening to the `commerce_cart_updated` event.
- Fetch a ready-to-render cart summary HTML fragment from `/ajax/cart/summary-html` for custom widgets.
- Fetch structured cart data (item prices, quantities, titles, total quantity, formatted totals) as JSON from `/ajax/cart/summary-html` or `/ajax/cart/prices`.
- Drive a custom "items in cart" badge from the `total_quantity` / `cart_block_summary_count` values the endpoints return.
- Adapt the module to grid or HTML-list cart Views styles as well as the default table style.
- Add extra custom AJAX endpoints by extending `ajaxCartUpdate.customEndpoints` in a `hook_preprocess_views_view()` implementation.
- Override `templates/views-view--commerce-cart-form.html.twig` to change the cart form layout while keeping AJAX updates working.
- Show a throbber/progress indicator next to the edited quantity field during the update round-trip.
- Automatically re-attach the AJAX behavior after Big Pipe or other AJAX events so late-rendered carts stay interactive.
- Debounce rapid quantity edits (500ms) so only the final value is sent, reducing server load.
- Silently ignore empty or non-numeric quantity input on the client before any request is made.
- Keep formatted prices consistent by rendering all price markup server-side through Commerce's `commerce_price_format`.
- Provide a lightweight alternative to full cart-API front-end builds when you just need the stock Views cart to update dynamically.
