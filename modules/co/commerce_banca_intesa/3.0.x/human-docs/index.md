# Commerce Banca Intesa — manual setup guide

**Commerce Banca Intesa** (`commerce_banca_intesa`) is a Drupal Commerce
**off‑site payment gateway** for **Banca Intesa Serbia**, which runs on the
NestPay / Payten platform. At checkout the customer is redirected to the bank's
secure page to pay, then returned to your site, where the module validates the
result and records the payment against the order. It depends on Commerce's Order
and Payment modules (`commerce_order`, `commerce_payment`).

Use it when you need to accept card payments through Banca Intesa Serbia. Like
any off‑site gateway, the important part is what happens on the *return* leg — and
here it is handled correctly. When the shopper comes back, the module checks the
merchant ID against your configuration, verifies the **digital signature** the
bank sends (it recomputes a SHA‑512 hash using your secret **store key** and
rejects the request if it doesn't match), requires the bank's success code
(`ProcReturnCode == 00`), and records the payment for the order's own
server‑side total — never an amount taken from the incoming request. In practice
that means a forged or amount‑tampered return cannot mark an order as paid,
because an attacker would need your secret store key to produce a valid
signature. The practical takeaways for you: keep your **store key** (and the
API **password**) secret, and always run the site over HTTPS.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Commerce dependencies.
2. [Configuration](configuration/index.md) — add the Banca Intesa gateway and
   enter your merchant credentials and store key.

## Where it lives in the admin menu

Commerce Banca Intesa adds no page of its own. You configure it as a gateway
under **Administration → Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`) — see
[Configuration](configuration/index.md).
