# Commerce Datatrans — manual setup guide

**Commerce Datatrans** (`commerce_datatrans`) integrates **Datatrans** — a Swiss
payment service provider — as a Drupal Commerce off-site payment gateway. At
checkout the customer is redirected to a Datatrans-hosted payment page, and
Datatrans confirms the result in two ways: on the browser return, and (optionally)
via an asynchronous **server-to-server webhook** notification. It is built on the
Datatrans JSON API and supports settlement, refunds, and card/alias tokenisation
for recurring payments.

The problem it solves is simply accepting payments through Datatrans for merchants
who have a Datatrans contract. You configure your merchant ID, API password, and
the webhook signing key, add the gateway to checkout, and Datatrans handles the
actual card entry.

> **The webhook is HMAC-authenticated.** The notification handler requires the
> `sign2` key to be configured (returning `403` if it is not), reads the
> `Datatrans-Signature` header, recomputes the HMAC over the request body, and
> **rejects** the request if the header is missing or the signature does not match.
> Only after the signature validates — and only for whitelisted statuses
> (`settled`, `transmitted`, `authorized`) — does it mark the order paid. A caller
> cannot produce a valid signature without your `sign2` secret, so keep that key
> confidential and make sure it is set (otherwise the webhook stays inactive).

It depends on **Commerce Payment** (`commerce_payment`) and supports Drupal 10.1
and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — add the Datatrans gateway, enter your
   merchant ID, API password, and `sign2` webhook key, and make sure the webhook is
   active.

## Where it lives in the admin menu

Like every Commerce gateway, Datatrans is added under **Administration → Commerce
→ Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`). The gateway's form is where you enter
your Datatrans credentials.
