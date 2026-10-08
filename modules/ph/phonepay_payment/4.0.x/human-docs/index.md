# PhonePe Payment — manual setup guide

**PhonePe Payment** (`phonepay_payment`) adds a
[PhonePe](https://www.phonepe.com/) payment gateway to **Drupal Commerce**, so
shoppers can pay for orders through India's PhonePe platform (UPI, cards and
wallet) using a redirect‑and‑callback flow. The customer is sent to PhonePe to pay,
and PhonePe calls back to your site to report the result.

You add it like any other Commerce payment gateway, then enter your PhonePe
merchant credentials. It also expects a customer **profile type** with an address
field and a mobile‑number field so it can pass the required customer details to
PhonePe's API.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Drupal Commerce.
2. [Configuration](configuration/index.md) — add and configure the PhonePe gateway
   and store the credentials safely.

## Where it lives in the admin menu

You add the gateway from **Commerce → Configuration → Payment gateways → Add
payment gateway** (`/admin/commerce/config/payment-gateways/add`) and choose
PhonePe. Full field‑by‑field guidance is on the
[Configuration](configuration/index.md) page.
