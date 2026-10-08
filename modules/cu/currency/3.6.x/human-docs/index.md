# Currency — manual setup guide

**Currency** (`currency`) gives your Drupal site a complete toolkit for working
with money: a library of the world's currencies, locale-aware formatting of
amounts, and a pluggable system for exchange rates and conversion. It is the
foundation many pricing and commerce workflows build on when they need accurate
currency metadata and reliable money math.

Under the hood it stores each currency — its ISO code, sign, minor units
("subunits"), rounding step, alternative signs, and the countries that use it — as
a configuration entity, and each formatting **locale** (the decimal and grouping
separators and the display pattern) as another config entity. Out of the box only
the placeholder currency `XXX` ("No currency") and the `en_US` locale are enabled;
you **import** the real currencies you need — USD, EUR, GBP, and so on — from a
bundled data library, so the site carries only the currencies it actually trades
in.

Formatting is handled by **amount formatter** plugins (the default is a basic
formatter) that place the sign and separators correctly for the resolved locale.
You can format amounts in code with `Currency::formatAmount()`, collect them on a
form with a dedicated `currency_amount` element, or let editors work with money
right inside body text using two text-format filters — one that converts amounts
inline (`[currency:EUR:USD:100]`) and one that formats them.

Conversion is done by **exchange rate provider** plugins. Two ship: one for rates
you enter by hand ("fixed rates") and one for historical rates bundled with the
library. Providers are stacked and queried through a single service, and
developers can add their own provider (for example to pull live rates from an API)
or their own formatter. A companion submodule, **Currency Intl**
(`currency_intl`), adds localized currency names for international sites.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module, its libraries and
   the `bcmath` extension, then enable it.
2. [Configuration](configuration/index.md) — import currencies, manage formatting
   locales, set exchange rates, and enable the editor filters.

## Where it lives in the admin menu

All of Currency's admin screens sit under **Configuration → Regional and
language**:

- **Currencies** — `/admin/config/regional/currency` (the module's main
  "Configure" link): list, add, import, edit, enable/disable currencies.
- **Currency exchange** — `/admin/config/regional/currency-exchange`: choose and
  order the exchange rate providers, with **Fixed rates** at
  `/admin/config/regional/currency-exchange/fixed`.
- **Currency amount formatting** — `/admin/config/regional/currency-formatting`:
  pick the default amount formatter, with the formatting locales under
  `/admin/config/regional/currency-formatting/locale`.

Access to each area is controlled by its own granular permission (see
[Configuration](configuration/index.md)).
