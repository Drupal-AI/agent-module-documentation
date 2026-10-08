# Commerce FedEx — manual setup guide

**Commerce FedEx** (`commerce_fedex`) provides live **FedEx** shipping‑rate
calculations for Drupal Commerce by extending the Commerce Shipping API. Instead
of a flat fee or a weight band, the cart's actual contents and destination are
sent to FedEx and the returned rates become the shipping options a customer
chooses from — covering domestic and international FedEx services such as Ground,
Home Delivery, 2 Day, Express Saver, the Overnight tiers, Smart Post, and the
International Economy/First/Priority levels.

It depends on **Commerce Shipping** (`commerce_shipping`) and Commerce itself, and
on the `whatarmy/fedex-rest` library. One requirement to check up front is the PHP
**SOAP extension** (`ext-soap`), which is not enabled on every host. The module
also ships two submodules for regulated consignments: **commerce_fedex_dangerous**
for hazardous materials and **commerce_fedex_dry_ice** for dry‑ice shipments —
both cover declarations that are legal obligations, not mere configuration.

Nothing happens on enable alone. You add dimension and weight fields to your
shippable products, populate them, and then configure the FedEx shipping method
with your FedEx account credentials. A few practical points to keep in mind, since
this release is an alpha (2.0.0‑alpha2): FedEx credentials are live secrets that
belong in environment variables, and because rating happens on every cart change
in the checkout path, you should cache rate responses where you can and configure
a fallback rate — a checkout that fails because FedEx is slow is worse than one
showing an estimate. Real deployments typically add rate filtering, surcharges and
packaging logic through the module's event subscribers.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, check
   `ext-soap`, enable the module and its submodules.
2. [Configuration](configuration/index.md) — add product weight/dimension fields
   and configure the FedEx shipping method.

## Where it lives in the admin menu

The FedEx shipping method is configured under **Administration → Commerce →
Configuration → Shipping → Shipping methods**
(`/admin/commerce/config/shipping/methods/fedex/edit`).
