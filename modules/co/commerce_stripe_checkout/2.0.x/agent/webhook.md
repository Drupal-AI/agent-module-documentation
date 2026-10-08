<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webhook handling

`StripeWebhookController::webhookHandler(Request $request, string $gateway_id)`.

Route `commerce_stripe_checkout.webhook` = `/stripe-pay/webhook/{gateway_id}`, `methods: [POST]`,
`_access: 'TRUE'`, `options.no_cache: TRUE`. The `{gateway_id}` path segment is the
`commerce_payment_gateway` config entity id, so a site can run several Stripe gateways each with its
own endpoint. The webhook is the asynchronous / fallback confirmation path: if the browser success
redirect never happens (tab closed, network drop) or the method settles later, the webhook still
records the payment.

## Handler steps

1. 503 if `\Stripe\Stripe` is missing; 400 on an empty payload.
2. Load the gateway entity by `gateway_id` (404 if unknown); read its config, pick the secret key for
   `mode`, `Stripe::setApiKey()` (503 if no key configured).
3. **Signature verification**: when `webhook_secret` is set, `Stripe\Webhook::constructEvent($payload,
   $request->headers->get('Stripe-Signature'), $webhook_secret)` — a bad signature returns HTTP 400
   (`SignatureVerificationException`), invalid JSON/values return 400. Configuring the signing secret
   is the required production step so every event is verified before it is acted on.
4. Dispatch on `$event->type`; unhandled types return HTTP 200 (so Stripe does not retry).

## Events handled

| Stripe event | Handler | Action |
|---|---|---|
| `checkout.session.completed` | `handleSessionCompleted()` | Create the completed payment + place the order (if still `draft`). |
| `checkout.session.async_payment_succeeded` | `handleSessionCompleted()` | Same as completed. |
| `checkout.session.async_payment_failed` | `handleAsyncPaymentFailed()` | Log a warning; the order stays `draft` for retry. |
| `checkout.session.expired` | `handleSessionExpired()` | If still `draft`, `unlock()` + `save()` so the buyer can start over. |

## `handleSessionCompleted()`

- Order id from `$stripe_session->metadata->drupal_order_id` (set by the form); missing id or missing
  order is logged and skipped.
- **Idempotency**: if the order state is not `draft`, log info and return (the success redirect
  already handled it) — a webhook + redirect race can never create duplicate payments.
- Otherwise create a `commerce_payment` (`state: completed`, `amount: $order->getTotalPrice()`,
  `remote_id: $stripe_session->id`, `remote_state: $stripe_session->payment_status ?? 'paid'`),
  `save()` payment then order → `ORDER_PAID` → place + unlock.

Returns HTTP 200 on all handled/ignored cases; 400/404/503 only on the failure conditions above.
Register the endpoint in Stripe → Developers → Webhooks with events
`checkout.session.completed`, `checkout.session.async_payment_succeeded`,
`checkout.session.async_payment_failed`, `checkout.session.expired`.
