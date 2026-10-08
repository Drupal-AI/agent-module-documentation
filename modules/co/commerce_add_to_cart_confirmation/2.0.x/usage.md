<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce add to cart confirmation shows a modal dialog confirming what was just added to the cart, instead of leaving the shopper on the product page with only Commerce's default "added to your cart" status message.

---

The mechanism is worth understanding because it is entirely server-driven and uses no custom routes. When a product is added, the module's event subscriber (`ConfirmationMessageSubscriber`) reacts to Commerce's `CART_ENTITY_ADD` event and records the new order item's ID and quantity in the **private** tempstore keyed to the current user/session. On the *next* page render, `hook_page_bottom()` places a `commerce_add_to_cart_confirmation_message` render element (a placeholdered `#lazy_builder`) into the page; that builder reads and immediately clears the tempstore, and if an order item is pending it renders the `confirm_message_product_display` **view** with the order item ID as its contextual argument, then hands the resulting HTML and the view title to the browser through `drupalSettings`. A small behavior in `commerce_add_to_cart_confirmation.js` picks that up and opens it as a `Drupal.dialog` modal (core/drupal.dialog / jQuery UI) with "Go to cart" and "Continue shopping" buttons, the latter simply closing the dialog. Because the confirmation body is a View, you customise it without code: the module ships two dedicated view modes — `commerce_product.add_to_cart_confirmation_view` and `commerce_product_variation.add_to_cart_confirmation` — plus two Views area handlers (`OrderItemOrderTotal` and `OrderOtherCount`, exposed as "Order total for views with order item id argument" and "Order other total count") so the footer can show the cart total and an "N other items in your Cart" line. There is **no settings form** (README: "no menu nor modifiable settings"); all configuration is done by editing the view and the two view modes at the display/Manage-display level. Version **2.0.0** targets core `^10.3 || ^11` and requires `commerce_cart`, `commerce_product` and core `views`; the view is *optional* config, so a runtime requirements check warns if someone deletes it. Two design points determine whether the confirmation helps or hurts: the "continue shopping" path must be one obvious click so buying several items in a row is not slowed, and since the dialog is a focus event it should trap focus, restore it on close and dismiss on Escape (behaviour largely inherited from core's dialog, not added by this module).

---

- Confirm to a shopper that an item was actually added to the cart.
- Replace Commerce's easy-to-miss status message with a prominent modal.
- Offer an explicit "Go to cart" vs "Continue shopping" choice at the moment of highest attention.
- Reduce duplicate add-to-cart clicks on long product pages where the status message is off-screen.
- Show the added product's title, quantity and line total in the confirmation.
- Display the running cart total in the confirmation footer via the bundled Views area handler.
- Show an "N other items in your Cart" summary line alongside the just-added item.
- Embed a related-products or cross-sell view inside the confirmation without custom code.
- Surface recently viewed items at the point of add-to-cart.
- Customise the added-product display by editing the `add_to_cart_confirmation` view mode for products.
- Customise the variation display via the `add_to_cart_confirmation` product-variation view mode.
- Restyle the modal (width, buttons, layout) through the shipped CSS/theme template.
- Override `commerce_add_to_cart_confirmation.html.twig` to change the confirmation markup.
- Reduce cart abandonment by guiding the shopper straight to checkout.
- Increase average order value by upselling in the confirmation dialog.
- Improve the mobile purchase flow where inline status messages scroll away.
- Reassure shoppers the click worked, cutting "did my order go through?" support queries.
- Reuse the `commerce_add_to_cart_confirmation_message` render element to place the confirmation elsewhere.
- Detect a missing confirmation view through the module's runtime requirements warning.
