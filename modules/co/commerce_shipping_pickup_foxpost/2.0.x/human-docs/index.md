# Commerce Shipping Pickup Foxpost — manual setup guide

**Commerce Shipping Pickup Foxpost** (`commerce_shipping_pickup_foxpost`) adds
**Foxpost parcel‑machine (csomagautomata) pickup delivery** for Hungary to Drupal
Commerce. At checkout the customer selects a Foxpost pickup point from a list, and
that choice is written into the shipment's shipping address (with the country set
to Hungary). It is a provider that builds on the
[Commerce Shipping Pickup API](../../commerce_shipping_pickup_api/1.0.x/human-docs/index.md)
framework, which it requires.

You do not have to maintain the list of Foxpost machines yourself. The module
fetches Foxpost's public pickup‑point catalogue from Foxpost's CDN over HTTPS,
normalises it, and caches it in its own database table. A refresh interval you
choose on the shipping method (hourly, daily, or weekly) keeps that list current
via cron, and it also refreshes on demand the first time the list is empty. The
module ships with full Hungarian localization, installed automatically.

The module registers a single shipping method plugin, **Pickup shipping –
Foxpost** (`pickup_hu_foxpost`). It exposes no routes, permissions, or public
endpoints of its own — it is purely a checkout‑time shipping method. Because the
only outbound traffic is a read of Foxpost's public catalogue over HTTPS, there
are no carrier credentials to manage for this particular provider.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   add the checkout pane.
2. [Configuration](configuration/index.md) — add the Foxpost shipping method and
   set its pickup‑list refresh frequency.

## Where it lives in the admin menu

Foxpost plugs into Drupal Commerce Shipping. You set it up in two places:

- **Commerce → Configuration → Checkout flows** — add the pickup‑capable
  **Shipping information** pane (summary: *Supports pickup*).
- **Commerce → Configuration → Shipping methods** — add a shipping method that
  uses the **Pickup shipping – Foxpost** plugin.

There is no separate module settings page; the only options live on the shipping
method itself, described in [Configuration](configuration/index.md).
