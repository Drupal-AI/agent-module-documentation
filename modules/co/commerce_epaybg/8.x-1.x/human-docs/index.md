# Commerce EpayBG — manual setup guide

**Commerce EpayBG** (`commerce_epaybg`) adds an off‑site redirect payment gateway
for the Bulgarian **ePay.bg** service to Drupal Commerce. At checkout the shopper
is redirected to ePay.bg with a signed, base64‑encoded payment request, enters
their details on ePay's page, and ePay then sends your site a server‑to‑server
notification (IPN) with the result. The module verifies ePay's **HMAC‑SHA1
signature** on that notification before it changes any payment state, so a forged
or tampered notification is rejected.

It depends on Drupal Commerce and its **Payment** module (`commerce`,
`commerce_payment`). Nothing happens on enable alone — you add and configure a
gateway of type *EpayBG (Redirect to EpayBG system)* with your merchant id (MIN),
secret key and related details, and give ePay the module's notify (IPN) URL. An
install step creates a small tracking table that binds each ePay invoice to the
originating Commerce order, so notifications always resolve to the right order.

Security here is sound: the notification checksum is an HMAC‑SHA1 keyed by your
merchant **secret**, the payload is only parsed when the checksum matches, and the
payment amount is taken from the order total. The one thing that matters most in
practice is keeping that secret confidential — it is the sole signature key.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — add the EpayBG gateway, enter your
   MIN and secret, and give ePay the notify URL.

## Where it lives in the admin menu

Commerce EpayBG has no settings page of its own. Like every Commerce payment
method, it is added under **Administration → Commerce → Configuration → Payment
gateways** (`/admin/commerce/config/payment-gateways`) by adding a gateway and
choosing the **EpayBG (Redirect to EpayBG system)** plugin.
