# Commerce Pesapal Payments — manual setup guide

**Commerce Pesapal Payments** (`commerce_pesapal`) adds a Drupal Commerce payment
gateway for **Pesapal**, the payment platform popular across East Africa and
beyond. It is an *off-site* (redirect) gateway: the shopper is sent to Pesapal to
pay, Pesapal calls back to an IPN (Instant Payment Notification) endpoint on your
site, and the customer is returned to the order.

The problem it solves is accepting Pesapal payments in Commerce without handling
card data yourself. A nice touch is that the module lets you configure both
**sandbox and live credentials** and gives you the ability to **test your API
configuration** before going live. It depends on Commerce's **Payment**,
**Order**, and **Price** modules and supports Drupal 10 and 11 (and requires
PHP 8.3+).

It does **not** work on enable alone — you must add a Pesapal gateway with your
consumer key and secret before it can take a payment. On the security side the
module verifies results server-side: the IPN handler does **not** trust the
status in the request. Instead it re-fetches the real transaction status from
Pesapal's API (OAuth HMAC-SHA1 signed), fulfils only on a re-fetched `COMPLETED`,
records the server-side order total rather than any amount in the request, and
de-duplicates by the remote transaction id.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — add the Pesapal gateway and enter
   your consumer key and secret.

## Where it lives in the admin menu

Commerce Pesapal adds no settings page of its own. You configure it as a payment
gateway under **Administration → Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`), where you add a new gateway and
choose the Pesapal plugin. Once saved and enabled, it appears as a payment option
at checkout. See [Configuration](configuration/index.md).

> **Note:** This release is a beta (1.0.0-beta1). Test it thoroughly — including
> Pesapal's demo/sandbox credentials — before relying on it in production.
