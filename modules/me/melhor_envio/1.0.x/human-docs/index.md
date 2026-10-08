# Melhor Envio Commerce Shipping — manual setup guide

**Melhor Envio Commerce Shipping** (`melhor_envio`) adds **Brazilian shipping‑rate
calculation** to Drupal Commerce using the
[Melhor Envio](https://melhorenvio.com.br/) API. Melhor Envio is a Brazilian
shipping aggregator that returns real carrier rates — Correios and others — so a
Brazilian store can show accurate, up‑to‑date shipping prices at checkout instead of
flat or guessed rates. The module registers as a **Commerce shipping method**, and
at checkout it sends the order's details to the Melhor Envio API and returns the
available shipping options and prices.

It depends on **Commerce Shipping** (`commerce_shipping`) and works on Drupal 10, 11
and 12. To talk to Melhor Envio you need API credentials (an access token) from your
Melhor Envio account; these are entered when you configure the shipping method and
should be treated as secrets.

Because the module is a Commerce shipping method, its configuration lives on the
shipping‑method entity in Commerce rather than on a standalone module settings page.
Setup is: add a shipping method that uses the Melhor Envio plugin, then enter your
API credentials and options — covered below.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Commerce Shipping.
2. [Configuration](configuration/index.md) — add the Melhor Envio shipping method
   and enter your API credentials safely.

## Where it lives in the admin menu

You configure it as a Commerce shipping method at **Commerce → Configuration →
Shipping → Shipping methods** (`/admin/commerce/shipping-methods`), where you add a
method that uses the Melhor Envio plugin.

## How to use it

1. Make sure Drupal Commerce and Commerce Shipping are set up (a store, products
   with physical dimensions/weight, and shipping enabled on your order type).
2. Add a **shipping method** that uses the **Melhor Envio** plugin and enter your
   Melhor Envio API credentials — see [Configuration](configuration/index.md).
3. At checkout, customers with a shippable order see the Melhor Envio rate options
   (Correios and other carriers) fetched live from the API, and pick one as they
   would any shipping option.
