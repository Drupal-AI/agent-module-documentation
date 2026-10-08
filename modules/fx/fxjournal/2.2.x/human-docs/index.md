# Forex Journal — manual setup guide

**Forex Journal** (`fxjournal`) turns your Drupal site into a structured trading
journal for foreign‑exchange (forex) traders. Instead of tracking trades in a
spreadsheet, you record each position as content — with its currency pair, entry
and exit prices, open and close dates, and the outcome — so you can review your
trading history and build statistics over time.

It models a trading journal as a small set of custom entity types that reference
one another:

- **Forex Journal Account** — a trading account: broker name, connection server,
  leverage, and account currency.
- **Forex Journal Symbol** — a tradable symbol such as EURUSD or USDJPY, with a
  configurable number of decimal digits so pip differences and profits are
  calculated precisely.
- **Forex Journal Event** — a labelled event that happened during a position's
  life (for example *Important News*, *Strong Indicator Signal*, or *Closed
  manually*); you can define as many event types as you like and attach them to
  records to sharpen your statistics.
- **Forex Journal Record** — the trade itself: open/close dates, open/close
  prices, and references to the account, symbol, and events that give the position
  its full context.

Each trader gets a **dashboard** on their user profile at
`/user/{user}/fxjournal/dashboard`. Because these are proper Drupal entities, you
can extend any of them with custom fields, expose them in Views, and read or write
them through the JSON:API.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its core dependencies.

There is **no single global settings form** — you work with the module by
creating its entities (accounts, symbols, events, records) and viewing the
per‑user dashboard, as described below.

## Where it lives in the admin menu

Forex Journal provides its own permissions, managed at **People → Permissions**.
Each trader's dashboard is at **`/user/{user}/fxjournal/dashboard`** on their user
profile.

## How to use it

A sensible order to set things up:

1. Create one or more **Forex Journal Account** entities for the trading accounts
   you use (broker, server, leverage, account currency).
2. Create the **Forex Journal Symbol** entities for the pairs you trade (EURUSD,
   USDJPY, …), setting the correct number of decimal digits for each so pip and
   profit maths are accurate.
3. Optionally define **Forex Journal Event** types for the situations you want to
   flag on trades.
4. Log each trade as a **Forex Journal Record**, referencing the account, symbol,
   and any relevant events, and filling in the open/close dates and prices.
5. Review your history on the dashboard at **`/user/{user}/fxjournal/dashboard`**,
   and build your own Views reports over the record data if you want custom
   statistics.
