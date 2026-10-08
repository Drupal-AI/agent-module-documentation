<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Integrate Drupal with the Chargebee subscription-billing service.

---

Integration Chargebee integrates Drupal with the Chargebee payment/subscription-billing service — so users can subscribe to plans (hosted checkout) and the site tracks their subscriptions, with plan management and a payment-return flow.

Security: the `/payment-success` return handler DOES re-fetch the subscription server-side from Chargebee (`Subscription::retrieve($sub_id)`) — a good verification — BUT (as shipped, 10.0.2) it records the retrieved subscription against the **current user's uid without checking the subscription's customer belongs to that user**, so a user who obtains any valid `sub_id` can claim it as their own Active subscription (entitlement / IDOR). Store the Chargebee API key securely (env-backed). Verify subscription ownership before recording. Supports Drupal 9, 10, and 11.

---

- Integrate Chargebee subscriptions.
- Offer hosted-checkout plans.
- Track user subscriptions.
- Re-fetch the subscription server-side.
- NOTE: no owner check on sub_id (IDOR).
- Bind subscriptions to current uid unchecked.
- Store the API key securely.
- Verify ownership before recording.
- Depend on Drupal core only.
- Support Drupal 9, 10, and 11.
- Configure plans.
- Handle subscription billing.
- Support Drupal.
- Support Drupal.
- Support Drupal.
