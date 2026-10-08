<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Stripe Alipay adds Alipay as a Stripe-backed payment method in Drupal Commerce. It creates a Stripe PaymentIntent for the order and redirects the shopper through Stripe's Alipay flow; on return it retrieves the PaymentIntent directly from Stripe and completes the Commerce payment only when Stripe reports it succeeded.

---

Install with Composer (`drupal/commerce_stripe_alipay`, which pulls in stripe/stripe-php) and enable it (depends on commerce_payment). Create a Stripe Alipay payment gateway and enter your Stripe secret and publishable keys and mode. Store the Stripe secret key as a secret. Payment state is driven by retrieving the PaymentIntent from the Stripe API (authoritative) and matching it to the stored payment by client secret -- request data is not trusted to mark orders paid.

---

- Offer Alipay via Stripe in Commerce checkout.
- Create a Stripe PaymentIntent per order.
- Redirect the shopper through Stripe's Alipay flow.
- Retrieve the PaymentIntent from Stripe on return.
- Complete payment only on PaymentIntent succeeded.
- Match the payment by intent id and client secret.
- Void the payment on failure/cancel.
- Support refunds and partial refunds through Stripe.
- Configure Stripe secret and publishable keys.
- Validate key/livemode against the Stripe Balance API.
- Dispatch success/failure events for other modules.
- Support live and test modes.
- Use the official stripe/stripe-php library.
- Store the Stripe secret key as a secret.
- Integrate with Commerce payment workflow.
- Prevent double-charging already-paid orders.
