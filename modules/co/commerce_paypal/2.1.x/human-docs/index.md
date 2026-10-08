# Commerce PayPal — manual setup guide

**Commerce PayPal** (`commerce_paypal`) lets a Drupal Commerce store accept
payments through PayPal. It adds several PayPal payment *gateways* to Commerce so
your customers can pay with their PayPal balance, a credit or debit card, or a
"pay later" option, depending on which PayPal product you enable. It plugs into
Drupal Commerce's standard payment framework, so PayPal payments appear alongside
any other gateways you have configured, and you manage captures, refunds, and voids
from the normal order screens.

The module offers a family of gateways covering both modern and legacy PayPal
products (summarized below). For a new store, **PayPal Checkout** — which renders
PayPal's Smart Payment Buttons and optional card fields — is the preferred, actively
developed choice. Each gateway is set up the same way in Commerce: you choose the
gateway, pick **Test** (Sandbox) or **Live** mode, and paste in the credentials
PayPal gives you.

The module requires **Drupal Commerce** (`commerce`, `^2.40 || ^3`) and its
**Commerce Payment** submodule, PHP 8.0+, and Drupal 9.3, 10, or 11. It provides no
Drupal submodules of its own — the different PayPal products are gateway plugins you
select when adding a payment gateway. Note that actually processing a payment
requires real PayPal credentials and outbound network access; without them you can
still configure and inspect the gateways but cannot complete a transaction.

This guide is written for a **human** setting up the store through the admin UI. If
you want terse, token-cheap references for an AI coding agent — the gateway plugin
ids, the exact configuration keys, and the REST SDK layer — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (including Drupal
   Commerce) and enable the module.
2. [Configuration](configuration/index.md) — add a PayPal gateway, choose the
   product, and enter Sandbox then Live credentials.

## The PayPal products (gateways) it provides

- **PayPal Checkout** (`paypal_checkout`) — *preferred, active.* Smart Payment
  Buttons plus optional hosted card fields, authorize-or-capture, webhooks, and
  refunds/captures/voids from the order admin. Best choice for new stores.
- **Fastlane by PayPal** (`paypal_fastlane`) — *preferred, active.* A branded card
  form that speeds up guest checkout.
- **PayPal Express Checkout** (`paypal_express_checkout`) — *legacy/deprecated.* The
  classic off-site redirect flow using the old NVP/SOAP API; kept for existing
  stores.
- **PayPal Payflow** (`paypal_payflow`) — *legacy.* For stores on a Payflow merchant
  account (on-site card entry).
- **PayPal Payflow Link** (`paypal_payflow_link`) — *legacy.* Payflow via an embedded
  hosted (iframe) checkout, with optional reference transactions.

## Where it lives in the admin menu

PayPal gateways are added and edited on Commerce's own **Payment gateways** screen
at **Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`) — the module does not add a separate
settings page for them. The one extra screen it does add is the **PayPal Credit /
Pay Later messaging** settings at `/admin/commerce/config/payment/paypal-credit`.

## How to use it

Add a payment gateway in Commerce, choose one of the PayPal products above, set the
mode and credentials, and save. Then customers see the PayPal option at checkout
(and optionally a "Pay with PayPal" button on the cart). The
[Configuration](configuration/index.md) page walks through it, including how to test
in Sandbox first and then switch to Live.
