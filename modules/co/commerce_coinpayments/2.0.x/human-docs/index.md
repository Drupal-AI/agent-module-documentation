# CoinPayments — manual setup guide

**CoinPayments** (`commerce_coinpayments`) adds an **off‑site (redirect)
cryptocurrency payment gateway** to Drupal Commerce, powered by
**CoinPayments.net**. It lets your store accept a wide range of cryptocurrencies:
the customer is redirected to CoinPayments' hosted checkout to pay, and the store
is notified of the result asynchronously through an **Instant Payment Notification
(IPN)** callback — which keeps card/wallet handling entirely off your server.

At checkout the gateway posts the order to CoinPayments' hosted page; the customer
pays there; and CoinPayments then calls back to your site's IPN endpoint
(`/commerce_coinpayments/ipn`). The IPN handler validates the notification before
transitioning the payment or order, mapping CoinPayments' statuses to Commerce
payment states so orders finalize only on a genuine, confirmed payment.

Security is soundly handled. The IPN handler **verifies the CoinPayments HMAC
signature** — it computes an HMAC‑SHA512 of the raw POST body using your configured
**IPN secret** and compares it to the request's `HMAC` header, and it also checks
the merchant id, currency, and amount before acting. This closes the common "forged
IPN completes an order for free" hole. The IPN route is gated by a permission that
you must grant to anonymous (so CoinPayments' servers can reach it), but note the
**signature — not the permission — is the security control**, as explained in
[Configuration](configuration/index.md).

CoinPayments depends on Commerce (`commerce`) and Commerce **Payment**
(`commerce_payment`) and works on Drupal 8, 9, 10, and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Commerce Payment.
2. [Configuration](configuration/index.md) — adding the gateway, entering your
   merchant id, keys and IPN secret, and granting the IPN permission.

## Where it lives in the admin menu

Like every Commerce payment method, CoinPayments is set up under **Administration →
Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`). You add a gateway there and choose the
CoinPayments plugin. The IPN callback endpoint is `/commerce_coinpayments/ipn`.
