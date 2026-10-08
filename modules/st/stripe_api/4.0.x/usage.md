<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Stripe API wires the official Stripe PHP library into Drupal — credential storage, a pre-configured client service, and a webhook endpoint that other modules subscribe to.

---

It is infrastructure rather than a payment feature: it does not take a payment or add a checkout button, it makes the Stripe library available and turns Stripe's callbacks into Drupal events, so a subscription module, a donation form or a commerce integration can build on one authenticated client and one webhook instead of each inventing both. Install it with Composer (`composer require drupal/stripe_api -W`), which pulls in `stripe/stripe-php`, and enable it together with its hard dependency, the **Key** module. Configure it at **Configuration → Web services → Stripe API** (`/admin/config/services/stripe_api`, permission **Administer Stripe API**): choose **test** or **live** mode, and for each mode select the Key entities that hold your Stripe **secret key**, **publishable key** and webhook **signing secret**. Because the credential fields use Key's `key_select`, only the Key entity id is stored in configuration — the recommended pattern is a Key backed by an environment variable, so the raw secret never lands in the database or in exported config. Developers use the module by injecting the `@stripe_api.stripe_api` service and calling `getStripeClient()` to get a `\Stripe\StripeClient` that already carries the configured key and API version. To receive events, register the webhook URL shown on the settings form (`/stripe/webhook`) in the Stripe Dashboard, paste that endpoint's signing secret into the matching field, and write an event subscriber for the `stripe_api.webhook` event (a `StripeApiWebhookEvent` exposing `->type` and the full `\Stripe\Event`). A site-wide warning message appears while the module is in **test** mode, and webhook handling can be switched off entirely from configuration for sites that only make outbound Stripe calls.

---

- Provide a shared, authenticated Stripe client to other modules.
- Inject the `@stripe_api.stripe_api` service into a custom class.
- Call the Stripe API from PHP with `getStripeClient()`.
- Store a Stripe secret key in a Key entity instead of config.
- Keep Stripe credentials out of exported configuration.
- Switch between Stripe test and live mode.
- Pin a custom Stripe API version, or use the account default.
- Receive Stripe webhooks at `/stripe/webhook`.
- Subscribe to the `stripe_api.webhook` event in a custom module.
- React to a `checkout.session.completed` event.
- React to an `invoice.paid` or payment-succeeded event.
- Handle a failed-payment or refund notification.
- Drive a subscription or recurring-billing lifecycle.
- Build a donation integration on top of the client.
- Support a Drupal Commerce Stripe integration.
- Grant licensed or membership access after a Stripe event.
- Register the webhook endpoint URL in the Stripe Dashboard.
- Override the webhook signing secret via an environment variable.
- Log incoming Stripe webhook events for debugging.
- Disable incoming webhook handling entirely.
- Test the Stripe connection from the settings form.
- Read the current mode, API key, or publishable key in code.
- Re-fetch a Stripe object from the client before acting on an event.
- Provide separate test and live key configuration side by side.
