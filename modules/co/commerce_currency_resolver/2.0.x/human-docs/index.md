# Commerce Currency Resolver — manual setup guide

**Commerce Currency Resolver** (`commerce_currency_resolver`) makes a Drupal Commerce 3
store genuinely multi‑currency: it decides which currency the current visitor should
see, and it works out each product's price in that currency — for products, orders,
promotions, fees, taxes, and shipping. Commerce 3 can already store several currencies,
but it only ever resolves prices for one store; this module lets a single store show
the right currency to each shopper without duplicating your whole catalogue per
currency.

You choose how prices are calculated with the **currency source** setting:

- **Field** — you enter a dedicated price for each currency in its own field (for
  example a Euro price in `field_price_eur`, a GBP price in `field_price_gbp`), and the
  module picks the matching one.
- **Auto** — the module converts every price from your default currency using live
  exchange rates (via the [Commerce Exchanger](https://www.drupal.org/project/commerce_exchanger)
  module).
- **Combo** — use a per‑currency field where you've set one, and fall back to automatic
  conversion where you haven't.

Deciding *which* currency a visitor gets is handled by a set of optional submodules
that plug into Commerce's currency‑resolver chain: pick the currency from a cookie (so
a returning shopper keeps their choice, with an optional front‑end switcher block),
from the interface language, or from the visitor's country via GeoIP or Smart IP. Other
submodules wire automatic conversion into the exchanger, promotions/fees, and shipping.
When a shopper switches currency, the module recalculates their cart total on the spot
(only for their own draft, unlocked orders).

> **Important caching note:** this module works with Drupal's **Internal Dynamic Page
> Cache** only. You must **disable the core Page Cache module**, which would otherwise
> cache one currency's pages and serve them to everyone.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable it,
   choose the submodules you need, and grant the permission.
2. [Configuration](configuration/index.md) — the settings form, the currency‑source
   modes, per‑currency price fields, and the caching requirement.

## Where it lives in the admin menu

The settings form is at **Commerce → Configuration → Store → Currency resolver**
(`/admin/commerce/config/commerce_currency_resolver/settings`), gated by the
**Administer currency settings** permission. The submodules add their own mapping pages
(language‑to‑currency, country‑to‑currency) under the same section, using the same
permission.

## How to use it

After enabling the module (and whichever submodules fit your store), open the settings
form to pick a currency source and, for field/combo modes, add per‑currency price
fields to your product variations. Then enable a resolver submodule (cookie, language,
GeoIP, or Smart IP) to decide each visitor's currency. Remember to turn off the core
Page Cache module. The full walkthrough is in [Configuration](configuration/index.md).
