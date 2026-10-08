<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# esewa — gateway configuration & callback flow

## Set up
`/admin/commerce/config/payment-gateways` → add a gateway using the **eSewa** plugin (`EsewaCheckoutCheckout`). Supply eSewa merchant/product code + secret and choose test or live mode. It is an off-site redirect gateway.

## Checkout → redirect
The plugin signs the request via the eSewa SDK and redirects the customer to eSewa, storing in the session: `esewa_order_id`, `esewa_gateway_id`, `esewa_transaction_uuid`, `esewa_total_amount`, `esewa_is_test`.

## Success callback — `/esewa/success?data=<base64>`
`EsewaController::paymentSuccess()` verifies, in order:
1. Session integrity (order/gateway/uuid present).
2. Order + gateway load.
3. `data` present → SDK `verifyPayment()` checks the **HMAC-SHA256** signature (throws on mismatch).
4. `transaction_uuid` equals the session value (replay protection).
5. `status === 'COMPLETE'`.
6. Returned `total_amount` within ±0.01 of the stored total.
Only then: `completePayment()`, advance `checkout_step` to `complete`, save, clear session. Failures redirect back to checkout and log to the `esewa` channel.

## Cancel callback — `/esewa/cancel`
Clears session, unlocks the order (its own route bypasses Commerce's cancel controller), steps the order back to the previous checkout step, and redirects to checkout/cart.

## Hooks
`hook_esewa_success_message(&$message)` and `hook_esewa_failure_message(&$message)` customise the shown message.

Both routes are intentionally `_access: 'TRUE'`; security rests on the signature + session + amount checks above.
