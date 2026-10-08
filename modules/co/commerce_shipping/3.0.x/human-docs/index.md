# Commerce Shipping — manual setup guide

**Commerce Shipping** (`commerce_shipping`) adds shipping to a Drupal Commerce
store. It takes the physical items on an order, packs them into one or more
**shipment** records, works out a delivery cost through pluggable **shipping
methods**, and — at checkout — collects the customer's shipping address and lets
them pick from the rates you offer.

Out of the box it ships two simple rate calculators: a single **flat rate** per
order and a **flat rate per item** (a fee multiplied by quantity). That's enough
to charge shipping on day one. When you need real carrier rates (UPS, USPS,
FedEx, and so on), those are added by separate carrier modules that plug into the
same shipping-method system, so the checkout experience stays identical.

You decide *which* methods a customer sees using conditions — limit a method to
certain destinations, to orders over a weight threshold, to a number of items, or
to specific stores. Each shipment moves through its own workflow (draft → ready →
shipped) so warehouse staff can track fulfilment, and an optional confirmation
email goes out when an order ships.

This module is part of the Drupal Commerce ecosystem and depends on **Commerce**,
**Commerce Order**, **Commerce Price**, and the **Physical** module (for weights
and dimensions). It is aimed at store builders configuring shipping through the
admin UI.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent — the shipping-method plugin
type, the entity/value-object API, packers and events — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside its Commerce dependencies.
2. [Configuration](configuration/index.md) — turn on shipping for an order type,
   create shipping methods and conditions, and manage shipment and package types.

## Where it lives in the admin menu

Shipping configuration lives under **Commerce → Configuration → Shipping**
(`/admin/commerce/config/shipping`). From there and its neighbours you manage:

- **Shipping methods** — `/admin/commerce/shipping-methods`
- **Shipment types** — `/admin/commerce/config/shipment-types`
- **Package types** — `/admin/commerce/config/package-types`

Individual shipments for a given order appear on that order's **Shipments** tab in
the admin order screens.
