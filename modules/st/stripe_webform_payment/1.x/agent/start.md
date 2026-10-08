<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Stripe Webform Payment (stripe_webform_payment) — agent index

**Webform element taking a Stripe payment** on submission. Version **dev**. Core `^9 || ^10 || ^11`.
Depends on the contrib **`stripe`** base module.

**Security division:** this module = the Webform element + reads keys (publishable/secret/webhook).
The Stripe API calls and **webhook signature verification** live in the `stripe` base module (the
correct place; a webhook-secret getter confirms signed webhooks). Uses **Stripe.js** — card data
goes to Stripe, not the server (PCI scope benefit).

**Operator responsibilities:** keep the Stripe secret + webhook-signing secret out of plain
config/git (Key entity/env); ensure the webhook endpoint's signing secret is configured so forged
confirmations are rejected.