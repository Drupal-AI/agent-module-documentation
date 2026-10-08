# Stripe Sync — manual setup guide

**Stripe Sync** (`stripe_sync`) is a lightweight bridge between Stripe and Drupal
users for memberships and paid access. It drives a Stripe Checkout flow and then,
based on Stripe subscription and payment events, **adds and removes Drupal roles**
on the matching user — so a paid subscriber gets a "member" role, a past-due
account can drop to a grace-period role, and a lapsed account loses access, all
without custom code. It also auto-links Stripe customers to Drupal users, provides
self-service billing-portal links, a membership-status block, and an admin search
page for finding users by their Stripe IDs.

The problem it solves is keeping site access in step with billing status: rather
than manually granting and revoking roles as people subscribe, renew, or cancel,
Stripe Sync keeps them synchronized from Stripe's own events. It can map different
product tiers to different roles (via a `drupal_role` metadata key on the Stripe
Price or Product), supports both recurring subscriptions and one-time access with
an `access_days` window, guards against duplicate subscriptions, and runs a daily
reconciliation job (with a "Run now" option) to catch anything that drifted.

On the security question that matters most for this kind of module — *can a forged
webhook grant someone a paid role?* — the answer here is reassuring. Stripe Sync
does **not** receive Stripe's webhooks directly. It depends on the contrib
**Stripe** module and subscribes to that module's webhook event, and the Stripe
module verifies Stripe's signature (`Webhook::constructEvent`) **before**
dispatching the event. So by the time Stripe Sync acts, the event is already
authenticated, and an unsigned or forged webhook is rejected upstream. To make
that verification actually work you must configure the Stripe **webhook signing
secret** (`whsec_…`) on the Stripe module, keep your Stripe **secret API key** in
an environment variable or Key entity rather than the database, and serve the site
over HTTPS.

One operational caution worth understanding up front: Stripe Sync will
**automatically remove** any role you mark as "managed" when it doesn't see a
justification for it in Stripe. So do not mark a role as managed if you also
assign that role manually — the sync would strip it away.

This guide is written for a **human** setting the module up. If you are an AI
coding agent, read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, set up the
   Stripe base module, and enable Stripe Sync.
2. [Configuration](configuration/index.md) — Stripe keys, the webhook secret, and
   role mapping.

## How to use it

Once installed and configured, the module provisions the user fields it needs and
begins keeping roles in step with Stripe automatically. Editors and members
interact with it through the Checkout launcher, the membership-status block (which
shows active / expiring-soon with a renew link / a join call-to-action), and the
Stripe Billing Portal links for self-service. Administrators get a user search
page and a "Re-sync from Stripe" button on user profiles. A dedicated permission
gates who can see the Stripe user fields.
