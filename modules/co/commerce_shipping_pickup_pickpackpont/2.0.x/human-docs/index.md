# Commerce Shipping Pickup PickPackPont — manual setup guide

**Commerce Shipping Pickup PickPackPont** (`commerce_shipping_pickup_pickpackpont`)
adds **Pick Pack Pont pickup‑point delivery** for Hungary to Drupal Commerce. At
checkout the customer chooses a Pick Pack Pont collection point (átvételi pont)
from the Hungarian pickup network, and that choice becomes part of the order's
shipping address. It is a provider that builds on the
[Commerce Shipping Pickup API](../../commerce_shipping_pickup_api/1.0.x/human-docs/index.md)
framework, which it requires.

Pick Pack Pont uses an **embedded online map selector** so shoppers can find and
pick a nearby point during checkout. The selector is Pick Pack Pont's own map
page, loaded in the customer's browser inside an iframe over HTTPS; the chosen
point's name and address are copied into the order's shipping profile. Full
Hungarian localization is installed automatically.

This provider registers a Pick Pack Pont pickup shipping method plugin under
Commerce Shipping. It has no access‑control role of its own, and there are no API
keys or carrier credentials to enter for this provider — the map is a public
browser widget.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   add the checkout pane.
2. [Configuration](configuration/index.md) — add the Pick Pack Pont shipping
   method and set its rate.

## Where it lives in the admin menu

Pick Pack Pont plugs into Drupal Commerce Shipping:

- **Commerce → Configuration → Checkout flows** — add the pickup‑capable
  **Shipping information** pane (summary: *Supports pickup*).
- **Commerce → Configuration → Shipping methods** — add a shipping method that
  uses the Pick Pack Pont pickup plugin.

There is no separate module settings page; the options live on the shipping
method itself, described in [Configuration](configuration/index.md).
