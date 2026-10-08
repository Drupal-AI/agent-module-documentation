# Commerce KNET — manual setup guide

**Commerce KNET** (`commerce_knet`) integrates the **KNET** payment gateway with
Drupal Commerce. KNET is Kuwait's national debit‑card payment network, so this
module is what a Kuwaiti store uses to accept KNET card payments at checkout. The
shopper is sent to KNET to pay and returns to your store with an
**AES‑encrypted response** (`trandata`) that the module decrypts and verifies.

It depends on **Commerce Payment** (`commerce_payment`).

When the shopper comes back from KNET, the module **decrypts the `trandata`
response using the merchant's terminal resource key**, then checks the outcome
**server‑side** before recording a payment: the transaction result must be
**`CAPTURED`**, the returned order id must match the order in the URL, and the
**returned amount must equal the order's own total**. Your job is to store the
**KNET credentials** (terminal ID and resource key) securely — environment‑backed,
never committed — and to serve the return callback over HTTPS.

> **Compatibility caveat.** The bundled `SecureText` helper uses a PHP‑7‑only code
> construct (curly‑brace string offset, `$text{…}`) that is a **parse error on
> PHP 8**. Because Drupal 10 and 11 run on PHP 8, the encrypt (checkout redirect)
> and decrypt (return) code fatals on those versions until the module is patched
> (change `$text{…}` to `$text[…]` in `src/Helper/SecureText.php`). Test the full
> pay‑and‑return flow before relying on this module in production.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — add the KNET payment gateway, enter
   your terminal credentials, and choose test versus live.

## Where it lives in the admin menu

KNET is configured as a Commerce **payment gateway** under **Administration →
Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`). Add a new gateway, choose the KNET
plugin, and configure it as described in [Configuration](configuration/index.md).
