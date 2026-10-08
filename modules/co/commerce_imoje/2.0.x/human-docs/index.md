# Commerce Imoje — manual setup guide

**Commerce Imoje** (`commerce_imoje`) integrates the **imoje** payment gateway
(the Polish payment service from ING) with Drupal Commerce. It adds two payment
methods to your store: **imoje** (an off-site redirect where the shopper pays on
imoje's page) and **imoje Blik** (an on-site BLIK transaction). It also supports
issuing refunds straight from the Drupal admin interface.

The gateway completes orders safely: when imoje posts its payment notification
(IPN), the module validates the `X-Imoje-Signature` header — a SHA-256 of the
payload with your service key — **before** completing the order, and throws on a
mismatch. That is the correct, defensive pattern: a payment is only recorded when
the notification is proven genuine. Store your imoje API credentials securely and
never commit them. It depends on Commerce Payment and runs on Drupal 10 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — add the imoje gateways, enter your
   credentials, and set the notification address in the imoje panel.

## Where it lives in the admin menu

Like every Commerce gateway, imoje is added under **Administration → Commerce →
Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`) — click **Add payment gateway** and
choose the imoje plugin. See [Configuration](configuration/index.md).
