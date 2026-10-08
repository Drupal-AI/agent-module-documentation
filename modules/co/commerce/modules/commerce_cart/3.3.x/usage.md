Commerce Cart implements the shopping cart: add-to-cart forms, a cart block and cart page, and the session/provider logic that turns a draft order into a customer's cart.

---

A **cart** in Drupal Commerce is simply a `commerce_order` in the draft state flagged as a cart. This submodule supplies the machinery around that: a `CartProvider` that creates and loads the current user's carts (one per store), a `CartManager` for adding, updating and removing order items, a `CartSession` that tracks anonymous carts across requests, and an `OrderItemMatcher` that combines duplicate items. It provides the storefront **add-to-cart form** (rendered on product variations, attribute-aware), an AJAX **cart block** showing item count and total, and a full **cart page** at `/cart` where quantities can be edited or items removed. Cron cleans up expired anonymous carts. It depends on Commerce and Commerce Order. Guest carts are associated with the user on login. Lazy builders keep the cart block cache-friendly.

---

- Add an AJAX add-to-cart button to product pages.
- Show a cart block with live item count and total.
- Provide a `/cart` page to review and edit the cart.
- Update item quantities in the cart.
- Remove items from the cart.
- Support anonymous (guest) carts via session.
- Merge a guest cart into the account on login.
- Combine duplicate order items into one line.
- Maintain separate carts per store in multi-store setups.
- Empty a cart programmatically or on checkout completion.
- Clean up abandoned anonymous carts on cron.
- Access the current cart in custom code via the cart provider.
- Add items to the cart from custom code (e.g. "reorder").
- Render an attribute-aware add-to-cart form for variations.
- Keep the cart block cacheable with lazy builders.
- Redirect to the cart or checkout after adding an item.
- Build a mini-cart or off-canvas cart from the cart block.
- Restrict cart contents to a single store's products.
- Track cart order items as draft order line items.
- Convert a cart into a placed order at checkout.
