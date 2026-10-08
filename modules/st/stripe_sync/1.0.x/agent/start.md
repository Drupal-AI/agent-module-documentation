<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Stripe Sync — agent index

**Stripe Checkout + webhook role sync for users/roles**. Depends on `stripe`. Provides permissions. Version
**1.0.0-alpha8**. Core `^10||^11`.

Payment/membership — **safe**: role changes come from the Stripe module's `StripeEvents::WEBHOOK` event, which the
Stripe module dispatches **only after verifying the Stripe signature** (`Webhook::constructEvent`, catches
`SignatureVerificationException`) — a forged webhook can't grant roles. Configure the **webhook secret (whsec_)**;
store the Stripe secret key via env (`STRIPE_SECRET_KEY`)/Key; HTTPS. Managed roles are auto-removed when
unjustified.
