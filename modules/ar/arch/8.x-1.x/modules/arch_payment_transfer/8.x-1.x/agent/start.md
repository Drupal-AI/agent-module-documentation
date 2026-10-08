<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Transfer payment (arch_payment_transfer) — agent index

Bank-transfer payment gateway for the Arch suite. Depends on `arch`, `arch_payment`. Package
`Arch Payment`. Project `arch` (`8.x-1.0-alpha26`).

- **Bank-detail settings & the complete-page output** → [config/settings.md](config/settings.md)

## Provides

- `PaymentMethod` plugin **`transfer`** (`Plugin\PaymentMethod\Transfer` extends
  `ConfigurablePaymentMethodBase`, implements `CheckoutCompleteInterface`, `PluginFormInterface`),
  `module = arch_payment_transfer`, `callback_route = arch_payment_transfer.success`.
- Route `arch_payment_transfer.success` `/payment/transfer/success` —
  `Controller\TransferPaymentController::paymentSuccess` (`_permission: access content`).
- Config object **`arch_payment_transfer.settings`** with schema `arch_payment_transfer.config`
  (`complete_message` + `currencies_variables` per-currency: `business_name`, `account_number`,
  `bank_provider`, `announcement`, `customer_bic`, `customer_iban`).
- No permissions or plugin types of its own. Settings edited via
  `PaymentMethodConfigureController` (`/admin/store/settings/payment-methods/transfer`).

## Behavior

- `paymentSuccess()` → `redirect('arch_checkout.complete', ['order_id' => $request->get('order')])`;
  `paymentCancel()` / `paymentError()` are no-ops. Offline method → **no** online payment
  verification (a `@todo` notes the payment-info email is unimplemented).
- `checkoutCompleteInfo(OrderInterface $order)` renders the configured bank details for the order's
  currency (falling back to defaults) plus the grand total (`arch_price` formatter); the
  per-order "announcement" is the order number.
