# Commerce EasyPost — manual setup guide

**Commerce EasyPost** (`commerce_easypost`) connects Drupal Commerce Shipping to
the **EasyPost** multi‑carrier shipping API. One EasyPost account and one API key
give your store live shipping rates from many carriers, plus the ability to buy
and refund labels, show tracking, and schedule carrier pickups — all from your
Commerce admin and checkout.

It adds an **EasyPost shipping method** plugin. At checkout, it fetches live
rates for the cart and destination and presents the carrier services you've
enabled; in fulfilment, it can buy a label for a shipment, void/refund a
purchased label, look up tracking, and schedule or cancel a pickup. Two checkout
panes let customers supply their own carrier account number and a phone number
where carriers require one, and you can apply a rate multiplier, set customs
defaults for international shipments, and choose insurance and dropoff options.

The module depends on **Commerce Shipping** and its label workflow
(`commerce_shipping`, `commerce_shipping_label`) and on core's **Telephone**
module. Nothing happens on enable alone — you add an EasyPost shipping method to a
shipping‑enabled store, paste your API key, and enable the carrier services you
offer. All EasyPost calls go through the official EasyPost SDK over HTTPS, and the
module adds **no public routes or webhooks**: every label purchase, refund and
pickup runs from an authenticated Commerce admin flow, so there is no anonymous
callback surface. The one caveat to note is that the API key is stored in plain
shipping‑method configuration — see the Configuration page.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and confirm the shipping dependencies.
2. [Configuration](configuration/index.md) — add the EasyPost shipping method,
   paste the API key, and choose services, customs and options.

## Where it lives in the admin menu

Commerce EasyPost has no settings page of its own. Like every Commerce shipping
integration, it is added under **Administration → Commerce → Configuration →
Shipping methods** by adding a shipping method and choosing the **EasyPost**
plugin.
