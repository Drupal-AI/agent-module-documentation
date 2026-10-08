# Exchange Rate — manual setup guide

**Exchange Rate** (`exchangerate`) brings live currency data into your Drupal
site. It fetches real‑time rates from the [ExchangeRate‑API](https://www.exchangerate-api.com/)
service and gives you two ready‑to‑place blocks: an **Exchange Rate Block** that
displays current rates for the countries and currencies you choose, and a
**Currency Conversion Block** with an AJAX form so visitors can type an amount
and instantly see it converted into several target currencies. It also exposes
rates through a JSON REST API for a decoupled frontend or another application.

To keep things fast and to avoid hitting the API on every page load, the module
caches the rates it fetches for a duration you control. It's a good fit for
financial sites, e‑commerce, reporting dashboards, and travel or banking portals
— anywhere visitors benefit from up‑to‑date currency figures.

Because the module talks to an external paid/free API, it needs an API key that
you sign up for, and your server must be allowed to make outbound HTTPS requests
to ExchangeRate‑API. It depends on core's **Block**, **REST**, and
**Serialization** modules, and supports Drupal 10 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   pull in the core dependencies.
2. [Configuration](configuration/index.md) — set your API key, base currency, and
   caching, then place and tune the two blocks.

## Where it lives in the admin menu

The module's global settings sit at **Configuration → System → Exchange Rate
Settings**, where you enter the API key, pick the base currency, and set caching.
The blocks themselves are placed from **Structure → Block layout → Place block**.
See [Configuration](configuration/index.md) for the walk‑through.
