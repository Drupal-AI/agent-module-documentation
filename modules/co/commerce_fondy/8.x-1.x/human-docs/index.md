# Fondy Commerce Payment Gateway — manual setup guide

**Fondy Commerce Payment Gateway** (`commerce_fondy`) adds an *off-site* payment
gateway for [Fondy](https://www.drupal.org/project/commerce_fondy) to a Drupal
Commerce store. When a shopper reaches the payment step they are redirected to
Fondy's own hosted payment page to enter their card or alternative-payment
details; once they pay, Fondy sends them back to your site and also posts a
server-to-server notification, and the module completes the order.

Fondy is an international acquirer that supports Visa, MasterCard and Maestro
cards plus a range of alternative methods, in 100+ currencies. The advantage of
an off-site gateway like this one is that sensitive card data never touches your
server — Fondy handles the card entry — which keeps your PCI scope small.

The module completes payments safely: both the browser return and the background
notification are verified before the order is marked paid. It confirms the
**signature** Fondy sends against your secret key, checks that the amount Fondy
reports matches the order amount, and then completes the payment using your
order's own total rather than any value taken from the callback. An order is
never completed on an invalid signature or a mismatched amount. It depends only
on Commerce's Payment and core Commerce modules, and works on Drupal 9, 10 and
11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — add the Fondy gateway and enter your
   merchant credentials.

## Where it lives in the admin menu

Fondy has no standalone settings page. Like every Commerce gateway, you add and
configure it under **Administration → Commerce → Configuration → Payment
gateways** (`/admin/commerce/config/payment-gateways`). Click **Add payment
gateway**, choose the Fondy plugin, and fill in your merchant ID and secret key.
See [Configuration](configuration/index.md) for the details.
