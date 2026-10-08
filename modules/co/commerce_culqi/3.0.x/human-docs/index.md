# Commerce Culqi — manual setup guide

**Commerce Culqi** (`commerce_culqi`) integrates the **Culqi** payment gateway —
a Peruvian payment provider — with Drupal Commerce. It gives your store two ways
to take money: **card charges** (through Culqi's JavaScript tokenization) and a
**cash / PagoEfectivo** flow, where the customer receives payment instructions and
pays offline.

Under the hood it ships two payment gateway plugins — one for cards
(`CulqiPaymentGateway`) and one for cash (`CulqiCashPaymentGateway`) — plus a
checkout pane that shows the cash‑payment instructions to the customer. The
front‑end Culqi JS tokenizes the card in the browser and calls the module's AJAX
endpoints to create the charge and order, so raw card numbers do not pass through
your own forms.

It needs **Commerce Payment** (`commerce_payment`) and core **Basic Auth**
(`basic_auth`), and it targets Drupal 11. You configure it like any other
Commerce gateway, entering your Culqi **public** and **secret** API keys.

> **Security caveat you should know before going live.** The public agent docs for
> this module record a **price‑manipulation** issue: the `create_charge` endpoint
> is reachable **anonymously**, and the charge amount is taken from the incoming
> request rather than re‑derived from the Commerce order total. That means a
> caller could, in principle, control the amount that gets charged. If you deploy
> this module, treat those endpoints as untrusted input — validate the amount
> server‑side against the order before charging, and/or restrict the endpoint at
> the edge if you do not need it exposed. See
> [Configuration](configuration/index.md) for details.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its dependencies.
2. [Configuration](configuration/index.md) — add the Culqi card and cash payment
   gateways, enter your API keys, and understand the security caveat.

## Where it lives in the admin menu

Like every Commerce gateway, Culqi is added under **Administration → Commerce →
Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`). There is no separate settings page —
the gateway's configuration form is where you enter your Culqi keys.
