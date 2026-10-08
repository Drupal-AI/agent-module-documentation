# LiqPay API 3.0 (v2) — manual setup guide

**LiqPay API 3.0 (v2)** (`liqpay`) connects a Drupal site to the **LiqPay**
(liqpay.ua) payment gateway, popular for Ukrainian / UAH online stores. It renders
a LiqPay checkout form, sends the buyer to LiqPay to pay, receives LiqPay's
server‑to‑server result callback, and records each payment in its own database
table. It is designed to plug into the **Basket** commerce module's checkout, but
it can also be used standalone for one‑off payments.

You configure it on a single admin form: enter your LiqPay **public** and
**private** keys (with a separate sandbox pair so you can test before going live),
the default currency, an order description, and the success message. Payments are
created as rows in the module's `payments_liqpay` table; the buyer is auto‑posted
to LiqPay's checkout, and when LiqPay calls back with the result the module
**verifies the signature** before marking any order paid — so only genuine LiqPay
results update an order. It supports LiqPay's subscription and hold/authorize
statuses, maps LiqPay error codes to readable messages, and can poll LiqPay for
status if the callback is delayed.

Because payment keys are secrets, this guide follows the project convention of
keeping the **private key out of exported configuration** — enter it in the UI for
quick testing, but on real sites override it from an environment variable in
`settings.php` (or a Key entity). Access to the settings form is gated by the
module's own **Access LiqPay settings** permission, which is a restricted
permission.

The module targets **Drupal 10, 11, or 12** and has no other module dependencies
(Basket is optional).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the settings form field by field,
   sandbox vs live keys, keeping secrets safe, and Basket integration.

## Where it lives in the admin menu

- The settings form is at **Configuration → Development → LiqPay**
  (`/admin/config/development/liqpay`).
- Recorded payments are listed at
  **Configuration → Development → LiqPay → Payments**
  (`/admin/config/development/liqpay/payments`).

## How to use it

Get your API keys from your LiqPay account, enter them on the settings form (start
in sandbox), pick the currency and messages, and — if you use Basket — enable
LiqPay as a payment method in Basket's checkout. See
[Configuration](configuration/index.md) for each step.
