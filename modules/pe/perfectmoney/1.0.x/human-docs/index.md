# Perfect Money — manual setup guide

**Perfect Money** (`perfectmoney`) adds a
[Perfect Money](https://perfect.money/) payment method to the
**AlternativeCommerce (Basket)** commerce module. If your store runs on Basket
and you want to take payments through Perfect Money, this module registers
Perfect Money as a Basket payment point, redirects shoppers to the gateway to
pay, and handles their return.

The important part happens on the way back. When Perfect Money sends the
shopper back to your site with a payment status, the module does not simply
trust that message. It recomputes an MD5 hash from the returned fields —
including the paid amount — using your secret passphrase, and compares it to
the `V2_HASH` value the gateway supplied. Only if the two match does it treat
the order as paid. That means a forged callback from someone who does not know
your passphrase is rejected, and the amount is confirmed as part of the same
check. Keep the passphrase secret and this verification holds.

A test mode lets you trial the whole flow before switching to live payments,
and the gateway settings form is restricted to users with the
`access perfectmoney settings` permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install Basket and this module with
   Composer, then enable it.
2. [Configuration](configuration/index.md) — create the Basket payment point and
   enter your Perfect Money credentials, field by field.

## Where it lives in the admin menu

There are two places you will visit:

- **Store → Payment settings** (`/admin/basket/settings-payment`) — where you
  create a Basket payment point and choose the "Perfect Money" service. This
  page comes from the Basket module.
- **Configuration → Development → Perfect Money**
  (`/admin/config/development/perfectmoney`) — the gateway's own settings form,
  where you enter your payee account and passphrase and toggle test mode. It
  requires the `access perfectmoney settings` permission.

The shopper-facing payment landing pages are served under
`/perfectmoney/{page_type}`; you do not build these yourself — the module renders
them and processes the gateway's return there.
