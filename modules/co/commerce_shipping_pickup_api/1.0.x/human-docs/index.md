# Commerce Shipping Pickup API — manual setup guide

**Commerce Shipping Pickup API** (`commerce_shipping_pickup_api`) is the
framework that makes pickup-point and parcel-machine delivery possible in Drupal
Commerce. On its own it does not add any real carrier — instead it provides the
shared plumbing that individual pickup providers build on: a checkout pane that
can collect a pickup location, the shipping-method scaffolding for pickup plugins,
and the mechanism that writes the customer's chosen pickup point into the order's
shipping address. It depends on Drupal Commerce (`commerce`), Commerce Checkout
(`commerce_checkout`), Commerce Shipping (`commerce_shipping`) and Profile
(`profile`).

Think of it as a base layer. To actually offer pickup delivery you install this
module *and* at least one provider submodule/project on top of it — for example
Foxpost, GLS CsomagPont, Magyar Posta (hupost), or Pick Pack Pont in Hungary.
Each provider registers its own shipping method plugin and supplies its own list
of pickup points; this module gives them all a common home in checkout.

The framework supports two styles of pickup selection: a simple select list of
pickup points, or a richer embedded control (typically a map-based selector) for
a nicer experience. It ships two optional submodules — a **demo** provider
(`commerce_shipping_pickup_demo`) that exposes two sample pickup points so you can
see the flow end to end, and a **store** submodule
(`commerce_shipping_pickup_store`). Because pickup selection becomes part of the
order's address data, and any real provider talks to a carrier, treat any carrier
credentials as secrets and keep provider traffic over HTTPS.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the framework with Composer,
   enable it, and add a provider module to make pickup delivery real.

This module has **no configuration page of its own**. It is a framework: the
things you actually configure (a checkout pane, and a shipping method) live in
Commerce, and the per-carrier settings live in whichever provider module you
install on top of it. See "How to use it" below.

## Where it lives in the admin menu

Commerce Shipping Pickup API adds no settings screen. Its parts surface inside
Drupal Commerce:

- The checkout pane **Shipping information** (the pickup‑capable variant,
  `pickup_capable_shipping_information`, whose summary reads *Supports pickup*) is
  added to a checkout flow under **Commerce → Configuration → Checkout flows**.
- Pickup shipping methods are created under **Commerce → Configuration →
  Shipping methods** — but the actual method plugins come from the provider
  modules you enable.

## How to use it

1. Install and enable this framework module (see
   [Installation](installation/index.md)).
2. Install and enable at least one pickup **provider** — for example
   `commerce_shipping_pickup_foxpost`, `commerce_shipping_pickup_hupost`,
   `commerce_shipping_pickup_gls_csomagpont`, or
   `commerce_shipping_pickup_pickpackpont` — or enable the bundled
   `commerce_shipping_pickup_demo` submodule to try the flow with sample points.
3. Add the pickup‑capable **Shipping information** pane to your checkout flow (or
   use the pre‑built pickup checkout flow).
4. Add a shipping method that uses the provider's pickup plugin.

At checkout the customer then chooses a pickup point, and the framework records
that choice on the order.
