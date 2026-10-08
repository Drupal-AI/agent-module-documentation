# Nexi XPay — manual setup guide

**Nexi XPay** (`nexi_xpay`) lets a Drupal 11 site accept online payments through
the **Nexi XPay Hosted Payment Page** using configuration only — no custom
checkout code and no handling of sensitive card data on your server. Customers are
redirected to Nexi's hosted checkout to pay and returned to your site afterwards,
so the card details never touch Drupal. It is aimed at site builders who need a
ready‑to‑use payment flow, while still offering a plugin system for developers who
want to extend it with additional Nexi payment modes.

The module introduces a **Nexi XPay transaction** entity to store payments
persistently. After configuring your Nexi credentials, you create a transaction,
and the module generates a payment link you can share with a user; it handles the
redirect to Nexi, the return and cancellation pages, and the server‑to‑server
**notify** callback that confirms the outcome. Payment status handling is designed
to be reliable and idempotent, so a repeated notification does not double‑process a
payment. Notably, this module does **not** depend on Drupal Commerce — it works on
any Drupal 11 site.

On the security side, the notify endpoint is genuinely locked down: each
transaction gets its own 256‑bit secret token embedded in the notify URL
(`/nexi-xpay/notify/{transaction}/{token}`), and the module verifies that token
with a constant‑time `hash_equals()` comparison before accepting the
notification, so forged callbacks are rejected. (See the
[Configuration](configuration/index.md) page for what this means for you and how
to store your Nexi credentials safely.) It requires **Drupal 11.3+**, **PHP 8.3+**,
and an **HTTPS** site, and depends only on core modules (`field`, `options`,
`system`, `user`).

> **Heads up:** this project is under active development and is currently **not
> covered by Drupal's security advisory policy**. Test thoroughly in Nexi's
> sandbox before taking real payments.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and confirm the requirements.
2. [Configuration](configuration/index.md) — set the Nexi environment and
   credentials, store secrets safely, and understand the payment flow.

## Where it lives in the admin menu

The settings form is at **Administration → Configuration → Web Services → Nexi
XPay** (`/admin/config/services/nexi_xpay`). Transactions are managed at
**Content → Nexi XPay transactions**. Two permissions gate access: **administer
nexi xpay** (the settings form) and **view nexi xpay transactions**.

## How to use it

1. Configure the Nexi environment (Test or Production) and credentials — see
   [Configuration](configuration/index.md).
2. Go to **Content → Nexi XPay transactions** and create a new transaction.
3. Share the generated **payment link** with the user who needs to pay.
4. The customer is redirected to the Nexi Hosted Payment Page, pays, and is
   returned to your site; Nexi's server‑to‑server notify callback updates the
   transaction's status.
