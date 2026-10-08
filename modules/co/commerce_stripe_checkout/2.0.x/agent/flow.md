<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Payment flow (session build + return handling)

## 1. Off-site form → Stripe Checkout Session

`PluginForm/CommerceStripeCheckoutCheckoutForm::buildConfigurationForm()`:

1. Resolves the secret key for the active `mode`; bails (admin log + generic buyer error) if the key
   is empty or `\Stripe\Stripe` is missing.
2. Builds `line_items` from `$order->getItems()` — one `price_data` per order item using
   `getUnitPrice()` × quantity, amounts via `StripeAmountTrait::toStripeAmount()` (zero-decimal aware).
3. Generates a one-time `stsess = Crypt::randomBytesBase64(32)` and builds absolute `success_url` /
   `cancel_url` pointing at this module's routes, each carrying `?stsess=<token>`.
4. Assembles `$session_params`: `line_items`, `mode: 'payment'`, `success_url`, `cancel_url`,
   `client_reference_id = (string) $order->id()`, and `metadata = {drupal_order_id, drupal_site}`.
5. Adds `payment_method_types` (explicit, `card` enforced), per-method options (`wechat_pay`,
   `acss_debit`), optional `customer_email`, `allow_promotion_codes`, `billing_address_collection`,
   `phone_number_collection`, `locale`.
6. Invokes `hook_commerce_stripe_checkout_alter_session_params(&$params, $order)`.
7. `Stripe::setApiKey()` then `StripeSession::create()` in a retry loop that strips
   Stripe-rejected/inactive payment method types and retries.
8. Stores `stripe_order_id`, `stripe_session_id`, and `stsess` in the **PHP session** (no entity
   objects). Verifies `$session->url` starts with `https://`, then `buildRedirectForm(...,
   $session->url, [], REDIRECT_GET)` → Commerce redirects the buyer to Stripe.

No payment or order mutation happens during form build, so abandoned Stripe sessions leave no trace.

## 2. Success redirect — `StripeController::paymentSuccess()`

Route `commerce_stripe_checkout.paymentSuccess` = `/stripe-pay/success` (GET, `_access: TRUE`).
Steps, in order:

1. Read `?stsess`; reject (redirect to `<front>`) unless it strictly `===` the value in the PHP
   session.
2. **Immediately** `remove('stsess')` — before any processing — so a refresh/duplicate request
   cannot create a second payment.
3. Load the order from the session-stored `stripe_order_id` (never from the request).
4. **Ownership**: `(int) currentUser()->id() === (int) $order->getCustomerId()` (both 0 for
   anonymous); mismatch is logged and redirected away.
5. **Idempotency**: if the order state is not `draft` (already processed by a webhook or prior
   request), redirect to the checkout form without creating a payment.
6. Create a `commerce_payment` (`state: completed`, `amount: $order->getTotalPrice()`,
   `remote_id: <stripe_session_id>`, `remote_state: 'paid'`), `save()` it, then `save()` the order.
   Saving with a completed payment makes `$order->isPaid()` true → `ORDER_PAID` → Commerce's
   `OrderPaidSubscriber` applies the `place` transition and unlocks the order.
7. Add a success message (overridable via `hook_commerce_stripe_checkout_success_message`, filtered
   through `Xss::filterAdmin()`), clear session keys, redirect to `commerce_checkout.form`.

## 3. Cancel redirect — `StripeController::paymentCancel()`

Route `/stripe-pay/cancel` (GET). Validates + consumes `stsess`, loads the order, and — after an
ownership check — calls `commerce_stripe_checkout_change_payment_status_cancelled($order)`, which
applies the `cancel` workflow transition (only from `draft`/`validation`/`fulfillment`) and unlocks.
Shows a cancellation message (overridable via `hook_commerce_stripe_checkout_failure_message`),
clears session keys, redirects to `<front>`.

## Amounts — `StripeAmountTrait`

`toStripeAmount(string $amount, string $currency)` returns `(int) round($amount)` for the 16
zero-decimal currencies (`BIF, CLP, DJF, GNF, JPY, KMF, KRW, MGA, PYG, RWF, UGX, VND, VUV, XAF, XOF,
XPF`) and `(int) round($amount * 100)` otherwise. Shared by the form (line items) and the gateway
(refund amounts).

## Notes

- The plugin's own `onReturn()` only dispatches `PAYMENT_SUCCESS` — the real flow never routes
  through it because Stripe returns to the custom `success_url`.
- `onNotify()` and `createPaymentStorage()` reference request fields (`invoice_id`, `ep_id`,
  `message`) that are not part of the Stripe Checkout flow and are not used by it.
