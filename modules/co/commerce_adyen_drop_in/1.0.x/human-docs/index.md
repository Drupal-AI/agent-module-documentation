# Commerce Adyen Drop-in — manual setup guide

**Commerce Adyen Drop-in** (`commerce_adyen_drop_in`) is a Drupal Commerce payment
gateway built around Adyen's modern **Drop-in** JavaScript component and the Adyen
**Checkout Sessions** flow. The Drop-in renders Adyen's payment UI client‑side, an
Adyen session authorises the payment, and Adyen's webhook finalises it — the
current, recommended way to integrate with Adyen. It also supports refunds through
the Adyen Checkout API.

It depends on Drupal Commerce and Commerce Payment (`commerce_payment`), and needs
the **Adyen PHP API library** (`Adyen\Client`) pulled in via Composer. Billing
information is required by the gateway.

Security here is well handled, and it's worth knowing how so you don't accidentally
weaken it. The gateway does **not** trust the browser result: on return it
re‑fetches the session status directly from Adyen, and it finalises payment only
from Adyen's webhook. Every incoming webhook notification is **HMAC‑verified** —
notifications that fail the signature check are logged and skipped, and only
`AUTHORISATION` events with `success == true` create a payment. The order and
amount are taken from the *signed* notification payload (`merchantReference` and the
signed amount), and duplicate notifications for the same `pspReference` are detected
and skipped. Your Adyen **API key, client key, and HMAC key are secrets** — store
them securely and serve everything over HTTPS (the Adyen client uses default TLS
verification).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (including the
   Adyen PHP SDK) and enable the module.
2. [Configuration](configuration/index.md) — add the Adyen Drop-in gateway, enter
   your credentials, and set up the Adyen webhook.

## Where it lives in the admin menu

Like every Commerce payment gateway, you add and configure it under
**Administration → Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`). See
[Configuration](configuration/index.md) for the fields.
