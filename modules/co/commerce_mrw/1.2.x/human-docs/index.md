# Commerce MRW — manual setup guide

**Commerce MRW** (`commerce_mrw`) connects a Drupal Commerce store to **MRW**, a
courier operating in Spain, Portugal, Andorra and Gibraltar, through MRW's
**SAGEC** web service. It adds MRW as a Commerce Shipping method so your store can
offer an MRW rate at checkout, and it wires the back office up to MRW's API for the
work that happens after an order is placed — transmitting shipments, downloading
transport labels and cancelling shipments, plus a tracking client your site can
call to query parcel status.

The problem it solves is the manual back-and-forth of fulfilling with MRW. Once a
shipment exists in Commerce, staff can transmit it to MRW (a *TransmEnvio*
request) straight from the shipment page; MRW returns a shipment number that is
stored as the tracking code, and the printable transport label PDF can be pulled
on demand (labels are streamed live from SAGEC and never stored locally, so MRW
stays the single source of truth). It also supports return pickups (collect at the
customer's address), a public tracking URL with a configurable pattern, and an
event you can subscribe to for altering the outbound request (consignee NIF,
phone, cash on delivery, insurance) before it is sent.

This is not a works-on-enable module: it needs configuration. You supply the SAGEC
credentials your MRW franchise gives you and add an MRW shipping method. It depends
only on **Commerce Shipping** (`commerce_shipping`). The module keeps separate
**PRE (test)** and **PRO (production)** environments with independent credentials
and a test-mode toggle, so you can validate the integration before going live.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and Commerce Shipping.
2. [Configuration](configuration/index.md) — create the MRW shipping method and
   enter your SAGEC credentials, service code and rate.

## Where it lives in the admin menu

MRW is a shipping method, so you set it up under **Commerce → Configuration →
Shipping methods** (`/admin/commerce/shipping-methods/add`) — choose the **MRW**
plugin. Day-to-day fulfilment actions (transmit, download label, cancel)
appear on individual shipments from the order's shipment page and on the shipments
list; status tracking is a programmatic client rather than a button.
