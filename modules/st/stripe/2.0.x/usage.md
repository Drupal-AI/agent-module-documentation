Stripe is a low-level integration module that wires the official `stripe/stripe-php` SDK and Stripe.js into Drupal: it stores API keys, loads Stripe.js on every page, provides credit-card and payment-request form elements, and exposes a webhook endpoint as an event.

---

The module is a building block for taking Stripe payments, not a ready-made store. It provides
an admin settings form (`stripe.settings`, route `/admin/config/system/stripe`, permission
`administer stripe`) to store the **environment** (`test`/`live`) and, per environment, the
**publishable**, **secret** and **webhook signing** keys (config object `stripe.settings`,
keys `apikey.<env>.public|secret|webhook`). It attaches Stripe.js (`https://js.stripe.com/v3/`)
on every page via `hook_page_attachments` for fraud detection, and ships two Form API render
elements — `stripe` (a card element, class `CC`) and `stripe_paymentrequest` (Payment
Request / Apple Pay / Google Pay button, class `PaymentRequest`) — both extending `StripeBase`,
which creates a PaymentIntent and manages the client-side confirmation. It defines a webhook
controller at `POST /stripe/webhook` that verifies the signature (or falls back to re-fetching
the event) and dispatches a `StripeEvents::WEBHOOK` event carrying the Stripe `Event`; a second
event `StripeEvents::PAYMENT` lets modules adjust the amount/metadata of a payment before it is
confirmed (see `StripePaymentEvent`). The `stripe_examples` submodule shows an end-to-end
checkout form, block and event subscriber. Keys are config, so the module recommends providing
secret keys via `settings.php` rather than committing exported config.

---

- Store Stripe test and live API keys and switch between them with one environment toggle.
- Load Stripe.js site-wide so Stripe's fraud/risk signals work across pages.
- Add a Stripe card (`stripe`) element to a custom Form API form to collect a payment.
- Add a Payment Request button (Apple Pay / Google Pay) via the `stripe_paymentrequest` element.
- Create a PaymentIntent from Drupal and confirm it client-side with Stripe.js.
- Receive Stripe webhooks at /stripe/webhook and react to them via an event subscriber.
- Verify webhook signatures using the stored webhook signing secret.
- Adjust a payment's total or metadata server-side before confirmation via the PAYMENT event.
- Build a custom donation form that charges a card through Stripe.
- Take a one-off payment on a custom "checkout" page without Drupal Commerce.
- Fulfil orders when a `payment_intent.succeeded` webhook arrives.
- Update a user's membership/role when a Stripe subscription webhook fires.
- Keep secret keys out of version control by setting them in settings.php.
- Integrate Stripe into a Webform or custom form using the provided elements.
- Provide separate test-mode keys for a staging environment.
- Send billing/shipping details to Stripe by massaging the payment element's post data.
- Log or audit incoming Stripe events through a WEBHOOK event subscriber.
- Trigger CRM/email actions on successful payments via webhook events.
- Prototype a paid feature quickly using the stripe_examples simple checkout form/block.
- Confirm payments that require SCA/3D-Secure using PaymentIntents.
- Use the module as the payment primitive under a bespoke e-commerce flow.
- Charge different amounts per form by overriding the total in a PAYMENT event subscriber.
- Display a reusable checkout block on any page (via the examples submodule pattern).
