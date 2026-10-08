A very simple shopping cart and checkout for small Drupal sites: mark chosen content types as buyable, let visitors add them to a session cart, and turn a checkout into an order node that emails the admin and (optionally) the customer.

---

Basic Cart lets you sell existing content without a full commerce stack. On the settings form you enable one or more content types; the module then adds an `add_to_cart` field (plus an optional price field) to those types via `Utility::createFields()`, giving each node an "Add to cart" button/formatter (with an optional quantity variant). Visitors use routes `/cart/add/{nid}`, `/cart/remove/{nid}`, `/cart` and `/checkout` (all behind the `basic_cart use_cart` permission); the cart lives in the session or an optional DB table (`use_cart_table`) via `CartStorageSelect` → `CartSession`/`CartStorage`, and blocks show the cart contents (`CartBlock`) and item count (`CountBlock`). Checkout builds a node of the module's own `basic_cart_order` content type — which ships preconfigured with address/city/zip/phone/email/message/VAT/total fields and an `entity_reference_quantity` field (`basic_cart_content`) referencing the ordered products. Saving an order triggers `basic_cart_order_send_notifications()`, which token-replaces the configurable admin and user email templates and sends them via `hook_mail`. A checkout settings form controls the admin recipient list, both email bodies (with `[basic_cart_order:*]` tokens including a rendered products list), whether the customer is emailed, and the thank-you page. Currency, price/quantity/VAT display, labels, buttons, and a post-add redirect are all configurable. A Drush command and a bulk node action can enable "add to cart" across all nodes of enrolled types. It requires `telephone` and `entity_reference_quantity`.

---

- Sell a handful of products/offers on a small site without Drupal Commerce.
- Turn any existing content type (e.g. "Product", "Tour") into an add-to-cart item.
- Add an "Add to cart" button to nodes via a field formatter.
- Offer an add-to-cart button with a quantity selector.
- Keep a per-visitor session cart with add/remove/empty operations.
- Optionally persist carts in a database table instead of the session.
- Show a cart-contents block and a live item-count block.
- Provide a `/cart` page and a `/checkout` flow.
- Collect customer address, phone, email, and a message at checkout.
- Record each purchase as a `basic_cart_order` node for later review.
- Email the site admin (or a list of admins) when an order is placed.
- Optionally email an order confirmation to the customer.
- Customize both email templates with `[basic_cart_order:*]` tokens.
- Include a rendered ordered-products list in the notification emails.
- Configure currency and price/VAT display and labels.
- Apply a VAT rate to the order total.
- Customize all button labels and cart/checkout/thank-you page titles.
- Redirect the shopper to a chosen page after adding to cart.
- Create a "direct order" without going through the cart (`create_direct_orders`).
- Show a configurable thank-you page after checkout.
- Bulk-enable add-to-cart across all nodes of enrolled types (Drush or VBO action).
- Give order visibility to staff via the `view_orders` permission and orders View.
- Restrict cart use / administration with dedicated permissions.
- Localize cart strings via config translation.
