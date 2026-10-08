<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Trinion Cart Tinkoff Payment integrates the Tinkoff (T-Bank) payment gateway with the Trinion Cart commerce stack, sending customers to Tinkoff to pay and confirming orders from a signed server callback.
---
The `TinkoffMerchantAPI` service wraps the Tinkoff v2 REST API (`https://securepay.tinkoff.ru/v2/`) to init payments and build the SHA-256 request token from the merchant terminal key and secret. `TinkoffController` exposes three routes: `tinkoff/complete` (the gateway callback, `access content`), and `payment/success` / `payment/error` (`access checkout`) which just render thank-you/error markup. On the callback, the controller reads the raw `php://input` JSON, loads the order node by `OrderId`, recomputes the Tinkoff token via `get_tinkoff_token()` (ksort of the params plus the configured `secret_key`, SHA-256) and rejects the request unless it equals the posted `Token`; only then, on `Status == CONFIRMED`, does it call `trinion_cart.payment` `processPayment` and dispatch a `PAYMENT_SUCCESS` event. Settings (terminal key, secret key, etc.) live at `/admin/config/system/trinion-tinkoff` behind `administer trinion_cart_tinkoff_payment configuration`.

Operational notes: the inbound callback is signature-verified (the SHA-256 token check gates order fulfilment), and the callback is idempotent-ish (returns early if already `payment_received`). The callback route being `access content` is acceptable here only because the token check enforces authenticity. Setup: enter the Tinkoff terminal/secret keys on the settings form and configure Trinion Cart to use this gateway.
---
- Configure Tinkoff terminal key and secret key at `/admin/config/system/trinion-tinkoff`.
- Enable the Tinkoff gateway for Trinion Cart checkout.
- Redirect a customer to Tinkoff to complete payment.
- Receive the Tinkoff `tinkoff/complete` server callback.
- Verify the callback SHA-256 token against the secret key.
- Confirm an order only on a valid `CONFIRMED` status.
- Reject callbacks whose token does not match.
- Show a thank-you page at `payment/success`.
- Show an error page at `payment/error`.
- Dispatch a `PAYMENT_SUCCESS` event on confirmed payment.
- Call `trinion_cart.payment` processPayment on confirmation.
- Load the order node by `OrderId` from the callback.
- Short-circuit if the order is already `payment_received`.
- Grant `administer trinion_cart_tinkoff_payment configuration` to store admins.
- Log the raw callback payload to the `payment` channel.
- Build the Tinkoff request token via `TinkoffMerchantAPI`.
- Translate the gateway UI via the bundled translations.
- Map the gateway under the Trinion base config menu.
