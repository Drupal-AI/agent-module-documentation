<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Arch Payment is the payment framework for the Arch suite: it defines a `PaymentMethod` plugin type, an admin overview to enable/disable/configure each method, and the base classes that concrete gateways (cash-on-delivery, bank transfer, Saferpay) build on.

---

`arch_payment` provides the `arch_payment_methods` plugin type (manager
`plugin.manager.payment_method`, `PaymentMethodManager`, annotation `@PaymentMethod`) and the
building blocks for payment gateways: `PaymentMethodBase` / `ConfigurablePaymentMethodBase` (weight,
active flag, per-order availability, payment fee, callback route), `PaymentControllerBase` (a base
controller whose `__call` logs `payment*` actions and which gateways subclass for their
success/cancel/error/redirect routes), and `PaymentMethodFormatter` (a field formatter that renders
a stored payment method). The admin overview `OverviewForm` at
`/admin/store/settings/payment-methods` lists methods and lets an operator enable/disable and reach
each method's configuration form (`PaymentMethodConfigureController` + `PaymentMethodForm`). Which
methods a customer may pick for a given order is filtered by `PaymentMethodBase::isAvailable()`,
which requires the method to be active and consults `hook_payment_method_access()`; a
`hook_payment_method_fee_alter()` lets modules adjust the method's fee. Each concrete method declares
a `callback_route` in its annotation — the route the checkout redirects to after order placement.
The module provides the `administer payment settings` permission and depends on `arch`, `arch_order`
and `arch_price`. Concrete gateways live in the `arch_payment_cod`, `arch_payment_transfer` and
`arch_payment_saferpay` submodules.

---

- Offer customers a choice of payment methods at checkout.
- Enable or disable each payment method from the store admin.
- Configure a payment method's settings (e.g. gateway credentials, bank details).
- Add a per-method payment fee to an order.
- Restrict a payment method to certain orders via `hook_payment_method_access()`.
- Adjust a method's fee programmatically via `hook_payment_method_fee_alter()`.
- Provide cash-on-delivery via the `arch_payment_cod` submodule.
- Provide bank transfer via the `arch_payment_transfer` submodule.
- Provide card payments via the `arch_payment_saferpay` submodule.
- Write a custom gateway by implementing a `PaymentMethod` plugin.
- Redirect the shopper to a method-specific callback route after placing the order.
- Render a stored payment method on an entity display via `PaymentMethodFormatter`.
- Sort/prioritise payment methods by weight.
- Show only active payment methods in the checkout selector.
- Gate payment admin behind `administer payment settings`.
- Provide the payment layer that `arch_onepage` checkout hands off to.
