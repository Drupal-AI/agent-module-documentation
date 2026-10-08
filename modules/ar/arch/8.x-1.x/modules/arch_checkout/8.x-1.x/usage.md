<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Arch Checkout is the checkout framework for the Arch suite: it defines a pluggable `checkout_type` plugin system, the `/checkout` and `/checkout/complete/{order_id}` routes, and the settings that pick the active checkout UI and whether anonymous customers may check out.

---

`arch_checkout` turns a cart into a placed order. The `checkout_type` plugin type (manager
`plugin.manager.checkout_type`, `CheckoutTypeManager`) lets modules provide different checkout UIs;
the `arch_onepage` submodule ships the default `onepage` plugin. `CheckoutController::checkout()`
(`/checkout`) instantiates the configured default checkout type and renders its form, optionally
redirecting to the cart when empty. `CheckoutController::complete()` (`/checkout/complete/{order_id}`)
renders the "thank you" page for a placed order, lets the order's payment method contribute
`checkoutCompleteInfo()`, and transitions the order status to `completed`. An `OrderIdParamConverter`
upcasts the `{order_id}` (by order id or order number) to the order entity, and
`CheckoutCompletePageAccess` decides whether the complete page may render for a given order.
`CheckoutSettingsForm` at `/admin/store/settings/checkout` stores, in `arch_checkout.settings`, the
default `plugin_id`, `anonymous_checkout` (allow / not_allowed) and `redirect_to_cart_if_empty`.
The module provides the `administer checkout settings` permission and several alter hooks
(`checkout_plugin`, `checkout_page`, `checkout_complete_page`, `checkout_complete_page_title`,
`checkout_complete_order_status`, `checkout_completed`). It depends on `arch_order` (and, at
runtime, `arch_cart` and `arch_payment`).

---

- Provide a `/checkout` page that renders the configured checkout UI.
- Swap between different checkout experiences via `checkout_type` plugins.
- Use the bundled one-page checkout (`arch_onepage`) out of the box.
- Show a `/checkout/complete/{order_id}` order-confirmation page.
- Let the chosen payment method add its own info to the complete page (e.g. bank-transfer details).
- Mark an order completed at the end of checkout.
- Allow or forbid anonymous (guest) checkout site-wide.
- Redirect shoppers to the cart page when they reach checkout with an empty cart.
- Resolve `/checkout/complete/…` by either numeric order id or human order number.
- Write a custom checkout UI by implementing a `checkout_type` plugin.
- Alter the selected checkout plugin per request (`hook_checkout_plugin_alter`).
- Alter the checkout page render array (`hook_checkout_page_alter`).
- Alter the complete-page output or title from custom code.
- React to a completed checkout via `hook_checkout_completed()`.
- Override the order status that checkout completion sets (`hook_checkout_complete_order_status_alter`).
- Veto the cart→completed transition via `hook_checkout_complete_page_should_update_order_status`.
- Gate checkout admin settings behind `administer checkout settings`.
- Provide the checkout layer that the payment gateway submodules redirect back into.
