Commerce Cart Redirection sends a Drupal Commerce shopper to the checkout, the cart, or any custom URL immediately after they add a selected product variation to their cart, instead of leaving them on the product page.

---

The module listens for Commerce's `CartEvents::CART_ENTITY_ADD` event and, on the following kernel response, replaces the page with a `RedirectResponse` when the added product variation matches the configured bundles. All behavior is driven by a single config object, `commerce_cart_redirection.settings`, edited at `/admin/commerce/config/commerce_cart_redirection` (permission `configure commerce_cart_redirection`). You pick which product variation bundles trigger a redirect (`product_bundles`), or tick "Negate the bundles condition" (`negate_product_bundles`) to redirect everything *except* those bundles. The redirect target (`redirection_route_path`) is one of `checkout` (route `commerce_checkout.form` — falls back to the front page if commerce_checkout is absent), `cart` (`commerce_cart.page`), or `other` (an arbitrary URL in `redirection_route_path_other`, validated only with `UrlHelper::isValid()`). An "Advanced" option, `clear_cart_before_add`, empties the cart of all other order items before adding the new one, so the shopper checks out with just that item. Finally, `add_to_cart_replacement_text` relabels the "Add to cart" button (via `hook_form_alter`) for the variations that will be redirected. Out of the box nothing is redirected until you configure it, and selecting all bundles *and* negating them cancels out to redirect nothing.

---

- Send shoppers straight to checkout after adding a product, for a one-click "buy now" flow.
- Redirect to the cart page after every add-to-cart instead of the default in-place refresh.
- Redirect to a custom thank-you or upsell page URL after a specific product is added.
- Enable the redirect only for certain product variation bundles (e.g. "event ticket" variations).
- Use the negate option to redirect for all variation bundles except a chosen few.
- Build a single-item checkout kiosk where adding a product clears the cart and jumps to checkout.
- Force "one product at a time" carts by clearing existing items on each add.
- Relabel the "Add to cart" button to "Buy now" for products that skip the cart.
- Change button text to "Proceed to checkout" only on variations configured for redirection.
- Skip the cart page entirely for digital or single-purchase products.
- Drive donation-style flows where each add goes straight to payment.
- Send subscription or license products directly to checkout after selection.
- Configure a booking site so adding a slot immediately starts checkout.
- Redirect to an external checkout provider URL (e.g. a hosted payment page) after add.
- Keep general merchandise on the product page while fast-tracking one special bundle to checkout.
- Provide different post-add behavior per environment by exporting `commerce_cart_redirection.settings`.
- Reduce cart abandonment by removing an extra click between add-to-cart and checkout.
- Ensure a promo product always replaces whatever was in the cart before checkout.
- Route ticket purchases straight to checkout while leaving merchandise in the normal cart flow.
- Point the redirect at the front page fallback when no checkout route is available (headless/BigCommerce).
- Grant a store manager the `configure commerce_cart_redirection` permission to self-serve these rules.
- Combine with a "buy now" button label so the UI matches the skip-cart behavior.
- Set up a quick-donate page where each amount variation goes to checkout with a cleared cart.
- Standardize add-to-cart behavior across a multi-store Commerce site via one config object.
- Prototype express-checkout UX without writing a custom event subscriber.
