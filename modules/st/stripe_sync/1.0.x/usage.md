<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Stripe Sync provides Stripe Checkout plus webhook-driven role sync for users/roles.

---

Stripe Sync **syncs Drupal roles from Stripe subscriptions** — it drives a Stripe Checkout flow and, based on
Stripe subscription events, **adds/removes managed Drupal roles** (paid tiers, grace-period, inactive) on the
matching user. It depends on the Stripe module.

Use it to gate site access/membership by Stripe subscription. It is a payment/membership integration where the key
security question — can a forged webhook grant a paid role? — is **answered safely**: Stripe Sync does not receive
the webhook directly; it subscribes to the **Stripe module's `StripeEvents::WEBHOOK` event**, and the Stripe
module's webhook controller **verifies the Stripe signature first** (`Webhook::constructEvent($payload, $sig,
$secret)`, catching `SignatureVerificationException`) and only dispatches the event on success — so by the time
Stripe Sync syncs roles, the event is authenticated (a forged/unsigned webhook is rejected upstream). Security
essentials: configure the **Stripe webhook signing secret (`whsec_…`)** on the Stripe module (without it,
verification can't work), store the **Stripe secret API key** via env (`STRIPE_SECRET_KEY`) or Key (it supports an
env fallback), serve over HTTPS, and be careful with the "managed roles" config (Stripe Sync will **remove** managed
roles it doesn't see justified — don't mark a role managed if it's also assigned manually). It has its own
permissions. Configure the Stripe keys, webhook secret and role mapping.

---

- Sync Drupal roles from Stripe subscriptions.
- Drive Stripe Checkout + react to webhooks.
- Add/remove managed roles by subscription status.
- Depend on the Stripe module.
- Serve payment/membership integration.
- Gate access by subscription.
- RECEIVE roles-changes via the Stripe module's WEBHOOK event (not its own endpoint).
- RELY on the Stripe module verifying the signature (Webhook::constructEvent) before dispatch — a forged webhook is rejected upstream.
- Require the Stripe webhook secret (whsec_) configured for verification to work.
- Store the Stripe secret key via env (STRIPE_SECRET_KEY)/Key + HTTPS.
- Mind that managed roles are auto-REMOVED when unjustified (don't mark manually-assigned roles managed).
- Configure the Stripe keys, webhook secret and role mapping.
- Handle Stripe role sync.
- Sync roles.
- Configure the mapping.
- React to webhooks.
- Grant/revoke roles.
- Manage membership.
- Verify via Stripe.
- Provide Stripe role sync.
