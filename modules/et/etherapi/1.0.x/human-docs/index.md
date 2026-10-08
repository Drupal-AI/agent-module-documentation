# EtherAPI — manual setup guide

**EtherAPI** (`etherapi`) lets a **Basket** (Drupal AlternativeCommerce) store
accept **Ethereum and other crypto** payments through the third‑party
[etherapi.net](https://etherapi.net/) service. It registers a Basket payment method:
a shopper is shown a pay page with the crypto amount and receiving address to send,
and when etherapi.net observes the transaction on‑chain it notifies your site to
mark the order paid.

Confirmation happens through a **signed server‑to‑server callback**. When
etherapi.net POSTs to your site's status endpoint, the module verifies the
notification before completing the order: it can check the source IP against an
allow‑list, requires an etherapi.net marker in the request, loads the matching
payment, and recomputes a signature using your **per‑currency API key as the shared
secret**, which must match the signature sent. Only on a match does it record the
payment and complete the Basket order.

The most important setup rule is: **set a strong API key for every currency you
accept.** Filling in the callback IP allow‑list is also recommended. The module can
also run in a test mode.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Basket dependency.
2. [Configuration](configuration/index.md) — create the Basket payment point and
   enter your etherapi.net API key(s), wallet address and callback allow‑list.

## Where it lives in the admin menu

You first create a payment point that uses EtherAPI under Basket's payment settings
(**/admin/basket/settings-payment**), then configure the gateway itself at
**Configuration → Development → EtherAPI** (`/admin/config/development/etherapi`),
reachable by users with the **Access EtherAPI settings** permission.

## How to use it

Once configured, EtherAPI appears as a payment method during Basket checkout. The
shopper is sent to a pay page showing the crypto amount and address; after they
send the funds, etherapi.net confirms the transaction to your site via the signed
callback, which completes the order automatically. Payment records are tracked in
the module's own database table, moving from a `new` status to `pay` on
confirmation.
