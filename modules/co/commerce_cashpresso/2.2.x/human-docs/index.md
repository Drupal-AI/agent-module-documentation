# Commerce cashpresso — manual setup guide

**Commerce cashpresso** (`commerce_cashpresso`) adds an **off‑site payment
gateway** that lets your Drupal Commerce customers **pay by instalments through
cashpresso** (www.cashpresso.com). cashpresso is an instalment‑financing provider,
popular in the German‑speaking market, that lets a shopper split a purchase into
monthly payments — often with a 0% option — after a one‑time registration. This
module wires that experience into Commerce checkout.

At checkout the gateway sends the order to cashpresso's hosted flow, the customer
completes the financing there, and cashpresso reports the result back to your site.
The module can also show a **financing‑cost label on product pages** (an estimate
of the monthly instalment) and offers an optional **direct‑checkout button** —
"finance this now" — that adds an item and jumps straight to checkout. That
direct‑checkout route resolves the price server‑side and is gated by the
`access checkout` permission plus the purchasable entity's own view access.

On the security side, this gateway is soundly built. The **asynchronous status
callback verifies a SHA‑512 verification hash** before it applies any payment
transition, so forged callbacks are rejected; the charged amount is always taken
from the order (`$payment->getAmount()`), never from client input; and outbound
API calls use Guzzle's default TLS verification (enabled). Payment results map
cleanly to Commerce states — cashpresso SUCCESS captures the payment, CANCELLED
voids it, and TIMEOUT expires it.

Commerce cashpresso depends on Commerce **Payment** (`commerce_payment`) and works
on Drupal 10 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Commerce Payment.
2. [Configuration](configuration/index.md) — adding the cashpresso payment gateway
   and entering your API key, secret, and financing options.

## Where it lives in the admin menu

Like every Commerce payment method, cashpresso is set up under **Administration →
Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`). You add a gateway there and choose the
**cashpresso** plugin.
