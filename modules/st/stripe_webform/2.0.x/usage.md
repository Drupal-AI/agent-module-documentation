Bridges the [Stripe](https://www.drupal.org/project/stripe) and [Webform](https://www.drupal.org/project/webform) modules: it adds Stripe payment elements (credit-card and Payment Request button) to Webforms plus a Webform handler that creates Stripe customers and subscriptions on submission.

---

The module provides two Webform elements — `stripe` (credit card) and `stripe_paymentrequest` (Apple/Google Pay-style Payment Request button) — both extending `StripeWebformElementBase`, which contributes a large set of per-element properties (amount, currency, label, billing name/email/address, subscription flag, `#webform_stripe_amount_multiply`, etc.) and supports Webform tokens. The card is collected and the PaymentIntent is created client-side by the base `stripe` module's JS; this module's `StripeWebformEventSubscriber::handleStripePayment()` listens to the base module's `StripeEvents::PAYMENT` event to feed amount/label/billing details from the element into the payment. A `stripe` **Webform handler** (`StripeWebformHandler`) runs in `postSave()`: it reads the processed PaymentIntent, retrieves the secret API key from `stripe.settings`, and via the Stripe PHP SDK creates a Customer (and optionally a Subscription from a configured price id), attaching webform metadata (site uuid, webform id, submission id). Inbound webhooks are handled by the base `stripe` module (which verifies the Stripe signature); this module only subscribes to that module's `StripeEvents::WEBHOOK` event and, after confirming the event's `metadata.uuid` matches this site's uuid, dispatches its own `stripe_webform.webhook` event (also exposed as a Rules event) carrying the matching webform submission. The module has no config UI, permissions, schema, or Drush commands of its own; it warns against AJAX and wizard webforms (payments happen client-side and break across pages). Stripe API keys live in the base `stripe` module's config.

---

- Accept a one-off credit-card payment on a Webform (donation, order, fee).
- Add an Apple Pay / Google Pay Payment Request button to a Webform.
- Charge a fixed amount, or a token-driven dynamic amount, per submission.
- Enter the amount in dollars and auto-multiply by 100 to Stripe cents (`amount_multiply`).
- Create a recurring Stripe subscription from a submission (via a configured price id + quantity).
- Create a Stripe Customer on submission with billing name/email/address from form fields.
- Attach webform metadata (site uuid, webform id, submission id) to the Stripe Customer/Subscription.
- Pass additional Stripe API fields via YAML "customer create" / "subscription create" advanced settings.
- Add arbitrary Stripe metadata (YAML, token-aware) to the created objects.
- Prefill billing details (city, country, address, postal code, phone) from form values.
- Send a Stripe receipt email using a form-provided address.
- Enforce Stripe's per-currency minimum charge amount at element validation time.
- React to Stripe webhooks for a specific submission via the `stripe_webform.webhook` event.
- Trigger Rules on the `stripe_webform.webhook` event (e.g. mark a submission paid on `invoice.paid`).
- Share one payment configuration across multiple Stripe elements on a form (`stripe_shared`).
- Set the Stripe account country and currency per element.
- Use Webform tokens (including submission tokens) to populate amount, metadata, and billing fields.
- Support subscriptions by capturing the payment method for off-session future use.
- Build a paid registration/booking form combining Stripe elements with normal Webform fields.
- Warn editors away from AJAX and wizard webforms, which break the client-side payment flow.
- Combine with the base Stripe module's webhook endpoint (signature-verified) for post-payment automation.
