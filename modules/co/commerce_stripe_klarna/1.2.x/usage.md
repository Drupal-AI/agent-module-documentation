<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Stripe Klarna adds Klarna as a Stripe-backed payment method in Drupal Commerce. It creates a Stripe PaymentIntent for the order and redirects the shopper through Stripe's Klarna flow; on return it retrieves the PaymentIntent from Stripe and completes the Commerce payment only when Stripe reports it succeeded. Ships with a default payment gateway config.

---

Install with Composer (`drupal/commerce_stripe_klarna`, which pulls in stripe/stripe-php) and enable it (depends on commerce_payment). A default Stripe Klarna gateway config is provided; edit it to enter your Stripe secret and publishable keys and mode. Store the Stripe secret key as a secret. Payment state is driven by retrieving the PaymentIntent from the Stripe API (authoritative) and matching it to the stored payment -- request data is not trusted to mark orders paid.

---

- Offer Klarna via Stripe in Commerce checkout.
- Create a Stripe PaymentIntent per order.
- Redirect the shopper through Stripe's Klarna flow.
- Retrieve the PaymentIntent from Stripe on return.
- Complete payment only on PaymentIntent succeeded.
- Match the payment to the intent before completing.
- Void the payment on failure/cancel.
- Support refunds and partial refunds through Stripe.
- Ship a default payment gateway config.
- Configure Stripe secret and publishable keys.
- Validate key/livemode via the Stripe Balance API.
- Support live and test modes.
- Use the official stripe/stripe-php library.
- Store the Stripe secret key as a secret.
- Integrate with Commerce payment workflow.
- Prevent marking already-paid orders paid again.
