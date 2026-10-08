<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring Commerce Signifyd

1. Enable the module (pulls in commerce_order/log/payment).
2. **Global settings** — `/admin/commerce/config/signifyd/settings`: set the `decision_type` (`score`, `decision`, or guarantee), a score threshold, whether request logging is on, and per-order-type workflow: enable `workflow`, then pick the `approved` and `declined` transition ids.
3. **Add a team** — create a `signifyd_team` config entity holding the Signifyd API key. Multiple teams are supported; the webhook path carries the team id.
4. **Register the webhook** in the Signifyd dashboard pointing at `POST /webhook/signifyd/{signifyd_team}`. Signifyd signs each POST; the module verifies it.
5. Optionally enable `device_fingerprint` (injects Signifyd's JS fingerprint) and `user_order_data` (adds account-age signals to created cases).

Order lifecycle: `OrderPlaceSubscriber` creates a case, `OrderFulfillSubscriber` sends fulfillments, `OrderCancelSubscriber` handles cancellation. Incoming webhooks update the `signifyd_case` and, if `workflow` is enabled for the order type, apply the approved/declined transition when the transition is allowed.
