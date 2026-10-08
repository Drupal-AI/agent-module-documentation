# Commerce Speedy — manual setup guide

**Commerce Speedy** (`commerce_speedy`) integrates the Bulgarian courier
[Speedy](https://www.speedy.bg/) with Drupal Commerce Shipping. It adds Speedy as a
shipping method so your store can calculate Speedy delivery rates at checkout, let the
customer choose how they want to receive their parcel — delivery to an address, to a Speedy
office, or to a Speedy automat (parcel box) — validate the customer's address, generate the
shipment in Speedy's system when an order is placed, and print the waybill (shipping label)
as a PDF.

It solves shipping for stores that ship with Speedy in Bulgaria: rather than quoting flat
rates and copying orders into Speedy by hand, the module talks to Speedy's API to price and
create real shipments. It needs configuration before it works — you must register a Speedy
account, obtain API credentials, and create and configure a Speedy shipping method. If you
add a Google Maps key to the shipping method, the office/automat picker at checkout shows a
map so customers can select a pick-up point directly.

The module depends on **Commerce Shipping** (`commerce_shipping`), the **Anonymous Session**
module (`anonymoussession`), and core's **Telephone** field (`telephone`). It supports
Drupal 10 and 11. Note that it is currently a beta release and minimally maintained, and it
is not covered by Drupal's security advisory policy — weigh that before using it on a
production store.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the module and
   its dependencies.
2. [Configuration](configuration/index.md) — register your Speedy account, store the API
   credentials, and create the Speedy shipping method.

## Where it lives in the admin menu

Speedy is set up as a shipping method under **Commerce → Configuration → Shipping methods**
(`/admin/commerce/shipping-methods`), and the "ship from" origin (address, office, or
automat) is chosen in your store configuration.
