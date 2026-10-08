# Commerce eProcessingNetwork — manual setup guide

**Commerce eProcessingNetwork** (`commerce_epn`) is an **on‑site** credit‑card
payment gateway for Drupal Commerce that charges cards through the
**eProcessingNetwork (EPN)** transaction API. Card details are collected on your
store's own checkout form, and your server posts the transaction directly to EPN's
endpoint over HTTPS. EPN stores the card and returns a transaction id, so later
charges can be made without the full card number.

It implements the full on‑site payment lifecycle: tokenise/store a card,
sale or authorise‑only, capture a prior authorisation, void, and refund
(partial or full). Each request is authenticated with your EPN account username
and Restrict Key, and it supports recurring payments via `commerce_recurring`.
Because this is an **on‑site** gateway, card numbers pass through your site during
checkout, which brings standard **PCI** handling responsibilities — only the last
four digits are stored locally, but you must run over HTTPS and treat the whole
payment path accordingly.

Two things to know before go‑live, both covered on the Configuration page. First,
the module ships with EPN's **public sandbox credentials** as defaults so a fresh
gateway works against the EPN test account immediately — you must replace them
with your own account before taking real payments. Second, the maintainers
recommend keeping your live username and Restrict Key out of the gateway UI (which
can leak production credentials onto test/dev copies) and instead overriding them
in `settings.local.php`. On the plus side, there is no inbound webhook or return
route to forge, and the charged amount always comes from the order/payment, never
from a client request.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — add the EPN gateway, replace the
   sandbox credentials, and keep live keys out of the UI.

## Where it lives in the admin menu

Commerce eProcessingNetwork has no settings page of its own. Like every Commerce
payment method, it is added under **Administration → Commerce → Configuration →
Payment gateways** (`/admin/commerce/config/payment-gateways`) by adding a gateway
and choosing the **eProcessingNetwork gateway** plugin.
