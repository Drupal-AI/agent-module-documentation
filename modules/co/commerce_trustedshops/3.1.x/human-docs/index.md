# Commerce TrustedShops — manual setup guide

**Commerce TrustedShops** (`commerce_trustedshops`) connects a Drupal Commerce
store to **Trusted Shops**, the European trust‑badge and customer‑reviews service.
It can display the **Trustbadge** on your storefront and collect **shop and product
reviews** from customers after they complete checkout — including sending review
invitations for past orders.

At its core the module introduces a **Shop** configuration entity: one Trusted
Shops shop, keyed by its **TSID**, holding the API credentials used to talk to the
Trusted Shops REST API. Chained resolvers pick the right shop and the right review
language for each order, so multi‑store and multilingual setups work. A
**Trustbadge block** renders the badge widget anywhere you place it, and a
**Review Collector** checkout pane emits the review‑collector snippet when an order
completes, so Trusted Shops can gather ratings. Store staff can also trigger a
review invitation manually from a specific order.

It depends on **Commerce** and **Commerce Store**, and it relies on the
**Trusted Shops PHP SDK** (`antistatique/trustedshops-php-sdk`), which Composer
installs for you. If you have previously added the Trustbadge to your theme by
hand, remove that manual snippet before using this module.

Two admin surfaces exist, both gated by the **administer commerce trustedshops**
permission: a settings form and a Shop admin at
`/admin/commerce/config/trustedshops`. A separate per‑order "Send invitation to
write a review" form is guarded by the **send invite review commerce
trustedshops** permission. All admin and order routes are permission‑gated — there
are no anonymous or mutating public endpoints.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (including the
   Trusted Shops PHP SDK) and enable the module.
2. [Configuration](configuration/index.md) — create your Shop entity, place the
   Trustbadge, enable the review collector, and set up invitations.

## Where it lives in the admin menu

- **Shops:** **Commerce → Configuration → TrustedShops**
  (`/admin/commerce/config/trustedshops`)
- **Settings:** `/admin/commerce/config/trustedshops/settings`
- **Manual review invitation (per order):**
  `/admin/commerce/orders/{order}/trustedshops/invite_review_confirm`

See [Configuration](configuration/index.md) for how to use them.
