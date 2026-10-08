# Commerce EasyTransac — manual setup guide

**Commerce EasyTransac** (`commerce_easytransac`) adds **EasyTransac** as an
off‑site payment gateway for Drupal Commerce. Customers pay on EasyTransac's
hosted, PCI‑compliant payment form — so card data never passes through your
server — and are returned to your site once the transaction completes. It
supports Visa, MasterCard, Maestro and American Express cards, the newer **Pay by
bank** method, **instalment** payments (2, 3 and up to 12 payments on orders over
€50), and **OneClick** payments with a saved card for returning, authenticated
customers.

The module actually provides **two gateways** — EasyTransac (cards, and its
OneClick/instalment options) and EasyTransac **Pay by bank** — both off‑site
redirect gateways. It depends on Commerce's **Payment** module and the
**Address** module (`commerce_payment`, `address`), and on the
`easytransac/easytransac` PHP SDK, which Composer installs for you. Beyond
enabling it, you add a gateway, paste your API key and copy the notification URL
into your EasyTransac application; the module derives test vs live mode
automatically from the key prefix.

Security here is reassuringly solid. Both the browser return and the
server‑to‑server notification verify EasyTransac's **signature** using your
account API key before any payment is trusted; the return also checks that the
order id matches and that the notification's user id matches the order's, and
payment amounts and states are read from the **verified** EasyTransac response
rather than from anything the browser posts. The module also supports capture,
void, refund, and on‑demand status synchronisation from your Drupal back office.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (which pulls in
   the EasyTransac SDK) and enable the module.
2. [Configuration](configuration/index.md) — add the gateway, paste the API key,
   copy the notification URL, and set OneClick/instalment options.

## Where it lives in the admin menu

The gateways are added under **Administration → Commerce → Configuration →
Payment gateways** (`/admin/commerce/config/payment-gateways`). There is also a
module‑wide settings page at **Administration → Commerce → Configuration →
EasyTransac** (`/admin/commerce/config/easytransac`,
`commerce_easytransac.settings`), gated by the *administer commerce easytransac*
permission.
