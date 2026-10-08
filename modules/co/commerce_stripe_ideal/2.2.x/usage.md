<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Stripe iDEAL adds iDEAL (the Dutch bank-transfer method) as a Stripe-backed payment method in Drupal Commerce. It creates a Stripe PaymentIntent, redirects the shopper through iDEAL, and confirms payment both on return (retrieving the intent from Stripe) and via a Stripe webhook whose signature it verifies.

---

Install with Composer (`drupal/commerce_stripe_ideal`, which pulls in stripe/stripe-php) and enable it (depends on commerce_payment). Create a Stripe iDEAL gateway and enter the Stripe secret key, publishable key, and the webhook signing secret, then register the webhook URL in your Stripe dashboard. Store the secret and signing key as secrets. The onNotify webhook verifies the Stripe-Signature header via Stripe\Webhook::constructEvent and rejects invalid signatures.

---

- Offer iDEAL via Stripe in Commerce checkout.
- Create a Stripe PaymentIntent per order.
- Redirect the shopper through the iDEAL flow.
- Retrieve the PaymentIntent from Stripe on return.
- Verify the Stripe-Signature on webhook calls.
- Reject webhooks with an invalid signature.
- Complete payment on payment_intent.succeeded.
- Void payment on payment_intent.payment_failed.
- Configure a webhook signing secret.
- Support refunds and partial refunds.
- Store the returned payment method on the order.
- Validate key/livemode via the Stripe Balance API.
- Support live and test modes.
- Use the official stripe/stripe-php library.
- Store Stripe secret and signing keys as secrets.
- Integrate with Commerce payment workflow.
