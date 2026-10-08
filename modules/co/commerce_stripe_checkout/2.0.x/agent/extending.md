<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Refunds, hooks & events

## Refunds

The gateway implements `SupportsRefundsInterface`; full and partial refunds work through Commerce's
standard Refund UI. `CommerceStripeCheckoutCheckout::refundPayment(PaymentInterface $payment,
?Price $amount = NULL)`:

1. `assertPaymentState($payment, ['completed', 'partially_refunded'])`.
2. Requires a `remote_id` (the Stripe Checkout Session id, `cs_test_…`/`cs_live_…`) — payments
   created before webhook/refund support have none and must be refunded in the Dashboard.
3. `StripeCheckoutSession::retrieve($remote_id)` to obtain `payment_intent`; errors if the session
   has no PaymentIntent (e.g. subscription/bank-transfer).
4. `StripeRefund::create(['payment_intent' => $pi, 'amount' => <smallest unit>])` — `amount` is
   omitted for a full refund, and converted via `toStripeAmount()` for a partial one.
5. Updates the local payment to `refunded` or `partially_refunded` and sets the refunded amount.

## Hooks (implement with your module name as the prefix)

- `hook_commerce_stripe_checkout_alter_session_params(array &$session_params, OrderInterface $order)`
  — the primary extension point. Invoked (via `moduleHandler->invokeAll`) after the module builds the
  params and before `StripeSession::create()`. Every key of the Stripe Checkout Sessions create API is
  fair game: add `metadata`, `expires_at`, `shipping_address_collection` / `shipping_options`,
  `tax_id_collection`, `consent_collection`, `custom_text`, override `payment_method_options`, etc.
  Defined in `commerce_stripe_checkout.api.php`.
- `hook_commerce_stripe_checkout_success_message(&$message)` — override the post-success status
  message. The returned string is run through `Xss::filterAdmin()` + `Markup::create()`.
- `hook_commerce_stripe_checkout_failure_message(&$message)` — override the post-cancel message; same
  filtering.

## Events

Defined in `Event/CommerceStripeCheckoutEvents`; payload `CommerceStripeCheckoutPaymentEvent` carries
the order (`getOrder()`).

| Constant | Event name | Dispatched |
|---|---|---|
| `PAYMENT_SUCCESS` | `commerce_stripe_checkout.paymentSuccess` | Inside the plugin's `onReturn()`. |
| `PAYMENT_FAILURE` | `commerce_stripe_checkout.payment_failure` | Declared; fired only if `onReturn()`-style failure paths are wired. |

Note: the standard hosted-Checkout flow returns to the custom `success_url`/`cancel_url` handled by
`StripeController`, so `onReturn()` (and thus `PAYMENT_SUCCESS`) fires only if you route Commerce's
built-in return URL to this gateway. For reliable post-payment side effects prefer subscribing to
Commerce's own `ORDER_PAID`/order workflow events, which fire from both the redirect and webhook
paths.

## Module-level helpers (`commerce_stripe_checkout.module`)

- `commerce_stripe_checkout_change_payment_status_completed($payment, $order)` — set payment
  `completed` + save order (triggers `ORDER_PAID`).
- `commerce_stripe_checkout_change_payment_status_cancelled($order)` — apply the `cancel` transition
  (from `draft`/`validation`/`fulfillment`) + unlock + save.
- `commerce_stripe_checkout_log_messages($log_type, $message)` — thin logger wrapper.
- `hook_help` (full in-admin help page) and `hook_form_alter` (mode-based key-field visibility).
