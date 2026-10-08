# Configuration

Stripe Sync is configured with no code, but it does need three things set up
correctly: your Stripe credentials, the webhook signing secret, and the mapping
of Stripe products to Drupal roles.

## Stripe credentials

Stripe Sync uses the contrib Stripe module for the actual Stripe connection, so
your **Stripe secret API key** is configured there. Keep that key out of the
database and out of version control: store it in an environment variable (the
module supports a `STRIPE_SECRET_KEY` environment fallback) or in a Key entity,
rather than pasting it into a plain configuration field. The module includes an
in-app setup guide and detects when a key is being overridden. Serve the site over
HTTPS.

## The webhook signing secret

This is the setting that makes the whole flow trustworthy. Configure the Stripe
**webhook signing secret** (the value that starts with `whsec_…`) on the Stripe
module. That secret is what lets the Stripe module verify each incoming event's
signature before it dispatches the event that Stripe Sync listens for. Without a
correctly configured signing secret, verification cannot work — so treat this as a
required step, not an optional one.

Because Stripe Sync only ever reacts to events the Stripe module has already
verified, a forged or unsigned webhook is rejected upstream and cannot grant
anyone a paid role.

## Role mapping and managed roles

- **Per-product roles.** Map Stripe tiers to Drupal roles by adding a
  `drupal_role` metadata key to the relevant Stripe Price or Product — for
  example, mapping Gold, Silver, and Diamond products to different roles.
- **Status-based automation.** Configure which roles correspond to Active,
  Past-due, and Inactive states, so a subscriber's role follows their billing
  status.
- **Managed-roles behavior.** Choose whether a user may hold a single active role
  or multiple. Be careful here: **any role you mark as "managed" will be removed
  automatically** when Stripe Sync sees no justification for it. Never mark a role
  as managed if you also grant it manually elsewhere — the sync would strip it
  away.
- **One-time access.** For non-subscription purchases, an `access_days` value
  grants time-limited access (optionally tied to an invoice), and a
  duplicate-subscription guard (none / same product / any) prevents accidental
  double purchases.

## Reconciliation

A daily reconciliation job (cron plus a queue) re-checks users against Stripe and
corrects any drift; you can also trigger it immediately with the **Run now**
option. This is a good safety net after changing your role mapping.

## Field visibility

A dedicated permission controls who can see the Stripe user fields (customer id,
subscription id, status, and so on), so you can keep that billing detail visible
only to administrators.

## Before production

Because this module adds and removes real roles, validate the full configuration
on staging first: confirm the webhook secret verifies events, confirm your
product-to-role mapping is correct, and confirm no manually assigned role has been
marked as managed.
