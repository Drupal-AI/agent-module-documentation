# Commerce USAePay — manual setup guide

**Commerce USAePay** (`commerce_usaepay`) provides an **on‑site credit‑card
payment gateway** for **USAePay** in Drupal Commerce. Card payments are captured
through USAePay's API (via SOAP), and the module records the resulting payment
against the order. It depends on **Commerce Payment**.

Because it is an on‑site gateway, the payment form is served on your site rather
than redirecting the customer away. Its payment handling is
**server‑authoritative**: the module submits the transaction to **USAePay's API
server‑side** and derives the outcome from the API response's **`ResultCode`**
(`A` = approved → completed, `D` = declined, and so on). The result therefore comes
from the authenticated API call, not from any client‑supplied field, so the browser
is never trusted for payment status.

Because it is on‑site, card details are entered on your own checkout form and sent
**server‑side** to USAePay's SOAP API. Serve the site over **HTTPS** and meet the
**PCI responsibilities** that apply to your store. Store your USAePay **API
credentials** (the WSDL key, source key, and PIN) as secrets. The module has no
access‑control role of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, confirm PHP SOAP
   is available, and enable the module.
2. [Configuration](configuration/index.md) — add the USAePay payment gateway and
   enter your credentials securely.

## Where it lives in the admin menu

USAePay is added under **Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`). See
[Configuration](configuration/index.md).
