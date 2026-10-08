<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cash on delivery (arch_payment_cod) — agent index

COD payment gateway for the Arch suite. Depends on `arch`, `arch_payment`. Package `Arch Payment`.
Project `arch` (`8.x-1.0-alpha26`).

## Provides

- `PaymentMethod` plugin **`cod`** (`Plugin\PaymentMethod\Cod` extends `PaymentMethodBase`), label
  "Cash on delivery", `module = arch_payment_cod`, `callback_route = arch_payment_cod.success`.
- Route `arch_payment_cod.success` `/payment/cod/success` — `Controller\CodPaymentController::paymentSuccess`
  (`_permission: access content`).
- No permissions, no config, no plugin types, no services of its own.

## Behavior

`paymentSuccess(Request $request)` → `redirect('arch_checkout.complete', ['order_id' =>
$request->get('order')])`. `paymentCancel()` / `paymentError()` are intentional no-ops (offline
method, no off-site part). As an offline method it performs **no** online payment verification — the
"paid" decision is made physically on delivery; the checkout-complete step marks the order
`completed` (see `arch_checkout`). Enable via `/admin/store/settings/payment-methods`.
