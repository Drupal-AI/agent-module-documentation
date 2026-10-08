<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Checkout Onepage (arch_onepage) — agent index

Default single-page checkout UI for Arch. Provides the `onepage` `checkout_type` plugin. Depends on
`arch_checkout` (runtime: `arch_cart`, `arch_order`, `arch_payment`, `arch_shipping`, optional
`arch_addressbook`). Package `Arch Checkout`. Project `arch` (`8.x-1.0-alpha26`).

- **The onepage form: fields, AJAX, submit/order creation** → [checkout/onepage.md](checkout/onepage.md)

## Provides

- Plugin `Plugin\CheckoutType\Onepage` (id **`onepage`**, `form_class =
  Form\OnepageCheckoutForm`) — rendered by `arch_checkout` at `/checkout` when it is the default
  checkout type (it ships as the default in `arch_checkout.settings`).
- Route `arch_onepage.checkout` `/checkout/onepage` — `Controller\OnepageController::checkout`
  (`_permission: access content`); alternate direct entry to the same form (redirects to `<front>`
  if the cart is empty).
- Theme hooks `arch_checkout_op` (form wrapper) and `arch_checkout_op_summary` (order-summary
  sidebar; `arch_onepage_preprocess_arch_checkout_op_summary` fills items/shipping/grand-total).
- JS library `arch_onepage/onepage-checkout` (`assets/js/onepage-checkout.js`, core/jquery).
- No permissions, no config, no plugin types of its own.

## Order creation (`OnepageCheckoutForm::submitForm`)

Sets order status (→ `checkout` status if present, else default = `cart`); optional
`createUser()` for guest+"create account"; billing/shipping `OrderAddressData`; applies
`PaymentMethod::getPaymentFee()` and `ShippingMethod::getShippingPrice()` (currency-exchanged if
needed); `Order::updateTotal()`; `save()`; `setRedirect($payment_method->getCallbackRoute(),
['order' => $order->id()])`. Amounts are server-side; no client-supplied price.
