# Stripe — agent index

Low-level Stripe integration: stores API keys, loads Stripe.js everywhere, provides Form API
payment elements, and dispatches Stripe webhooks as Symfony events. It is a **payment
primitive**, not a store — you build the checkout. Requires the `stripe/stripe-php` SDK.

- **Settings form, config keys, environment, providing secret keys via settings.php** →
  [configure/settings.md](configure/settings.md)
- **Form elements (`stripe`, `stripe_paymentrequest`), the webhook endpoint, and the two
  events** → [api/elements-events.md](api/elements-events.md)
- **React to payments/webhooks: write an event subscriber** →
  [extend/event-subscriber.md](extend/event-subscriber.md)

Key facts:
- Config route `stripe.settings` = `/admin/config/system/stripe`; permission `administer stripe`.
- Config object `stripe.settings`: `environment` (`test`|`live`), `apikey.<env>.public`,
  `apikey.<env>.secret`, `apikey.<env>.webhook`.
- Webhook: `POST /stripe/webhook` (`stripe_api.webhook`, no_cache), dispatches
  `StripeEvents::WEBHOOK` (`stripe.webhook`).
- Render elements: `stripe` (card), `stripe_paymentrequest` (Apple/Google Pay).
- Second event `StripeEvents::PAYMENT` (`stripe.payment`) to adjust amount before confirm.
- Submodule `stripe_examples` (documented under `modules/`) = working checkout demo.
