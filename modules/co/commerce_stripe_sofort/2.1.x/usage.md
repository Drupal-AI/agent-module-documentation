<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Stripe Sofort provides an off-site payment gateway for the Sofort payment method through Stripe, completing orders from a Stripe webhook that re-verifies the charge server-side.
---
The gateway plugin (`src/Plugin/Commerce/PaymentGateway/StripeSofort.php`) and offsite form set up the Sofort/Stripe redirect, and a `StripeWebhookController` (`src/Controller/StripeWebhookController.php`) receives Stripe's asynchronous notification at `/stripe-sofort-webhook`. On webhook, `capture()` reads the JSON body and `updateOrder()` takes only the charge id, **re-fetches the charge from Stripe** (`Charge::retrieve($chargeId)`), derives the order from the re-fetched charge's `source.metadata.order_id`, and completes the order only when the authoritative `$charge->paid == TRUE`. A `commerce_log` category/template set records payment events.

Setup: add a "Stripe Sofort" gateway with your Stripe API keys, configure the Stripe webhook to point at `/stripe-sofort-webhook`, and enable the Sofort payment method in Stripe. The module also emits a `CommerceStripeSofortEvent` for custom reactions.
---
- Accept Sofort payments through Stripe in Commerce.
- Redirect shoppers off-site for Sofort authorization.
- Receive Stripe webhooks for asynchronous confirmation.
- Re-fetch the charge from Stripe before completing an order.
- Complete orders only when Stripe reports the charge paid.
- Derive the order from the charge's source metadata.
- Configure Stripe API keys per gateway.
- Point the Stripe webhook at /stripe-sofort-webhook.
- Log payment events via commerce_log templates.
- Dispatch a CommerceStripeSofortEvent for custom logic.
- Support the EU Sofort bank-transfer method.
- Integrate with the Commerce checkout flow.
- Handle Stripe charge lifecycle server-side.
- Avoid trusting the webhook body's paid status.
- Provide an offsite payment form for Sofort.
- Map Stripe charges to Commerce payments.
- Enable Sofort in the Stripe dashboard.
- Use for EU stores accepting Sofort.
