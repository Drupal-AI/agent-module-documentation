# Configuration

## Open the settings form

1. Log in as a user with the **Administer Stripe API** (`administer stripe api`)
   permission.
2. Go to **Configuration → Web services → Stripe API**
   (`/admin/config/services/stripe_api`).

## Test and live keys

Stripe issues two sets of API keys — one for test mode and one for live mode —
and the settings form lets you supply both and choose which is active. Point the
secret-key setting at the **Key entity** you created during installation (backed
by an environment variable) rather than pasting the raw key into the form, so the
secret never lands in exported configuration. Use your test keys while building
and switch to live only when you are ready to take real payments.

## The webhook endpoint

The module exposes a single webhook route at **`/stripe/webhook`**. In your
Stripe dashboard, add a webhook endpoint pointing at that URL on your site, then
copy the **signing secret** Stripe generates for it into the module's
configuration. That signing secret is what lets the module verify each incoming
event: it calls the official SDK's `Webhook::constructEvent()`, which checks
Stripe's HMAC signature against the secret, enforces a timestamp tolerance, and
uses a constant-time comparison. Events that fail this check are rejected with a
403 and are never dispatched into Drupal.

You can also **disable webhook handling entirely** from configuration if your
site only makes outbound Stripe calls and does not need to receive events.

## Good practice for anything that moves money

Stripe API turns verified webhooks into Drupal events that other modules
subscribe to. When you (or a developer) write such a subscriber, treat the event
payload as a starting point rather than the last word: for anything that grants
access or fulfils an order, re-fetch the relevant object directly from Stripe
before acting on it.

## Save

Save the form to store your settings. With valid keys and a configured signing
secret, the module is ready for other modules to build payment and subscription
features on top of it.
