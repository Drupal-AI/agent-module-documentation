# Commerce Currency Mismatch Prevention — manual setup guide

**Commerce Currency Mismatch Prevention** (`commerce_currency_mismatch_prevention`)
stops a Drupal Commerce cart from ending up with items priced in **different
currencies**. Commerce cannot total a cart that mixes currencies — it throws a
`CurrencyMismatchException` and checkout breaks — and this module intervenes
before that happens.

The problem it solves is a specific, painful failure: on a multi‑currency store, a
shopper adds a product priced in one currency to a cart that already holds items
priced in another, and the "The provided prices have mismatched currencies" error
appears. Rather than letting the cart reach that broken state, this module detects
the conflict at add‑to‑cart time and resolves it according to a behavior you
choose.

It is a **cart‑integrity safeguard** with no payment role and no exchange‑rate
calculation of its own — it simply prevents the mismatch. (If you need actual
currency conversion and customer‑preferred pricing, that is
`commerce_currency_resolver`'s job, not this module's.) It depends on **Drupal
Commerce** (`commerce`), **Commerce Cart** (`commerce_cart`), and **Commerce
Order** (`commerce_order`), requires **Drupal Commerce 3**, and runs on **Drupal 11**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — choose how the module resolves a
   currency conflict.

## Where it lives in the admin menu

The module's settings live at **Commerce → Configuration → Store → Currency
mismatch prevention**. That single form is where you pick the behavior; see
[Configuration](configuration/index.md).
