# Commerce Open Payment Platform — manual setup guide

**Commerce Open Payment Platform** (`commerce_opp`) integrates the **ACI PAY.ON
Payments Gateway** — formerly and still commonly called the **Open Payment Platform
(OPPWA)** — with Drupal Commerce, embedding the **COPYandPAY / PAYFRAME** payment
widget in the Commerce checkout flow. The same platform is white-labelled under
different names by country: SIBS "SIBS Payments" in Portugal, Hobex and Viveum
("VIVEUM Meteorpay") in Austria, and others.

The problem it solves is accepting OPP payments — cards and alternative methods such
as **MB WAY** — in a Commerce store, with a solid trust boundary. It depends on
Commerce **Payment** (`commerce_payment`). An optional **webhooks submodule**
(`commerce_opp_webhooks`) handles asynchronous payment notifications.

This is not a works-on-enable module: you add a Commerce payment gateway of type
Open Payment Platform, enter your OPP API credentials, and — if you use the webhooks
submodule — set and protect an encryption secret. Its payment confirmation is
**server-authoritative** (reviewed): the module never marks a payment paid from a
client-supplied field; it re-queries the authoritative status from the OPP API and
verifies the order matches.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the module,
   and (optionally) the webhooks submodule.
2. [Configuration](configuration/index.md) — add the OPP payment gateway, enter your
   credentials, and set the webhook encryption secret.

## Where it lives in the admin menu

Open Payment Platform is a payment gateway, so you set it up under **Commerce →
Configuration → Payment gateways** (`/admin/commerce/config/payment-gateways`) →
**Add payment gateway** → choose the **Open Payment Platform** plugin.
