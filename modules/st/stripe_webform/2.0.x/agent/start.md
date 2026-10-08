# Stripe Webform Integration — agent index

Adds Stripe payment elements + a Stripe Webform handler on top of the base `stripe` and `webform`
modules. **No config UI (`configure` null), no permissions, no schema, no Drush.** Stripe API keys and
the signature-verified webhook route live in the base **`stripe`** module, not here.

- **The `stripe` handler (customer/subscription creation on submit) + its settings** →
  [configure/handler.md](configure/handler.md)
- **The two Webform elements (`stripe`, `stripe_paymentrequest`) and their properties** →
  [plugins/elements.md](plugins/elements.md)
- **Event subscriber (payment + webhook), the `stripe_webform.webhook` event / Rules event** →
  [api/events.md](api/events.md)

Key facts:
- Webform elements: `stripe` (credit card), `stripe_paymentrequest` (Payment Request button), both
  extending `StripeWebformElementBase` (composite, category "Stripe").
- Webform handler id `stripe` (`StripeWebformHandler`) — runs in `postSave()`, uses the Stripe PHP SDK
  with the secret key from `stripe.settings` to create a Customer and optional Subscription.
- Payment amount/billing fed into the base module's PaymentIntent via `StripeEvents::PAYMENT`
  (`handleStripePayment`).
- Inbound webhooks: base `stripe` module verifies the Stripe signature and fires `StripeEvents::WEBHOOK`;
  `handleStripeWebhook` checks `metadata.uuid == system.site uuid` then dispatches
  `stripe_webform.webhook` (also a Rules event) with the matching `webform_submission`.
- Do NOT enable AJAX or wizard pages on a Stripe webform (client-side payment breaks).
