# MKC Marketplace — manual setup guide

**MKC Marketplace** (`mkc_marketplace`) turns a **MonkeysCommerce** store into a
full **multi-vendor marketplace**. It covers the whole lifecycle: vendor onboarding
and approval, product-submission review queues, automatic splitting of multi-vendor
carts into per-vendor sub-orders, a configurable commission engine, **Stripe
Connect** payouts to vendors, a three-party dispute-resolution workflow, and
vendor-scoped shipping.

It adds entities such as **Vendor** (merchant account with profile, Stripe Connect
ID and approval status), **VendorProduct** (submitted for admin review),
**VendorOrder**, **Commission**, **Payout** and **VendorShippingMethod**, backed by
services for the vendor lifecycle, order splitting, commission calculation, payout
processing, Stripe Connect account management, dispute handling and per-vendor
shipping/inventory. Administrators get a marketplace dashboard and management
screens (vendors, vendor orders, products, commissions, payouts, disputes);
vendors get their own portal (dashboard, products, orders, payouts, shipping), and
there's a public registration form.

As an add-on it depends on MonkeysCommerce core, catalog, order, payment and
shipping (`mkc_core`, `mkc_catalog`, `mkc_order`, `mkc_payment`, `mkc_shipping`),
pulls in the **`stripe/stripe-php`** library via Composer, and targets Drupal 11.3+
on PHP 8.2+.

> **Credentials are secrets.** Stripe Connect uses OAuth and API keys — store them
> in environment variables (and/or a Key entity), never hard-coded or committed. See
> [Configuration](configuration/index.md).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module on your MonkeysCommerce store.
2. [Configuration](configuration/index.md) — commission rates, payout schedule,
   Stripe Connect, and the vendor workflow.

## Where it lives in the admin menu

Once enabled, the module's screens sit under **Commerce → Marketplace**, including
`/admin/commerce/marketplace` (dashboard),
`/admin/commerce/marketplace/settings` (commission rates, payout schedule),
`/admin/commerce/marketplace/vendors`, `/vendor-products`, `/vendor-orders`,
`/commissions`, `/payouts` and `/disputes`. Vendors use the portal at
`/vendor/dashboard` and register at `/marketplace/register`.
