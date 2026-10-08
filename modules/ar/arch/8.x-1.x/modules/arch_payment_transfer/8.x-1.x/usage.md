<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Arch Payment Transfer adds a bank-transfer payment method to the Arch suite: customers place the order, then see the shop's bank details and the amount to transfer on the confirmation page, and pay by wire.

---

`arch_payment_transfer` is a configurable gateway submodule of `arch_payment`. It registers a
`transfer` `PaymentMethod` plugin (`Plugin\PaymentMethod\Transfer`, extending
`ConfigurablePaymentMethodBase` and implementing `CheckoutCompleteInterface`) with a settings form
that stores, per currency, the shop's bank details in the `arch_payment_transfer.settings` config
object: business name, account number, bank provider, BIC and IBAN, plus an optional custom
complete message; the per-order "announcement" reference is the order number. On the
checkout-complete page the plugin's `checkoutCompleteInfo()` renders those details (iterating the
config schema mapping) together with the order grand total (formatted via `arch_price`). Its
`callback_route` is `arch_payment_transfer.success` (`/payment/transfer/success`), whose controller
just redirects the buyer on to `arch_checkout.complete`; being an offline method, there is no online
payment step to verify (a `@todo` notes that a payment-information email is not yet sent). Enable it
from the payment-methods admin and fill in the bank details per currency. Depends on `arch` and
`arch_payment`; ships a config schema (`arch_payment_transfer.config`).

---

- Offer bank/wire transfer as a checkout payment option.
- Show the shop's bank account details on the order-confirmation page.
- Display the exact amount (grand total) the customer must transfer.
- Give the customer the order number as the transfer reference ("announcement").
- Configure business name, account number and bank provider for transfers.
- Configure BIC and IBAN for international transfers.
- Provide different bank details per currency.
- Show a custom "complete" message for transfer orders.
- Enable or disable bank transfer from the payment-methods admin.
- Restrict transfer to certain orders via `hook_payment_method_access()`.
- Add a transfer handling fee via `hook_payment_method_fee_alter()`.
- Redirect the buyer to the confirmation page after placing a transfer order.
- Serve as a reference for a configurable `PaymentMethod` plugin with a settings form.
