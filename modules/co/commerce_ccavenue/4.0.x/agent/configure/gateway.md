<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce CCAvenue — configure the gateway

1. Enable `commerce_ccavenue` (requires `commerce_payment`).
2. Go to the payment gateways collection (`entity.commerce_payment_gateway.collection`,
   Commerce » Configuration » Payment gateways) and add a gateway.
3. Plugin: **CCAvenue Redirect** (`ccavenue_redirect`). Set:
   - **Merchant ID**, **Access Code**, **Working Key** (from your CCAvenue account),
   - **Default Currency** (INR/USD/SGD/GBP/EUR),
   - **Mode** (test/live — note both currently target production `secure.ccavenue.ae`).

## Flow
- `PaymentCCAvenueForm::buildConfigurationForm()` builds parameters (order id, amount from
  `$payment->getAmount()`, billing, redirect/cancel URLs), encrypts them with the working key and
  auto-POSTs to CCAvenue.
- `CCAvenueRedirect::onReturn()` decrypts `encResp` with the working key, reads status, and on
  `Success` creates a `commerce_payment` in state `authorization` with `amount = $order->getTotalPrice()`.
- `onCancel()` shows a resumable-checkout error.

## Notes for operators
- Amount is server-side (order total); the response amount is not used to set the charge.
- There is no separate checksum beyond successful working-key decryption, and the decrypted
  `order_id` is not compared to the current order in code.
