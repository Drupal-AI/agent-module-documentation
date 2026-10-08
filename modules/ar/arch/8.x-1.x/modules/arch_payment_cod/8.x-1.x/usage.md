<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Arch Payment COD adds a "cash on delivery" payment method to the Arch suite: customers can place an order and pay in cash when it is delivered, with no online payment step.

---

`arch_payment_cod` is a thin gateway submodule of `arch_payment`. It registers a `cod`
`PaymentMethod` plugin (`Plugin\PaymentMethod\Cod`, extending `PaymentMethodBase`, label "Cash on
delivery") whose annotation points `callback_route` at `arch_payment_cod.success`
(`/payment/cod/success`). After the onepage checkout saves the order it redirects there;
`CodPaymentController::paymentSuccess()` simply redirects the buyer on to
`arch_checkout.complete` with the order id (its cancel/error handlers are no-ops, since COD has no
off-site step). Because payment happens physically on delivery, there is nothing to verify online.
Enable it from the payment-methods admin (`/admin/store/settings/payment-methods`) to offer COD at
checkout; it depends on `arch` and `arch_payment`.

---

- Offer "cash on delivery" as a checkout payment option.
- Let customers order without any online payment.
- Redirect the buyer to the order-confirmation page after placing a COD order.
- Enable or disable COD from the payment-methods admin overview.
- Prioritise COD among payment methods by weight.
- Restrict COD to certain orders via `hook_payment_method_access()`.
- Add a COD handling fee via `hook_payment_method_fee_alter()`.
- Serve as a minimal reference for a `PaymentMethod` gateway plugin.
