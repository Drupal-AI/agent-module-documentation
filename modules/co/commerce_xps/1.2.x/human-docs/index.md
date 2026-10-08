# Commerce XPS — manual setup guide

**Commerce XPS** (`commerce_xps`) adds **XPS Ship** real‑time shipping‑rate
calculation to Drupal Commerce. It extends the Commerce Shipping API with a
shipping‑method plugin that fetches **live carrier rates** from the XPS REST API
at checkout and presents them to the customer as selectable shipping options.

The problem it solves: instead of maintaining flat‑rate or table‑rate shipping,
you get real carrier pricing based on the order's weight, dimensions, and
destination. **USPS** is the default carrier XPS provides, and you can add FedEx,
UPS, and others through your XPS account. As a USPS provider, XPS Ship offers
discounted domestic and international rates.

It depends on Commerce **Shipping** (`commerce_shipping`). The module does **not**
do anything on enable alone — you create a shipping method that uses the XPS
plugin and enter your XPS API credentials (API key and customer/account
identifiers) from your XPS account. Rates are then requested from XPS whenever the
cart or address changes at checkout. This is an outbound‑only integration: there
is no inbound callback or webhook.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — create an XPS shipping method and
   enter your API credentials.

## Where it lives in the admin menu

Commerce XPS adds no settings page of its own. You configure it as a shipping
method under **Administration → Commerce → Configuration → Shipping methods**
(`/admin/commerce/config/shipping-methods`), selecting **XPS Shipping** as the
plugin. See [Configuration](configuration/index.md).
