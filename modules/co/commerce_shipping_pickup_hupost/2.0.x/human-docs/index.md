# Commerce Shipping Pickup Magyar Posta — manual setup guide

**Commerce Shipping Pickup Magyar Posta** (`commerce_shipping_pickup_hupost`)
adds **Hungarian Post (Magyar Posta) pickup delivery** to Drupal Commerce. It
lets customers choose a PostaPont pickup point or a parcel machine
(csomagautomata) at checkout, and writes the chosen location into the shipment's
Hungarian shipping address. It is a provider that builds on the
[Commerce Shipping Pickup API](../../commerce_shipping_pickup_api/1.0.x/human-docs/index.md)
framework, which it requires.

The module registers three shipping method plugins so you can offer whichever
suits your store:

- **PostaPont (list)** (`pickup_hu_postapont`) — pickup points chosen from a
  simple select list.
- **PostaPont (map)** (`pickup_hu_postapont_map`) — the same points shown on a
  Google map. This variant needs a **Google Maps JavaScript API key** to render.
- **Parcel machines / Csomagautomaták** (`pickup_hu_postacsomag`) — Magyar
  Posta's automated parcel lockers.

You don't maintain the point lists yourself: the module downloads them from Magyar
Posta's public PartnerExtra XML feeds over HTTPS, caches them in its own database
table, and refreshes them via cron on an interval you choose per method. Full
Hungarian localization is installed automatically. The module exposes no routes,
permissions, or public endpoints of its own — it is purely a set of checkout‑time
shipping methods.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   add the checkout pane.
2. [Configuration](configuration/index.md) — add the shipping method(s) you want,
   set the refresh interval, and (for the map method) supply the Google Maps API
   key.

## Where it lives in the admin menu

Magyar Posta plugs into Drupal Commerce Shipping:

- **Commerce → Configuration → Checkout flows** — add the pickup‑capable
  **Shipping information** pane (summary: *Supports pickup*).
- **Commerce → Configuration → Shipping methods** — add one or more shipping
  methods using the PostaPont list, PostaPont map, or parcel‑machine plugins.

There is no separate module settings page; all options live on the shipping
methods themselves, described in [Configuration](configuration/index.md).
