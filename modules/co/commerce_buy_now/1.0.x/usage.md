<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Buy Now adds a "Buy Now" button to every Drupal Commerce add-to-cart form that adds the product to the cart and sends the shopper straight to checkout in one click.

---

Install it with Composer (`composer require drupal/commerce_buy_now`) and enable it with the other Commerce modules it needs: `commerce`, `commerce_cart`, `commerce_store`, `commerce_checkout` and `commerce_product`. There is nothing to configure — the module implements a single form alter that appends a **Buy Now** submit button (CSS classes `button--primary button--buy-now`) to the standard add-to-cart form, so the button appears automatically on your product pages and add-to-cart blocks once enabled. Clicking it adds the product to the customer's default cart via Commerce's cart manager and then redirects to the checkout page, chaining the normal add-to-cart and checkout steps. It reuses the standard, CSRF-protected add-to-cart form, and the price is taken from the product variation on the server, not from the request. Two things to verify on your storefront: on products with multiple variations the button adds the product's **first** variation rather than the attribute-selected one, and the quantity comes from the form's quantity field (a quantity of 0 is rejected by validation). To restyle the button, target the `button--buy-now` class in your theme; to change or remove it, implement `hook_form_commerce_order_item_add_to_cart_form_alter()` in a custom module.

---

- Add a one-click "Buy Now" button to product pages.
- Skip the cart page and go straight to checkout.
- Speed up single-item and impulse purchases.
- Reduce checkout friction and clicks.
- Chain add-to-cart and checkout into one action.
- Install with `composer require drupal/commerce_buy_now`.
- Enable alongside Commerce cart, store, checkout and product.
- Use it with zero configuration after enabling.
- Let the button appear automatically on every add-to-cart form.
- Style the button via the `button--buy-now` CSS class.
- Keep the standard, CSRF-protected add-to-cart form.
- Rely on server-side pricing from the product variation.
- Take the quantity from the form's quantity field.
- Reject a quantity of 0 through normal form validation.
- Confirm behaviour on multi-variation (variable) products.
- Note that the first variation is added, not the selected one.
- Add the product to the customer's default cart.
- Redirect the shopper to the Commerce checkout route.
- Remove the button per product or role with a custom form alter.
- Rename or re-weight the button in a custom module.
- Swap the submit callback to change the redirect destination.
- Pair with your existing Commerce checkout configuration.
- Test the full flow before enabling in production.
