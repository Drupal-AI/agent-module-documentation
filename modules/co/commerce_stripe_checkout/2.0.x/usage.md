<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Stripe Checkout integrates Stripe's hosted Checkout page as a Drupal Commerce off-site payment gateway, redirecting the buyer to Stripe to pay and confirming the order on return and via webhook.

---

Commerce Stripe Checkout provides a Drupal Commerce payment gateway built on Stripe Checkout — the
customer is redirected to Stripe's hosted checkout page to pay (no card data touches the site), and
Stripe notifies the site of the result both through a return redirect and through a webhook. The
webhook controller verifies each request with `Stripe\Webhook::constructEvent()` using the
`Stripe-Signature` header and the configured webhook signing secret (`whsec_…`), returning HTTP 400
for requests whose signature does not validate. It depends on the Commerce order/cart/payment stack.

**Configure the webhook signing secret as part of production setup.** Copy the `whsec_…` signing
secret from your Stripe Dashboard webhook endpoint into the gateway's webhook field; with it set,
every incoming webhook event is signature-verified before it is acted on. Store the Stripe secret key
and the webhook signing secret as secrets (environment variables / Key entities), not in committed
config. The redirect flow uses only the secret key — there is no publishable key.

---

- Accept payments via Stripe's hosted Checkout page.
- Redirect customers off-site to Stripe to pay.
- Keep card entry on Stripe's hosted page (no card data on the site).
- Confirm the order on the return redirect and via webhook.
- Verify Stripe webhooks via `constructEvent` when the signing secret is set.
- Use the `Stripe-Signature` header to verify events.
- Return HTTP 400 for webhooks with an invalid signature.
- Configure the webhook signing secret (`whsec_`).
- Set the signing secret as part of production setup.
- Store the Stripe secret key as a secret.
- Store the webhook signing secret as a secret.
- Depend on the Commerce payment stack.
- Create Commerce payments against orders.
- Handle async webhook notifications (SEPA, ACH, Boleto, etc.).
- Map Stripe checkout-session events to payment state.
- Switch between Stripe test and live secret keys.
- Offer up to 57 selectable Stripe payment methods.
- Support full and partial refunds via the Commerce UI.
- Convert amounts for zero-decimal currencies automatically.
- Reconcile Stripe events with orders via session metadata.
