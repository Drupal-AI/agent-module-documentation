# Commerce Shipping Carrier — manual setup guide

**Commerce Shipping Carrier** (`commerce_shipping_carrier`) lets you define your
own **shipping carriers** (UPS, DHL, a local courier, and so on) as configuration
entities, and give each one a **tracking URL pattern**. Once a carrier exists,
you can select it when creating a shipment for an order, enter the tracking
number, and the module turns that number into a proper **tracking link** for the
customer. It fills the gap where flat-rate shipping methods don't provide
tracking URLs on their own — the same idea as the old Drupal 7
`simple_package_tracking` module.

It depends on **Commerce Shipping** (`commerce_shipping`) and provides its own
permission to control who may manage carriers. It supports **Drupal 9.3, 10, and
11**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — create carriers and set their
   tracking URL patterns.

## Where it lives in the admin menu

Carriers are managed at **Administration → Commerce → Configuration → Shipping →
Carriers** (`/admin/commerce/config/shipping_carriers`). The carriers you create
there become selectable when you build shipments on an order. See
[Configuration](configuration/index.md).
