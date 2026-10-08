# Currency API — manual setup guide

**Currency API** (`currencyapi`) integrates Drupal with
[currencyapi.com](https://currencyapi.com) to fetch **real‑time currency exchange
rates** and display them on your site. Its distinctive feature is the ability to
apply and expose **custom markups** on top of the raw rates — fixed fees,
percentage margins, or blended rates — so you can present customer‑facing buy/sell
rates that include your FX fees or profit margin. That makes it a fit for
financial services, e‑commerce, travel/ticketing, and multi‑currency platforms.

It fetches rates from currencyapi.com's REST API (JSON) on a cron‑driven schedule,
caches them to reduce API calls, and lets you embed the resulting rate tables
anywhere — via Views, blocks, or templates. It supports 150+ currencies with
optional crypto/fiat pairs, and it's a lightweight standalone module with **no
module dependencies** (though it's compatible with Commerce).

Currency API **needs configuration before it does anything**: you supply your
currencyapi.com key, define your markup rules, and pick which currencies and how
often to refresh. Because it talks to an external service with an API key, treat
that key as a secret — see the security notes in [Configuration](configuration/index.md).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — add your API key, set markup rules,
   and choose currencies and refresh intervals.

## Where it lives in the admin menu

The module's settings live on the **Currency API settings** form (config object
`currencyapi.settings`), reached from the **Configuration** section of the admin
menu. That's where you enter the API base URL, your API key, and the markup and
currency settings — see [Configuration](configuration/index.md).
