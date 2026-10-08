# Commerce Exchanger NBU — manual setup guide

**Commerce Exchanger NBU** (`commerce_exchanger_nbu`) provides currency exchange
rates from the **National Bank of Ukraine (NBU)** for the **Commerce Exchanger**
module, so Drupal Commerce can convert prices using official NBU rates. The base
currency for the rates is the Ukrainian hryvnia (UAH). It is a small integration
module: it adds NBU as a rate **provider** that Commerce Exchanger can use, and
does nothing on its own.

It depends on the **Commerce Exchanger** module (`commerce_exchanger`), which is
where exchange‑rate handling actually lives. The module fetches **public** rate
data from the NBU — no API key or credentials are typically required — and it has
no access‑control role of its own.

Because it is only a rate source, there is no separate settings form for this
module. You configure it the way Commerce Exchanger configures any provider:
enable it, then choose **NBU** as the exchange‑rate provider in Commerce
Exchanger's settings (see "How to use it" below). That is why this guide has no
Configuration page.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside Commerce Exchanger.

There is **no configuration page** for this module — it adds no settings form of
its own. You select NBU as a rate provider inside Commerce Exchanger, described in
"How to use it" below.

## How to use it

1. Make sure **Commerce Exchanger** is installed and enabled (it is a dependency
   of this module).
2. Enable Commerce Exchanger NBU (see [Installation](installation/index.md)).
3. In Commerce Exchanger's configuration, add or select an exchange‑rate provider
   and choose **NBU** as the source. Commerce Exchanger then pulls official NBU
   rates (base currency UAH) and uses them to convert prices in your store.

Because NBU rates are fetched from a public endpoint, there are no credentials to
enter. Refer to Commerce Exchanger's own documentation for how providers are
selected, how often rates refresh, and how converted prices are applied.
