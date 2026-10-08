<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Signifyd connects Drupal Commerce to Signifyd, the fraud-protection and chargeback-guarantee service. When an order is placed it creates a Signifyd "case", sends order/fulfillment data, receives risk scores and decisions back via webhooks, and can automatically move the order through configured workflow transitions (approve/decline) based on score, decision, or guarantee.

---

A `signifyd_team` config entity holds each team's API key; a `signifyd_case` content entity stores the case id, order id, score, guarantee, decision and status. The `SignifydClient` talks to the Signifyd REST API (default Guzzle TLS verification). Inbound webhooks hit `POST /webhook/signifyd/{signifyd_team}` (route `_access: TRUE`) and are authenticated by recomputing an HMAC-SHA256 of the raw body with the team's API key and comparing it to the `X-SIGNIFYD-SEC-HMAC-SHA256` header — an unsigned or mismatched request is rejected with 400 before any order state changes. A documented `ABCDE` test key is accepted **only** for the `cases/test` topic (Signifyd's webhook-test placeholder, which has no case). Two sub-modules ship: `device_fingerprint` (adds Signifyd's device-fingerprint script) and `user_order_data` (adds account age data to cases).

Setup: enable the module, configure global settings at `/admin/commerce/config/signifyd/settings`, add a Signifyd team with its API key, register the webhook URL in the Signifyd dashboard, and choose the order-workflow transitions per order type. Cases are listed at the Signifyd cases view.

---

- Configure global Signifyd settings and decision type
- Add a Signifyd team with its API key
- Register the webhook URL in the Signifyd dashboard
- Choose approve/decline workflow transitions per order type
- Create a case automatically when an order is placed
- Send fulfillment data to Signifyd on order fulfilment
- Cancel/guarantee handling on order cancel
- Receive case creation/rescore/review webhooks
- Receive decision-made webhooks and map actions to guarantees
- Auto-move orders by score threshold
- Auto-move orders by decision (ACCEPT/REJECT)
- Auto-move orders by guarantee disposition
- View stored cases in the Signifyd cases view
- Enable the device-fingerprint sub-module
- Enable the user-order-data sub-module for account-age signals
- Subscribe to `SignifydEvents::SIGNIFYD_WEBHOOK` to react to updates
- Enable request logging for webhook debugging
- Inspect a `signifyd_case` entity's score/decision/guarantee
- Test the webhook wiring with Signifyd's `cases/test` topic
- Grant Commerce admins access to the settings via `access commerce administration pages`
