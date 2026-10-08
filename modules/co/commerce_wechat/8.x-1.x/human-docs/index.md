# Commerce WeChat Pay — manual setup guide

**Commerce WeChat Pay** (`commerce_wechat`) integrates **WeChat Pay (APIv3)** as
a payment gateway for Drupal Commerce — the most popular payment method in China.
It supports **Native** (PC QR‑code) payments, **H5** (mobile browser) payments,
and **JSAPI** (in‑WeChat) payments, and it handles full and partial **refunds**.
The gateway automatically detects the payment scenario and calls the matching
WeChat API.

The problem it solves: WeChat Pay's v3 protocol involves signed, AES‑GCM
encrypted notifications and rotating platform certificates. This module builds all
of that on WeChat's official SDK — it verifies each asynchronous notification's
signature against the WeChat platform certificate (which it fetches and refreshes
automatically), decrypts the payload, binds the payment to your local order by
`out_trade_no`, and only completes the payment when the trade state is `SUCCESS`
with a matching amount and currency. On the return page it re‑queries WeChat
directly rather than trusting the browser.

It depends on Commerce **Payment** (`commerce_payment`) and on **Yunke QR Code**
(`yunke_qrcode`), which supplies the configurable PC payment QR code. It also
needs WeChat's official PHP SDK, so it **must be installed with Composer** so the
SDK is registered with the class loader.

The gateway does **not** work on enable — you must add a WeChat Pay gateway and
enter your merchant credentials (App ID, Merchant ID, APIv3 key, merchant serial
number, and the merchant private key). Note the project is **not covered by
Drupal's security advisory policy**, though the notification and return handling
were reviewed as sound.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (WeChat SDK plus
   the `yunke_qrcode` dependency) and enable the module.
2. [Configuration](configuration/index.md) — add the WeChat Pay gateway and enter
   your merchant credentials.

## Where it lives in the admin menu

Commerce WeChat Pay adds no top‑level admin page. As a Commerce payment gateway
you configure it under **Administration → Commerce → Configuration → Payment
gateways** (`/admin/commerce/config/payment-gateways`), choosing **WeChat Pay**
as the plugin. See [Configuration](configuration/index.md).
