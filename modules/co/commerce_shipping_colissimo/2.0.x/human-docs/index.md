# Commerce Shipping Colissimo — manual setup guide

**Commerce Shipping Colissimo** (`commerce_shipping_colissimo`) adds a
**Colissimo (La Poste, France)** shipping method to Drupal Commerce. It supports
**home delivery** (with or without signature) and **relay pickup points** — for
relay it shows customers a **map of nearby pickup points centred on their
geolocation** so they can choose one at checkout. It also generates **PDF
shipping labels** through La Poste's label web service and provides parcel
**tracking links**.

It is aimed at French and France-shipping stores. It plugs into
`commerce_shipping` as a shipping-method plugin and into checkout via a Colissimo
checkout pane. Beyond `commerce_shipping` it depends on **Commerce Shipping
Label** (`commerce_shipping_label`) for label handling and core's **File**
module. It targets **Drupal 11**.

A couple of practical notes. This project is **not covered by Drupal's security
advisory policy**. Outbound calls to Colissimo use Drupal's shared HTTP client
with **TLS verification on** (there is no disabled-TLS shortcut). Your Colissimo
**login and password are stored in configuration as plain text**, which is normal
for carrier modules — so keep them out of committed config (see Configuration).
And a **debug mode** exists that logs full request and response bodies including
your credentials, so only ever turn it on in a non-production environment.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its dependencies.
2. [Configuration](configuration/index.md) — enter your Colissimo credentials,
   set up label generation, and add the shipping method and checkout pane.

## Where it lives in the admin menu

The module's own settings live at **Administration → Commerce → Configuration →
Shipping → Colissimo Settings** (`/admin/commerce/config/colissimo`, route
`commerce_shipping_colissimo.settings`, gated by *Administer site
configuration*). The shipping method itself is added under **Commerce →
Configuration → Shipping methods**. See [Configuration](configuration/index.md).
