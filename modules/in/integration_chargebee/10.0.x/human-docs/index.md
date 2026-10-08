# Integration Chargebee — manual setup guide

**Integration Chargebee** (`integration_chargebee`) connects your Drupal site to
**Chargebee**, the subscription‑management and recurring‑billing service. It lets
your visitors sign up as customers and subscribe to plans you have defined in
Chargebee, using Chargebee's **Hosted Checkout** so the card payment happens on
Chargebee's side. The module pulls your Chargebee plans into Drupal, gives you a
plan page and a block to present them, and tracks each user's subscription.

You connect it by entering your **Chargebee site name** and **API key** on its
settings page, then choosing which Chargebee plans to offer. Once enabled, a
subscribe page becomes available per user (`/user/{user}/subscribe-plan`), and a
payment‑return flow records the resulting subscription after checkout.

Because it authenticates to Chargebee with an API key and handles billing, treat
the API key as a secret (store it in the environment rather than in code or
exported config) and keep the connection on HTTPS. The module talks to
Chargebee's API on your server, so your server must be able to reach Chargebee.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and the Chargebee
   PHP library with Composer, then enable it.
2. [Configuration](configuration/index.md) — connect your Chargebee account,
   import plans, and enable them.

## Where it lives in the admin menu

Once enabled, the settings page is at **Configuration → System → Chargebee**
(`/admin/config/system/chargebee`), with a plans page at
`/admin/config/system/chargebee/plans`. The per‑user subscribe page lives at
`/user/{user}/subscribe-plan`. See [Configuration](configuration/index.md) for the
setup order.
