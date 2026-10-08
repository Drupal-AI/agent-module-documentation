# Crypto Widget — manual setup guide

**Crypto Widget** (`crypto_widget`) provides a block that shows the current
price of a cryptocurrency you choose, refreshing on a timer. It fetches prices
from Coinbase's **public, unauthenticated** price API, so there is no account,
wallet, API key, or secret to set up anywhere — the block simply reflects public
market data. The supported coins include Bitcoin, Ethereum, Tether, Cardano,
Bitcoin Cash, Litecoin, Uniswap, Chainlink, and a dozen more, and each coin's
icon comes from cryptoicons.co.

The price is fetched **client-side**: the module attaches a small JavaScript
library that queries Coinbase from the visitor's browser and updates the
displayed value, which keeps your pages cacheable and works fine for anonymous
visitors. Everything an editor needs — the coin, the display currency (EUR or
USD), and how often the value refreshes — is configured directly on the block
when you place it, so there is no separate module settings page.

The module requires nothing outside Drupal core and works on Drupal 8 through 11.
It becomes useful the moment you place its block in a region.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no module‑wide configuration page** — you configure each price block
where you place it, as described in "How to use it" below.

## Where it lives in the admin menu

Crypto Widget adds no admin settings page of its own. You work with it entirely
through the block layout at **Structure → Block layout**
(`/admin/structure/block`), where you place and configure the "Crypto widget"
block.

## How to use it

1. Go to **Structure → Block layout** and click **Place block** in the region
   where you want the price to appear.
2. Find **Crypto widget** in the list and place it.
3. In the block configuration form, choose:
   - the **cryptocurrency** whose price to display (Bitcoin, Ethereum, and so on);
   - the **currency** to show the price in (EUR or USD);
   - the **refresh period** — how often the widget re‑queries the price
     (5, 10, 30, or 60 minutes).
4. Click **Save block**.

You can place several Crypto widget blocks on one page — for example a small
market ticker in a sidebar or footer showing different coins.
