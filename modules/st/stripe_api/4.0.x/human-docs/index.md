# Stripe API — manual setup guide

**Stripe API** (`stripe_api`) wires the official Stripe PHP library into Drupal.
It does not, by itself, take a payment or add a checkout button — it is
infrastructure that other modules build on. It gives you three things: secure
storage for your Stripe API keys (through the Key module), a ready-to-use Stripe
client service (`@stripe_api.stripe_api`) that a developer can inject into any
custom class, and a webhook endpoint at `/stripe/webhook` that validates incoming
Stripe events and re-broadcasts them as Drupal events your code can subscribe to.

The problem it solves is duplication and risk: rather than every subscription,
donation, or commerce integration inventing its own authenticated Stripe client
and its own webhook verification, they can all share one correctly-built
foundation. And the webhook handling here is worth singling out as a reference
implementation. The `/stripe/webhook` route accepts POST requests only, and its
security is a cryptographic signature check: it calls the official SDK's
`Webhook::constructEvent()`, which verifies Stripe's HMAC signature against your
endpoint's signing secret, enforces a timestamp tolerance, and uses a constant-time
comparison. A transient processing failure returns a 503 with a `Retry-After`
header so Stripe retries later instead of assuming the event was delivered — the
detail most home-grown integrations get wrong.

Stripe API **requires the Key module** as a hard dependency, which is deliberate:
your Stripe secret key lives in a Key entity backed by an environment variable,
so it never ends up in exported configuration or version control. One thing worth
knowing: the safety of the events it dispatches depends on their subscribers — a
subscriber that acts on an event's contents without re-fetching the object from
Stripe is trusting a payload, and re-fetching is the standard advice for anything
that moves money.

This guide is written for a **human** setting the module up. If you are an AI
coding agent, read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, set up the Key
   module, and enable Stripe API.
2. [Configuration](configuration/index.md) — enter your keys, choose test vs.
   live mode, and set up the webhook.

## Where it lives in the admin menu

Its settings form is the route `stripe_api.admin`, reached at
**Configuration → Web services → Stripe API**
(`/admin/config/services/stripe_api`), and access is gated by the
**Administer Stripe API** (`administer stripe api`) permission.
