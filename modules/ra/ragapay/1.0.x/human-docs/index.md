# RagaPay — manual setup guide

**RagaPay** (`ragapay`) integrates the **RagaPay** payment gateway with **Drupal
Commerce** as an off‑site (redirect) payment method. At checkout the customer is
redirected to RagaPay to pay, and RagaPay then sends a server‑to‑server notification
back to your site to report the result. The module maps RagaPay's payment statuses to
Commerce payment states, so a successful payment marks the order's payment as
completed.

It provides one Commerce payment gateway plugin, **RagaPay (Off‑site redirect)**. On
the way out, the module builds a signed hash from the order details and your gateway
password, so RagaPay can trust the request it receives. On the way back, RagaPay POSTs
to a notification endpoint (`/ragapay/notification`) and the module updates the
matching order's payment state from the reported status.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer alongside Drupal
   Commerce and enable it.
2. [Configuration](configuration/index.md) — add the RagaPay gateway in Commerce,
   enter your merchant credentials, and register the notification URL.

## Where it lives in the admin menu

RagaPay does not add a settings page of its own — you configure it as a Commerce
payment gateway at **Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`).
