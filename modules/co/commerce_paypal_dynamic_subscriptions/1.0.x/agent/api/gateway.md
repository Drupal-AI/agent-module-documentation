<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# PayPal Dynamic Subscriptions — agent notes

## Configuration
Gateway config: `client_id`, `secret`, `subscription_plan_id` (a plan created in the PayPal dashboard). Depends on `commerce_paypal`, which supplies the OAuth-authenticated Checkout SDK / HTTP client (sandbox vs live host).

## Checkout flow
- `PaymentOffsiteForm` renders the PayPal button; passes `Calculator::trim($order->getTotalPrice()->getNumber())` + currency for display, and stores `paypal_subscription_plan_id` on the order.
- Shopper approves at PayPal → returns with `?subscription_id=...`.
- `onReturn(OrderInterface $order, Request $request)` (DynamicSubscriptions.php ~135):
  1. `$sdk->getSubscription($subscription_id)` — server-to-server `GET /v1/billing/subscriptions/{id}` (merchant-authenticated).
  2. Rejects empty response.
  3. **Plan check:** `$subscription->plan_id !== $order->getData('paypal_subscription_plan_id')` → `PaymentGatewayException` (anti-spoofing).
  4. Creates a `completed` payment with `amount => $order->getTotalPrice()`, `remote_id => subscription->id`, `remote_state => subscription->status`.

## Observation (minor, not a finding)
`onReturn` completes the payment on plan-id match but does not explicitly assert `subscription->status` is ACTIVE/APPROVED (DynamicSubscriptions.php ~168-200). Amount is server-authoritative and the subscription is fetched with merchant credentials, so exposure is low; a hardening step would be to also gate on status.

## Events
`DynamicSubscriptionsEvents::SUBSCRIPTION_CREATE` / `SUBSCRIPTION_CANCEL` — subscribe to add custom redirect (cancel) or post-create logic.
