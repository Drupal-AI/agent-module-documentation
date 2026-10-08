<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Stripe Sofort (commerce_stripe_sofort) — agent index
**Off-site Commerce gateway for Sofort via Stripe; a webhook re-fetches the charge from Stripe before completing orders.**

- **Version:** 2.1.x
- **Core:** ^8 || ^9 || ^10
- **Depends on:** `commerce:commerce_payment`
- **Gateway:** `StripeSofort` offsite plugin + `PluginForm/StripeSofort/PaymentOffsiteForm`.
- **Webhook:** route `commerce_stripe_sofort.stripe_webhook_controller_capture` → `/stripe-sofort-webhook`, `_custom_access` = `StripeWebhookController::authorize`. `capture()` → `updateOrder()` re-fetches the charge via `Charge::retrieve()` and completes only when `$charge->paid`.
- **Events/logs:** `CommerceStripeSofortEvent`; `commerce_log` category/template set.
- **Security:** Order completion never trusts the webhook body's paid status.
