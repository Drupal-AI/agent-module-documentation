<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce PayPal Dynamic Subscriptions is an off-site Drupal Commerce payment gateway that starts recurring payments through the PayPal Subscriptions (Billing) API.
---
The gateway renders an off-site PayPal button (PaymentOffsiteForm) that redirects the customer to PayPal to approve a subscription against a configured PayPal subscription plan id; the order total number/currency are passed for display via `commerce_paypal`'s Checkout SDK. When PayPal returns the shopper to the site with a `subscription_id`, `onReturn()` fetches the subscription server-to-server through the merchant-authenticated PayPal API (`GET /v1/billing/subscriptions/{id}`) and verifies the returned `plan_id` matches the plan stored on the order before completing the payment — guarding against plan spoofing and checkout race conditions. The completed payment's amount is taken from `$order->getTotalPrice()` (server-authoritative), not from any client value, and the PayPal subscription id/status are stored on the order.

Cancel returns dispatch a `DynamicSubscriptionsCancelEvent` so a subscriber can supply a custom redirect, otherwise the shopper is returned to the previous checkout step. Create/cancel events (`DynamicSubscriptionsEvents`) provide extension points around subscription lifecycle. Set up by installing `commerce_paypal`, creating a subscription plan in the PayPal dashboard, and adding this gateway with your PayPal client id / secret and the plan id.
---
- Offer PayPal-managed recurring subscriptions in Drupal Commerce checkout
- Add an off-site PayPal Dynamic Subscriptions payment gateway
- Redirect shoppers to PayPal to approve a subscription plan
- Bind checkout to a configured PayPal subscription plan id
- Verify the returned subscription's plan id server-side against the order
- Complete the Commerce payment only after PayPal confirms the subscription
- Store the PayPal subscription id and status on the order
- React to subscription creation via DynamicSubscriptionsCreateEvent
- React to subscription cancellation via DynamicSubscriptionsCancelEvent
- Provide a custom redirect URL when a shopper cancels
- Fall back to the previous checkout step on cancel
- Use the order total as the authoritative payment amount
- Configure PayPal client id and secret per gateway
- Test against the PayPal sandbox before going live
- Log PayPal API errors to the module's logger channel
