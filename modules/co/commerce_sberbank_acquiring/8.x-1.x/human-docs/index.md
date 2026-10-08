# Sberbank Acquiring — manual setup guide

**Sberbank Acquiring** (`commerce_sberbank_acquiring`) adds a Drupal Commerce
payment gateway for **Sberbank's acquiring service**, so a store can accept card
payments through Sberbank. When a customer pays, the module registers the order
with Sberbank's REST API and then confirms the payment's status by querying that
same API server-side — the payment result comes from Sberbank, not from anything
the customer's browser reports.

It is meant for merchants who have a Sberbank acquiring contract. The module
depends on Drupal **Commerce** (the **Payment** module, `commerce_payment`) and
adds no permissions or access role of its own.

One thing to be aware of: this project is **not covered by Drupal's security
advisory policy**. That does not mean it is unsafe, but it does mean security
issues are not tracked through the official process — weigh that when deciding to
use it on a production store, and keep it updated yourself.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — add the Sberbank gateway and enter
   your credentials, field by field.

## Where it lives in the admin menu

There is no separate settings page. You configure it by adding a payment gateway
under **Administration → Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`) — the project's own instructions
phrase this as *Store → Configuration → Payments → Payment Gateways* — and
choosing the Sberbank Acquiring plugin. See
[Configuration](configuration/index.md).
