# Commerce Exchanger — manual setup guide

**Commerce Exchanger** (`commerce_exchanger`) adds currency exchange rates to
Drupal Commerce. If your store deals in more than one currency — showing a
secondary "approximately $X" price, converting order totals, or powering a
currency switcher — this module is what supplies and manages the conversion
ratios. It sits on top of Commerce's price system and gives you a service that
converts a price from one currency to another using rates you either maintain by
hand or fetch automatically from an external provider.

You set up one or more **Exchange rates** sources, each backed by a **provider
plugin**. The `manual` provider lets your finance team type in and maintain rates
directly. The remote providers — **European Central Bank (ECB)**, **Fixer**,
**Currencylayer**, **Open Exchange Rates**, and **TransferWise** — fetch rates
from an external API automatically on cron (some require an API key or account).
You can run more than one source side by side, override individual currency pairs
by hand while the rest sync automatically, and optionally keep a daily history of
rates for auditing.

Once rates exist, a calculator service converts prices in code, and a
**Converted price** field formatter (`commerce_price_exchanger`) can display any
price field in a chosen target currency. The module also works with Commerce
Currency Resolver for full storefront multi-currency display. Access to the
exchange-rate configuration is gated by its own permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — create an exchange-rate source,
   choose and set up a provider, import rates, and display converted prices.

## Where it lives in the admin menu

Once enabled, exchange-rate sources are managed at **Commerce → Configuration →
Exchange rates** (`/admin/commerce/config/exchange-rates`). There is no single
"settings" form — instead you create and manage exchange-rate entities on that
collection page.
