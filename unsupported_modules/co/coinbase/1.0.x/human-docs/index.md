# Commerce Coinbase — manual setup guide

**Commerce Coinbase** (`coinbase`, project `coinbase_payment`) adds an **off-site
Drupal Commerce payment gateway** that lets shoppers pay in cryptocurrency through
**Coinbase Commerce**. At checkout the gateway takes the order total, creates a
Coinbase Commerce *charge* for that amount and currency, and redirects the buyer to
Coinbase's hosted checkout page to complete payment.

It plugs into Drupal Commerce, so it depends on the **Commerce** and **Commerce
Payment** modules. Configuration is minimal: the gateway stores a single **Coinbase
Commerce API key**, which you paste in when you add the gateway to your store.

> **Important security caveat — read before using in production.** In the version
> documented here, the module creates the Coinbase charge and redirects the buyer,
> but it implements **no return or notify (webhook) handler** and declares no
> notify route. That means there is **no server-side verification that a charge was
> actually paid** — Coinbase's callback is never validated (no webhook signature
> check), and no completed Commerce payment is recorded from a confirmed charge. In
> practice, payment success is never confirmed automatically. If you use this
> gateway, you must **reconcile payments manually** against your Coinbase Commerce
> dashboard, and you should treat automated order fulfilment as unsafe until this
> is addressed. The module is also **not covered by Drupal's security advisory
> policy**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Drupal Commerce.
2. [Configuration](configuration/index.md) — add the gateway, paste the API key,
   and add it to a checkout flow.

## Where it lives in the admin menu

The gateway is configured like any other Commerce payment gateway, under
**Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`). It has no separate module settings
page of its own.
